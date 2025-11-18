// To parse this JSON data, do
//
//     final convarsationModel = convarsationModelFromJson(jsonString);

import 'dart:convert';

ConvarsationModel convarsationModelFromJson(String str) =>
    ConvarsationModel.fromJson(json.decode(str));

String convarsationModelToJson(ConvarsationModel data) =>
    json.encode(data.toJson());

class ConvarsationModel {
  bool? success;
  String? message;
  List<Datum>? data;

  ConvarsationModel({this.success, this.message, this.data});

  factory ConvarsationModel.fromJson(Map<String, dynamic> json) =>
      ConvarsationModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? chatRoomId;
  String? sender;
  String? receiver;
  String? message;
  bool? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.chatRoomId,
    this.sender,
    this.receiver,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    chatRoomId: json["chatRoomId"],
    sender: json["sender"],
    receiver: json["receiver"],
    message: json["message"],
    isRead: json["isRead"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "chatRoomId": chatRoomId,
    "sender": sender,
    "receiver": receiver,
    "message": message,
    "isRead": isRead,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
