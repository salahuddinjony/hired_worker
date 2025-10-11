import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:servana/view/screens/message/chat/inbox_screen/chat_screen/model/chat_message.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/controller/conversation_controller.dart';
import 'package:servana/view/screens/message/chat/socket_io/repositories/chat_repository.dart';

import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  final String conversationId;
  final String userId;
  final String userRole;
  final ChatRepository repo;
  late final types.User user;

  ChatController({
    required this.conversationId,
    required this.userId,
    required this.userRole,
    ChatRepository? repository,
  }) : repo = repository ?? ChatRepository() {
    // Use role as the author.id so side/layout decisions can be made by role.
    user = types.User(id: userRole, firstName: 'Me');
  }
  
  final messages = RxList<types.Message>(<types.Message>[]);
  final isTyping = false.obs;
  // new loading flag to indicate initial history fetch
  final isLoading = true.obs;

  StreamSubscription<ChatMessage>? msgSub;
  StreamSubscription<Map<String, dynamic>>? typingSub;

  // Helper: determine role for a sender string ID
  String _roleForSender(String senderId, {String fallbackRole = 'other'}) {
    // Since sender is now just a string ID, we need to determine role differently
    // For now, we'll check if it matches current userId to determine if it's our message
    if (senderId == userId) {
      return userRole;
    }
    return fallbackRole;
  }

  // Public helper UI can call to know which side a message should render on.
  // Returns true when message should appear on the "right" (same role as current user).
  bool isMessageRight(types.Message message) {
    try {
      final meta =
          (message as dynamic).metadata as Map<String, dynamic>? ?? {};
      final role = meta['role']?.toString();
      if (role != null && role.isNotEmpty) return role == userRole;
    } catch (_) {}
    // fallback to author id (we store role as author.id now)
    return message.author.id == userRole;
  }

  @override
  void onInit() {
    super.onInit();

    // connect to socket and join room
    repo.connect('http://10.10.20.11:5002');

    // load history first (if available) so UI shows past messages

    // setup user on socket
    repo.setupUser(userId);
    
    isLoading.value = true;
    repo.fetchMessages(conversationId).then((history) {

      // map history messages to flutter_chat_types messages
      // ensure createdAt is milliseconds since epoch
      
      for (final h in history.reversed) {
        // determine role for this history message
        final senderRole = _roleForSender(h.sender, fallbackRole: 'other');

        // Since the new structure doesn't include attachments, create only text messages
        final msg = types.TextMessage(
          author: types.User(
            id: senderRole,
            firstName: 'User', // Generic name since we don't have user details
          ),
          createdAt: h.createdAt.millisecondsSinceEpoch,
          id: h.id.isNotEmpty ? h.id : const Uuid().v4(),
          text: h.message,
          metadata: {'role': senderRole},
        );

        // newest first expected by UI, but we're iterating reversed to keep chronology
        messages.insert(0, msg);
        try {
          debugPrint('[ChatController] inserted history TextMessage id=${msg.id} text=${msg.text}');
        } catch (_) {}
      }
    }).catchError((e) {
      debugPrint('history load error: $e');
    }).whenComplete(() {
      // now join socket to receive live messages
      repo.joinChat(roomId: conversationId, userId: userId);
      // initial load finished (either success or error)
      isLoading.value = false;
    });

    msgSub = repo.onMessage.listen((chatMsg) {
        // Ignore server echoes of messages we just sent: if the incoming chatMsg
        // reports a sender id that matches our userId, it's likely the same
        // message we optimistically added locally. Filtering avoids duplicate
        // display and flicker.
        final incomingSenderId = extractSenderId(chatMsg);
        if (incomingSenderId != null && incomingSenderId == userId) {
          // We sent this message — server echo. Ignore.
          return;
        }
      // chatMsg is ChatMessage from repository
      // determine incoming sender role
      final incomingRole = _roleForSender(chatMsg.sender, fallbackRole: 'other');

      // Avoid duplicates
      if (chatMsg.id.isNotEmpty && messages.any((m) => m.id == chatMsg.id)) return;

      // Since the new structure doesn't include attachments, create only text messages
      final msg = types.TextMessage(
        // Use role as author id for consistent side calculation
        author: types.User(
          id: incomingRole,
          firstName: 'User', // Generic name since we don't have user details
        ),
        createdAt: chatMsg.createdAt.millisecondsSinceEpoch,
        id: chatMsg.id.isNotEmpty ? chatMsg.id : const Uuid().v4(),
        text: chatMsg.message,
        metadata: {'role': incomingRole},
      );

      // newest first
      messages.insert(0, msg);
      try {
        debugPrint('[ChatController] inserted socket TextMessage id=${msg.id} text=${msg.text}');
      } catch (_) {}

      // update inbox preview for this conversation
      updateConversationLastMessage(chatMsg.message,(chatMsg.createdAt).millisecondsSinceEpoch);
    });

    typingSub = repo.onTyping.listen((data) {
      // server sends typing/stop-typing payloads; adapt if needed
      final event = data['event']?.toString() ?? '';
      final sender =
          data['senderId']?.toString() ?? data['userId']?.toString() ?? '';
      if (sender == userId) return; // ignore own typing
      if (data['type'] == 'start' || event == 'typing') {
        isTyping.value = true;
      } else if (data['type'] == 'stop' || event == 'stop-typing') {
        isTyping.value = false;
      } else {
        // some servers emit typing as { conversationId, senderId }
        if (data.containsKey('senderId')) isTyping.value = true;
      }
    });
  }

  @override
  void onClose() {
    msgSub?.cancel();
    typingSub?.cancel();
    repo.stopTyping(conversationId: conversationId, senderId: userId);
    // keep socket alive if other parts use it; otherwise disconnect:
    // _repo.disconnect();
    super.onClose();
  }

  void handleSendPressed(types.PartialText partial) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: partial.text,
      metadata: {'role': userRole},
    );
    messages.insert(0, textMessage);

    // update inbox preview optimistically
    updateConversationLastMessage(partial.text, textMessage.createdAt);

    // emit typing, send message, stop typing
    repo.startTyping(conversationId: conversationId, senderId: userId);
    repo.sendMessage(
      conversationId: conversationId,
      senderId: userId,
      text: partial.text,
      attachment: [],
    );
    repo.stopTyping(conversationId: conversationId, senderId: userId);
  }

  void updateConversationLastMessage(String text, int? createdAt) {
    try {
      if (!Get.isRegistered<ConversationController>()) return;
      final convCtrl = Get.find<ConversationController>();
      final idx =
          convCtrl.conversationList.indexWhere((c) => c.id == conversationId);
      if (idx == -1) return;
      final convo = convCtrl.conversationList[idx];

      // Try to assign fields (works if model fields are mutable)
      try {
        (convo as dynamic).lastMessage = text;
        (convo as dynamic).lastMessageTime = DateTime.fromMillisecondsSinceEpoch(createdAt ?? DateTime.now().millisecondsSinceEpoch).toIso8601String();
        // reassign to trigger RxList change
        convCtrl.conversationList[idx] = convo;
        return;
      } catch (_) {}

      // If fields are immutable/no setters, just trigger UI refresh as a fallback
      convCtrl.conversationList.refresh();
    } catch (e) {
      print('[ChatController] _updateConversationLastMessage error: $e');
    }
  }

  /// Call while editing to send typing events (debounce outside for live typing)
  void sendTypingStart() =>
      repo.startTyping(conversationId: conversationId, senderId: userId);

  void sendTypingStop() =>
      repo.stopTyping(conversationId: conversationId, senderId: userId);

  /// Extracts the senderId from a ChatMessage, handling possible nulls.
  String? extractSenderId(ChatMessage chatMsg) {
    try {
      // In the new structure, sender is already a string ID
      if (chatMsg.sender.isNotEmpty) {
        return chatMsg.sender;
      }
    } catch (_) {}
    return null;
  }
}
