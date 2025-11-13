class WithdrawHistoryModel {
  bool? success;
  String? message;
  Data? data;

  WithdrawHistoryModel({this.success, this.message, this.data});

  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) =>
      WithdrawHistoryModel(
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
  int? total;
  int? page;
  int? limit;
  List<WithdrawalData>? withdrawals;

  Data({this.total, this.page, this.limit, this.withdrawals});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    withdrawals:
        json["withdrawals"] == null
            ? []
            : List<WithdrawalData>.from(
              json["withdrawals"]!.map((x) => WithdrawalData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "withdrawals":
        withdrawals == null
            ? []
            : List<dynamic>.from(withdrawals!.map((x) => x.toJson())),
  };
}

class WithdrawalData {
  String? id;
  String? userId;
  String? payoutId;
  int? amount;
  DateTime? date;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  WithdrawalData({
    this.id,
    this.userId,
    this.payoutId,
    this.amount,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory WithdrawalData.fromJson(Map<String, dynamic> json) => WithdrawalData(
    id: json["_id"],
    userId: json["userId"],
    payoutId: json["payoutId"],
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    status: json["status"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "payoutId": payoutId,
    "amount": amount,
    "date": date?.toIso8601String(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
