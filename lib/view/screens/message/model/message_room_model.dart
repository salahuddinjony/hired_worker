// To parse this JSON data, do
//
//     final allMessageRoomModel = allMessageRoomModelFromJson(jsonString);

import 'dart:convert';

AllMessageRoomModel allMessageRoomModelFromJson(String str) =>
    AllMessageRoomModel.fromJson(json.decode(str));

String allMessageRoomModelToJson(AllMessageRoomModel data) =>
    json.encode(data.toJson());

class AllMessageRoomModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Datum>? data;

  AllMessageRoomModel({this.success, this.message, this.meta, this.data});

  factory AllMessageRoomModel.fromJson(Map<String, dynamic> json) =>
      AllMessageRoomModel(
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  List<String>? participants;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? otherUserName;
  String? otherUserImage;
  String? otherUserId;
  String? lastMessage;
  DateTime? lastMessageTime;

  Datum({
    this.id,
    this.participants,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.otherUserName,
    this.otherUserImage,
    this.otherUserId,
    this.lastMessage,
    this.lastMessageTime,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    participants:
        json["participants"] == null
            ? []
            : List<String>.from(json["participants"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    otherUserName: json["otherUserName"],
    otherUserImage: json["otherUserImage"],
    otherUserId: json["otherUserId"],
    lastMessage: json["lastMessage"],
    lastMessageTime:
        json["lastMessageTime"] == null
            ? null
            : DateTime.parse(json["lastMessageTime"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "participants":
        participants == null
            ? []
            : List<dynamic>.from(participants!.map((x) => x)),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "otherUserName": otherUserName,
    "otherUserImage": otherUserImage,
    "otherUserId": otherUserId,
    "lastMessage": lastMessage,
    "lastMessageTime": lastMessageTime?.toIso8601String(),
  };
}

class Meta {
  int? page;
  int? limit;
  int? total;
  int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    limit: json["limit"],
    total: json["total"],
    totalPage: json["totalPage"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "limit": limit,
    "total": total,
    "totalPage": totalPage,
  };
}
