import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  SocketService._internal();
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  IO.Socket? _socket;

  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final _typingController = StreamController<Map<String, dynamic>>.broadcast();
  final _receiverOnlineController = StreamController<Map<String, dynamic>>.broadcast();
  final _newMessageNotificationController= StreamController<Map<String, dynamic>>.broadcast(); 
  final _userJoinedRoomController = StreamController<Map<String, dynamic>>.broadcast();
  final _userLeftRoomController = StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get onMessage => _messageController.stream;
  Stream<Map<String, dynamic>> get onTyping => _typingController.stream;
  Stream<Map<String, dynamic>> get onReceiverOnline => _receiverOnlineController.stream;
  Stream<Map<String, dynamic>> get onNewMessageNotification => _newMessageNotificationController.stream;
  Stream<Map<String, dynamic>> get onUserJoinedRoom => _userJoinedRoomController.stream;
  Stream<Map<String, dynamic>> get onUserLeftRoom => _userLeftRoomController.stream;


  void connect(String url) {
    if (_socket != null && _socket!.connected) return;

    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket!.on('connect', (_) {
      print('[SocketService] 🟢 CONNECTED to server');
      print('[SocketService] 🆔 Socket ID: ${_socket!.id}');
    });
    _socket!.on('disconnect', (_) {
      print('[SocketService] 🔴 DISCONNECTED from server');
    });
    _socket!.on('connect_error', (err) {
      print('[SocketService] ❌ CONNECTION ERROR: $err');
    });


// setup user 

    _socket!.on('setup', (data) {
      print('[SocketService] setup: $data');
      if (data is Map) {
        // Handle setup data if needed
      }
    });

    // Incoming message events - listen for 'newMessage' event
    _socket!.on('newMessage', (data) {
      print('[SocketService] 📨 RECEIVED newMessage: $data');
      print('[SocketService] 📨 Data type: ${data.runtimeType}');
      if (data is Map) {
        final messageData = Map<String, dynamic>.from(data);
        print('[SocketService] 📨 Processing message: ${messageData['message']}');
        _messageController.add(messageData);
      } else {
        print('[SocketService] ❌ Received data is not a Map: $data');
      }
    });

    // Typing events
    _socket!.on('typing', (data) {
      if (data is Map) _typingController.add(Map<String, dynamic>.from(data));
    });

    // Stop typing event
    _socket!.on('stop-typing', (data) {
      if (data is Map) _typingController.add(Map<String, dynamic>.from(data));
    });

    // Receiver online status
    _socket!.on('receiver-online', (data) {
      if (data is Map) _receiverOnlineController.add(Map<String, dynamic>.from(data));
    });

    // New message notification
    _socket!.on('new-message-notification', (data) {
      if (data is Map) _newMessageNotificationController.add(Map<String, dynamic>.from(data));
    });

    // User joined/left room events
    _socket!.on('user-joined', (data) {
      if (data is Map) _userJoinedRoomController.add(Map<String, dynamic>.from(data));
    });
    _socket!.on('user-left', (data) {
      if (data is Map) _userLeftRoomController.add(Map<String, dynamic>.from(data));
    });

    
  }

  void disconnect() {
    _socket?.disconnect();
    _socket = null;
  }

  /// Generic emitter used by repositories for custom events (fixes emitRaw missing error).
  void emitRaw(String event, [dynamic data]) {
    if (_socket == null) {
      print('[SocketService] ❌ emitRaw: socket is null, event=$event');
      return;
    }
    if (!_socket!.connected) {
      print('[SocketService] ❌ emitRaw: socket not connected, event=$event');
      return;
    }
    try {
      print('[SocketService] 📤 EMITTING EVENT: $event with data: $data');
      _socket!.emit(event, data);
      print('[SocketService] ✅ EVENT EMITTED SUCCESSFULLY: $event');
    } catch (e) {
      print('[SocketService] ❌ emitRaw error: $e');
    }
  }
  void setupUser(String userId) {
    emitRaw('setup', userId); 
  }
  void leaveChat({required String roomId, required String userId}) {
    emitRaw('leave-chat', {'roomId': roomId, 'userId': userId});
  }

  void joinChat({required String roomId, required String userId}) {
    emitRaw('join-chat', {'roomId': roomId, 'userId': userId});
  }

  void startTyping({required String conversationId, required String senderId}) {
    emitRaw('typing', {'conversationId': conversationId, 'senderId': senderId});
  }

  void stopTyping({required String conversationId, required String senderId}) {
    emitRaw('stop-typing', {'conversationId': conversationId, 'senderId': senderId});
  }

  void sendMessage({
    required String conversationId,
    required String senderId,
    required String text,
    List<String>? attachment,
    String? receiverId,
  }) {
    final payload = {
      'sender': senderId,
      'receiver': receiverId ?? '',
      'message': text,
      'chatRoomId': conversationId,
    };
    print('[SocketService] 🚀 SENDING MESSAGE: $payload');
    print('[SocketService] 📡 Socket connected: ${_socket?.connected}');
    emitRaw('sendMessage', payload);
  }

  void dispose() {
    _messageController.close();
    _typingController.close();
    disconnect();
  }

  // Helper method to check connection status
  bool get isConnected => _socket?.connected ?? false;
  String get socketId => _socket?.id ?? 'No ID';
}