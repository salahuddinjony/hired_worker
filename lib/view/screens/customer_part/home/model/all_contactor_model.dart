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
      data:
          (json['data'] as List<dynamic>?)
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
  final SubCategoryModel subCategory;
  final CategoryModel category;
  final String skillsCategory;
  final int ratings;
  final String subscriptionStatus;
  final String customerId;
  final String paymentMethodId;
  final MyScheduleModel? myScheduleId;
  final String? subscriptionId;
  final bool hasActiveSubscription;
  final bool isDeleted;
  final List<String> skills;
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
    required this.subCategory,
    required this.category,
    required this.skillsCategory,
    required this.ratings,
    required this.subscriptionStatus,
    required this.customerId,
    required this.paymentMethodId,
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
      // category and subCategory can come as objects or as ids/strings
      category: CategoryModel.fromDynamic(json['category']),
      subCategory: SubCategoryModel.fromDynamic(json['subCategory']),
      skillsCategory: json['skillsCategory'] ?? '',
      ratings: json['ratings'] ?? 0,
      subscriptionStatus: json['subscriptionStatus'] ?? '',
      customerId: json['customerId'] ?? '',
      paymentMethodId: json['paymentMethodId'] ?? '',
      myScheduleId:
          (() {
            final raw = json['myScheduleId'];
            if (raw == null) return null;
            if (raw is String) {
              // sometimes API might return an id string
              return MyScheduleModel(
                id: raw,
                contractorId: '',
                schedules: [],
                createdAt: '',
                updatedAt: '',
                v: 0,
              );
            }
            if (raw is Map<String, dynamic>)
              return MyScheduleModel.fromJson(raw);
            // fallback
            return MyScheduleModel(
              id: raw.toString(),
              contractorId: '',
              schedules: [],
              createdAt: '',
              updatedAt: '',
              v: 0,
            );
          })(),
      subscriptionId: json['subscriptionId'],
      hasActiveSubscription: json['hasActiveSubscription'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      // parse skills which can be: null, a JSON list, or a string like "[painting, installing]"
      skills:
          (() {
            final raw = json['skills'];
            if (raw == null) return <String>[];
            if (raw is List) return raw.map((e) => e.toString()).toList();
            if (raw is String) {
              var s = raw.trim();
              // remove surrounding brackets if present
              if (s.startsWith('[') && s.endsWith(']')) {
                s = s.substring(1, s.length - 1);
              }
              if (s.isEmpty) return <String>[];
              return s
                  .split(',')
                  .map((e) => e.trim().replaceAll(RegExp(r'^"|"$'), ''))
                  .where((e) => e.isNotEmpty)
                  .toList();
            }
            // fallback: convert other types to single-string list
            return [raw.toString()];
          })(),
      // Some API responses contain null entries inside `materials` list
      // or the whole field may be null. We should safely skip nulls
      // and only map valid objects to avoid runtime parse errors.
      materials: (() {
        final raw = json['materials'];
        if (raw == null) return <MaterialModel>[];
        if (raw is List) {
          return raw
              .where((e) => e != null && e is Map<String, dynamic>)
              .map<MaterialModel>((e) => MaterialModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return <MaterialModel>[];
      })(),
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

// New model to represent category which sometimes comes as object and sometimes as string/id
class CategoryModel {
  final String id;
  final String name;
  final String img;

  CategoryModel({required this.id, required this.name, required this.img});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }

  // Accept either String or Map
  static CategoryModel fromDynamic(dynamic value) {
    if (value == null) return CategoryModel(id: '', name: '', img: '');
    if (value is String) {
      return CategoryModel(id: value, name: '', img: '');
    }
    if (value is Map<String, dynamic>) return CategoryModel.fromJson(value);
    // fallback for other types
    return CategoryModel(id: value.toString(), name: '', img: '');
  }
}

class SubCategoryModel {
  final String id;
  final String categoryId;
  final String name;
  final String img;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.img,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['_id'] ?? json['id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }

  static SubCategoryModel fromDynamic(dynamic value) {
    if (value == null)
      return SubCategoryModel(id: '', categoryId: '', name: '', img: '');
    if (value is String) {
      return SubCategoryModel(id: value, categoryId: '', name: '', img: '');
    }
    if (value is Map<String, dynamic>) return SubCategoryModel.fromJson(value);
    return SubCategoryModel(
      id: value.toString(),
      categoryId: '',
      name: '',
      img: '',
    );
  }
}

// Model for contractor schedule returned as `myScheduleId` in some responses
class MyScheduleModel {
  final String id;
  final String contractorId;
  final List<ScheduleModel> schedules;
  final String createdAt;
  final String updatedAt;
  final int v;

  MyScheduleModel({
    required this.id,
    required this.contractorId,
    required this.schedules,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MyScheduleModel.fromJson(Map<String, dynamic> json) {
    return MyScheduleModel(
      id: json['_id'] ?? json['id'] ?? '',
      contractorId: json['contractorId'] ?? '',
      schedules:
          (json['schedules'] as List<dynamic>?)
              ?.map((e) => ScheduleModel.fromJson(e))
              .toList() ??
          [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

class ScheduleModel {
  final String id;
  final String days;
  final List<String> timeSlots;

  ScheduleModel({
    required this.id,
    required this.days,
    required this.timeSlots,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['_id'] ?? json['id'] ?? '',
      days: json['days'] ?? '',
      timeSlots:
          (json['timeSlots'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }
}
