import 'package:servana/view/screens/customer_part/home/model/location_model.dart';

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
  final LocationModel? location;
  final int rateHourly;
  final double balance;
  final List<SubCategoryModel> subCategory;
  final CategoryModel? category;
  final String skillsCategory;
  final double ratings;
  final String subscriptionStatus;
  final String customerId;
  final String paymentMethodId;
  final MyScheduleModel? myScheduleId;
  final String? subscriptionId;
  final bool hasActiveSubscription;
  final bool isDeleted;
  final List<String> skills;
  final List<MaterialsModel> materials;
  final String createdAt;
  final String updatedAt;
  final UserId userId;
  final bool? isHomeSelect;
  final String? adminAccept;
  final String? subscriptionEndDate;
  final String? subscriptionStartDate;

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
    this.isHomeSelect,
    this.adminAccept,
    this.subscriptionEndDate,
    this.subscriptionStartDate,
  });

  factory allContractor.fromJson(Map<String, dynamic> json) {
    // subCategory can be a list or a single object or missing
    List<SubCategoryModel> subCategoryList = [];
    final subCatRaw = json['subCategory'];
    if (subCatRaw == null) {
      subCategoryList = [];
    } else if (subCatRaw is List) {
      subCategoryList = subCatRaw
          .where((e) => e != null && e is Map<String, dynamic>)
          .map<SubCategoryModel>((e) => SubCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } else if (subCatRaw is Map<String, dynamic>) {
      subCategoryList = [SubCategoryModel.fromJson(subCatRaw)];
    } else {
      subCategoryList = [];
    }

    // category can be null or object
    CategoryModel? categoryModel;
    if (json['category'] != null && json['category'] is Map<String, dynamic>) {
      categoryModel = CategoryModel.fromJson(json['category']);
    } else if (json['category'] != null && json['category'] is String) {
      categoryModel = CategoryModel(id: json['category'], name: '', img: '');
    } else {
      categoryModel = null;
    }

    // skills can be a list or a string
    List<String> skillsList = (() {
      final raw = json['skills'];
      if (raw == null) return <String>[];
      if (raw is List) return raw.map((e) => e.toString()).toList();
      if (raw is String) {
        var s = raw.trim();
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
      return [raw.toString()];
    })();

    // materials
    List<MaterialsModel> materialsList = (() {
      final raw = json['materials'];
      if (raw == null) return <MaterialsModel>[];
      if (raw is List) {
        return raw
            .where((e) => e != null && e is Map<String, dynamic>)
            .map<MaterialsModel>((e) => MaterialsModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return <MaterialsModel>[];
    })();

    // myScheduleId
    MyScheduleModel? scheduleModel;
    final rawSchedule = json['myScheduleId'];
    if (rawSchedule == null) {
      scheduleModel = null;
    } else if (rawSchedule is String) {
      scheduleModel = MyScheduleModel(
        id: rawSchedule,
        contractorId: '',
        schedules: [],
        createdAt: '',
        updatedAt: '',
        v: 0,
      );
    } else if (rawSchedule is Map<String, dynamic>) {
      scheduleModel = MyScheduleModel.fromJson(rawSchedule);
    } else {
      scheduleModel = MyScheduleModel(
        id: rawSchedule.toString(),
        contractorId: '',
        schedules: [],
        createdAt: '',
        updatedAt: '',
        v: 0,
      );
    }

    // userId
    UserId userIdModel = UserId.fromJson(json['userId'] ?? {});

    LocationModel? locationModel;
    final rawLocation = json['location'];
    if (rawLocation == null) {
      locationModel = null;
    } else if (rawLocation is Map<String, dynamic>) {
      locationModel = LocationModel.fromJson(rawLocation);
    } else if (rawLocation is String) {
      locationModel = LocationModel(address: rawLocation);
    } else {
      locationModel = LocationModel(address: rawLocation.toString());
    }

    return allContractor(
      id: json['_id'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      experience: json['experience'] ?? '',
      bio: json['bio'] ?? '',
      city: json['city'] ?? '',
      language: json['language'] ?? '',
      location: locationModel,
      rateHourly: (json['rateHourly'] ?? 0).toInt(),
      balance: (json['balance'] ?? 0).toDouble(),
      subCategory: subCategoryList,
      category: categoryModel,
      skillsCategory: json['skillsCategory'] ?? '',
      ratings: (json['ratings'] ?? 0).toDouble(),
      subscriptionStatus: json['subscriptionStatus'] ?? '',
      customerId: json['customerId'] ?? '',
      paymentMethodId: json['paymentMethodId'] ?? '',
      myScheduleId: scheduleModel,
      subscriptionId: json['subscriptionId'],
      hasActiveSubscription: json['hasActiveSubscription'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      skills: skillsList,
      materials: materialsList,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      userId: userIdModel,
      isHomeSelect: json['isHomeSelect'],
      adminAccept: json['userId'] != null && json['userId'] is Map<String, dynamic> ? json['userId']['adminAccept'] : null,
      subscriptionEndDate: json['subscriptionEndDate'],
      subscriptionStartDate: json['subscriptionStartDate'],
    );
  }
}

class MaterialsModel {
  final String name;
  final String unit;
  final int price;
  final String id;

  MaterialsModel({
    required this.name,
    required this.unit,
    required this.price,
    required this.id,
  });

  factory MaterialsModel.fromJson(Map<String, dynamic> json) {
    return MaterialsModel(
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
