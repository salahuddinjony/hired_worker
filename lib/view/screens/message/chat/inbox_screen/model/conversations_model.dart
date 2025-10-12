// ...existing code...
import 'dart:convert';

class ConversationResponse {
  final bool success;
  final String? message;
  final Meta? meta;
  final List<Conversation> data;

  ConversationResponse({
    required this.success,
    this.message,
    this.meta,
    List<Conversation>? data,
  }) : data = data ?? [];

  factory ConversationResponse.fromJson(Map<String, dynamic> json) {
    return ConversationResponse(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String?,
      meta: json['meta'] != null ? Meta.fromJson(json['meta'] as Map<String, dynamic>) : null,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => Conversation.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'meta': meta?.toJson(),
        'data': data.map((e) => e.toJson()).toList(),
      };

  @override
  String toString() => jsonEncode(toJson());
}

class Meta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] as int? ?? 1,
      limit: json['limit'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
      totalPage: json['totalPage'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'page': page,
        'limit': limit,
        'total': total,
        'totalPage': totalPage,
      };
}

class Participant {
  final String id;
  final String fullName;
  final String? img;

  Participant({
    required this.id,
    required this.fullName,
    this.img,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['_id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      img: json['img'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'fullName': fullName,
        'img': img,
      };
}

class Conversation {
  final String id;
  final List<Participant> participants;
  final bool isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final String? otherUserName;
  final String? otherUserImage;
  final String? otherUserId;
  final String? lastMessage;
  final String? lastMessageTime;

  Conversation({
    String? id,
    List<Participant>? participants,
    bool? isDeleted,
    this.createdAt,
    this.updatedAt,
    this.otherUserName,
    this.otherUserImage,
    this.otherUserId,
    this.lastMessage,
    this.lastMessageTime,
  })  : id = id ?? '',
        participants = participants ?? [],
        isDeleted = isDeleted ?? false;

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: (json['_id'] as String?) ?? '',
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => Participant.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      otherUserName: json['otherUserName'] as String?,
      otherUserImage: json['otherUserImage'] as String?,
      otherUserId: json['otherUserId'] as String?,
      lastMessage: json['lastMessage'] as String?,
      lastMessageTime: json['lastMessageTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'participants': participants.map((p) => p.toJson()).toList(),
        'isDeleted': isDeleted,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'otherUserName': otherUserName,
        'otherUserImage': otherUserImage,
        'otherUserId': otherUserId,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime,
      };
}
// ...existing code...