class ContractorResponse {
  final bool success;
  final String message;
  final Meta meta;
  final List<allContractor> data;

  ContractorResponse({
    required this.success,
    required this.message,
    required this.meta,
    required this.data,
  });

  factory ContractorResponse.fromJson(Map<String, dynamic> json) {
    return ContractorResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: Meta.fromJson(json['meta'] ?? {}),
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => allContractor.fromJson(e))
              .toList() ??
          [],
    );
  }
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
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}

class allContractor {
  final String id;
  final String dob;
  final String gender;
  final String experience;
  final String bio;
  final String city;
  final String language;
  final String location;
  final int rateHourly;
  final int balance;
  final String skillsCategory;
  final int ratings;
  final String subscriptionStatus;
  final String customerId;
  final String paymentMethodId;
  final List<String> certificates;
  final String? myScheduleId;
  final String? subscriptionId;
  final bool hasActiveSubscription;
  final bool isDeleted;
  final dynamic skills; // because sometimes it's a string, sometimes list
  final List<MaterialModel> materials;
  final String createdAt;
  final String updatedAt;
  final UserId userId;

  allContractor({
    required this.id,
    required this.dob,
    required this.gender,
    required this.experience,
    required this.bio,
    required this.city,
    required this.language,
    required this.location,
    required this.rateHourly,
    required this.balance,
    required this.skillsCategory,
    required this.ratings,
    required this.subscriptionStatus,
    required this.customerId,
    required this.paymentMethodId,
    required this.certificates,
    required this.myScheduleId,
    required this.subscriptionId,
    required this.hasActiveSubscription,
    required this.isDeleted,
    required this.skills,
    required this.materials,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory allContractor.fromJson(Map<String, dynamic> json) {
    return allContractor(
      id: json['_id'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      experience: json['experience'] ?? '',
      bio: json['bio'] ?? '',
      city: json['city'] ?? '',
      language: json['language'] ?? '',
      location: json['location'] ?? '',
      rateHourly: json['rateHourly'] ?? 0,
      balance: json['balance'] ?? 0,
      skillsCategory: json['skillsCategory'] ?? '',
      ratings: json['ratings'] ?? 0,
      subscriptionStatus: json['subscriptionStatus'] ?? '',
      customerId: json['customerId'] ?? '',
      paymentMethodId: json['paymentMethodId'] ?? '',
      certificates: (json['certificates'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      myScheduleId: json['myScheduleId'],
      subscriptionId: json['subscriptionId'],
      hasActiveSubscription: json['hasActiveSubscription'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      skills: json['skills'] ?? [],
      materials: (json['materials'] as List<dynamic>?)
              ?.map((e) => MaterialModel.fromJson(e))
              .toList() ??
          [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      userId: UserId.fromJson(json['userId'] ?? {}),
    );
  }
}

class MaterialModel {
  final String name;
  final String unit;
  final int price;
  final String id;

  MaterialModel({
    required this.name,
    required this.unit,
    required this.price,
    required this.id,
  });

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      price: json['price'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}

class UserId {
  final String id;
  final String fullName;
  final String email;
  final String contactNo;
  final bool otpVerified;
  final String img;
  final String role;
  final String status;
  final String contractor;
  final bool isDeleted;
  final String passwordChangedAt;
  final String createdAt;
  final String updatedAt;
  final int v;

  UserId({
    required this.id,
    required this.fullName,
    required this.email,
    required this.contactNo,
    required this.otpVerified,
    required this.img,
    required this.role,
    required this.status,
    required this.contractor,
    required this.isDeleted,
    required this.passwordChangedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      contactNo: json['contactNo'] ?? '',
      otpVerified: json['otpVerified'] ?? false,
      img: json['img'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      contractor: json['contractor'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      passwordChangedAt: json['passwordChangedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
