// To parse this JSON data, do
//
//     final getAllContactorModel = getAllContactorModelFromJson(jsonString);

import 'dart:convert';

GetAllContactorModel getAllContactorModelFromJson(String str) =>
    GetAllContactorModel.fromJson(json.decode(str));

String getAllContactorModelToJson(GetAllContactorModel data) =>
    json.encode(data.toJson());

class GetAllContactorModel {
  bool? success;
  String? message;
  Meta? meta;
  List<Datum>? data;

  GetAllContactorModel({this.success, this.message, this.meta, this.data});

  factory GetAllContactorModel.fromJson(Map<String, dynamic> json) =>
      GetAllContactorModel(
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
  String? dob;
  Gender? gender;
  String? experience;
  String? bio;
  City? city;
  String? language;
  String? location;
  int? rateHourly;
  String? skillsCategory;
  int? ratings;
  String? subscriptionStatus;
  String? customerId;
  String? paymentMethodId;
  List<String>? certificates;
  String? myScheduleId;
  bool? isDeleted;
  List<String>? skills;
  List<Material>? materials;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserId? userId;

  Datum({
    this.id,
    this.dob,
    this.gender,
    this.experience,
    this.bio,
    this.city,
    this.language,
    this.location,
    this.rateHourly,
    this.skillsCategory,
    this.ratings,
    this.subscriptionStatus,
    this.customerId,
    this.paymentMethodId,
    this.certificates,
    this.myScheduleId,
    this.isDeleted,
    this.skills,
    this.materials,
    this.createdAt,
    this.updatedAt,
    this.userId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    dob: json["dob"],
    gender: genderValues.map[json["gender"]]!,
    experience: json["experience"],
    bio: json["bio"],
    city: cityValues.map[json["city"]]!,
    language: json["language"],
    location: json["location"],
    rateHourly: json["rateHourly"],
    skillsCategory: json["skillsCategory"],
    ratings: json["ratings"],
    subscriptionStatus: json["subscriptionStatus"],
    customerId: json["customerId"],
    paymentMethodId: json["paymentMethodId"],
    certificates:
        json["certificates"] == null
            ? []
            : List<String>.from(json["certificates"]!.map((x) => x)),
    myScheduleId: json["myScheduleId"],
    isDeleted: json["isDeleted"],
    skills:
        json["skills"] == null
            ? []
            : List<String>.from(json["skills"]!.map((x) => x)),
    materials:
        json["materials"] == null
            ? []
            : List<Material>.from(
              json["materials"]!.map((x) => Material.fromJson(x)),
            ),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "dob": dob,
    "gender": genderValues.reverse[gender],
    "experience": experience,
    "bio": bio,
    "city": cityValues.reverse[city],
    "language": language,
    "location": location,
    "rateHourly": rateHourly,
    "skillsCategory": skillsCategory,
    "ratings": ratings,
    "subscriptionStatus": subscriptionStatus,
    "customerId": customerId,
    "paymentMethodId": paymentMethodId,
    "certificates":
        certificates == null
            ? []
            : List<dynamic>.from(certificates!.map((x) => x)),
    "myScheduleId": myScheduleId,
    "isDeleted": isDeleted,
    "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
    "materials":
        materials == null
            ? []
            : List<dynamic>.from(materials!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "userId": userId?.toJson(),
  };
}

enum City { EMPTY, NAI }

final cityValues = EnumValues({"": City.EMPTY, "nai": City.NAI});

enum Gender { EMPTY, FEMALE }

final genderValues = EnumValues({"": Gender.EMPTY, "Female": Gender.FEMALE});

class Material {
  String? name;
  String? unit;
  int? price;
  String? id;

  Material({this.name, this.unit, this.price, this.id});

  factory Material.fromJson(Map<String, dynamic> json) => Material(
    name: json["name"],
    unit: json["unit"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "unit": unit,
    "price": price,
    "_id": id,
  };
}

class UserId {
  String? id;
  String? fullName;
  String? email;
  String? contactNo;
  bool? otpVerified;
  String? img;
  String? role;
  String? status;
  String? contractor;
  bool? isDeleted;
  DateTime? passwordChangedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserId({
    this.id,
    this.fullName,
    this.email,
    this.contactNo,
    this.otpVerified,
    this.img,
    this.role,
    this.status,
    this.contractor,
    this.isDeleted,
    this.passwordChangedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    contactNo: json["contactNo"],
    otpVerified: json["otpVerified"],
    img: json["img"],
    role: json["role"],
    status: json["status"],
    contractor: json["contractor"],
    isDeleted: json["isDeleted"],
    passwordChangedAt:
        json["passwordChangedAt"] == null
            ? null
            : DateTime.parse(json["passwordChangedAt"]),
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "contactNo": contactNo,
    "otpVerified": otpVerified,
    "img": img,
    "role": role,
    "status": status,
    "contractor": contractor,
    "isDeleted": isDeleted,
    "passwordChangedAt": passwordChangedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
