// To parse this JSON data, do
//
//     final withdrawModel = withdrawModelFromJson(jsonString);

import 'dart:convert';

WithdrawModel withdrawModelFromJson(String str) =>
    WithdrawModel.fromJson(json.decode(str));

String withdrawModelToJson(WithdrawModel data) => json.encode(data.toJson());

class WithdrawModel {
  bool? success;
  String? message;
  Data? data;

  WithdrawModel({this.success, this.message, this.data});

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  bool? success;
  String? message;
  String? transferId;
  String? withdrawalId;
  String? url;

  Data({
    this.success,
    this.message,
    this.transferId,
    this.withdrawalId,
    this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"],
    message: json["message"],
    transferId: json["transferId"],
    withdrawalId: json["withdrawalId"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "transferId": transferId,
    "withdrawalId": withdrawalId,
    "url": url,
  };
}
