class SubscriptionPlanModel {
  bool? success;
  String? message;
  List<SubscriptionPlan>? data;

  SubscriptionPlanModel({
    this.success,
    this.message,
    this.data,
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) => SubscriptionPlanModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<SubscriptionPlan>.from(json["data"]!.map((x) => SubscriptionPlan.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SubscriptionPlan {
  String? id;
  String? planType;
  int? price;
  String? duration;
  List<String>? details;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SubscriptionPlan({
    this.id,
    this.planType,
    this.price,
    this.duration,
    this.details,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    id: json["_id"],
    planType: json["planType"],
    price: json["price"],
    duration: json["duration"],
    details: json["details"] == null ? [] : List<String>.from(json["details"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "planType": planType,
    "price": price,
    "duration": duration,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
