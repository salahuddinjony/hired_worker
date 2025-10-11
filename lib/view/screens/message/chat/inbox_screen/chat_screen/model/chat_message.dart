import 'package:meta/meta.dart';

@immutable
class MessagesResponse {
  final bool success;
  final String message;
  final List<ChatMessage> data;

  const MessagesResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      success: json['success'] as bool? ?? false,
      message: json['message']?.toString() ?? '',
      data: (json['data'] is List)
          ? List<ChatMessage>.from((json['data'] as List).map((e) => ChatMessage.fromJson(e as Map<String, dynamic>)))
          : <ChatMessage>[],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data.map((e) => e.toJson()).toList(),
      };
}

@immutable
class ChatMessage {
  final String id; // maps to _id
  final String chatRoomId;
  final String sender; // sender id as string
  final String receiver; // receiver id as string
  final String message; // message text
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v; // __v

  const ChatMessage({
    required this.id,
    required this.chatRoomId,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    DateTime parseDate(dynamic v) {
      if (v is String) {
        return DateTime.tryParse(v) ?? DateTime.now();
      } else if (v is int) {
        return DateTime.fromMillisecondsSinceEpoch(v);
      } else {
        return DateTime.now();
      }
    }

    return ChatMessage(
      id: json['_id']?.toString() ?? '',
      chatRoomId: json['chatRoomId']?.toString() ?? '',
      sender: json['sender']?.toString() ?? '',
      receiver: json['receiver']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      isRead: json['isRead'] as bool? ?? false,
      createdAt: parseDate(json['createdAt']),
      updatedAt: parseDate(json['updatedAt']),
      v: (json['__v'] is int) ? json['__v'] as int : int.tryParse('${json['__v']}') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'chatRoomId': chatRoomId,
        'sender': sender,
        'receiver': receiver,
        'message': message,
        'isRead': isRead,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        '__v': v,
      };
}