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
  int? slNo;
  String? subscriptionPlan;
  String? price;
  String? duration;
  String? contractorFeePerMonth;
  String? action;

  SubscriptionPlan({
    this.slNo,
    this.subscriptionPlan,
    this.price,
    this.duration,
    this.contractorFeePerMonth,
    this.action,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
    slNo: json["slNo"],
    subscriptionPlan: json["subscriptionPlan"],
    price: json["price"],
    duration: json["duration"],
    contractorFeePerMonth: json["contractorFeePerMonth"],
    action: json["action"],
  );

  Map<String, dynamic> toJson() => {
    "slNo": slNo,
    "subscriptionPlan": subscriptionPlan,
    "price": price,
    "duration": duration,
    "contractorFeePerMonth": contractorFeePerMonth,
    "action": action,
  };
}
