// To parse this JSON data, do
//
//     final contractorModel = contractorModelFromJson(jsonString);

import 'dart:convert';

ContractorModel contractorModelFromJson(String str) => ContractorModel.fromJson(json.decode(str));

String contractorModelToJson(ContractorModel data) => json.encode(data.toJson());

class ContractorModel {
    bool? success;
    String? message;
    Data? data;

    ContractorModel({
        this.success,
        this.message,
        this.data,
    });

    factory ContractorModel.fromJson(Map<String, dynamic> json) => ContractorModel(
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
    String? id;
    String? fullName;
    String? email;
    String? contactNo;
    bool? otpVerified;
    String? img;
    String? role;
    String? status;
    Contractor? contractor;
    bool? isDeleted;
    DateTime? passwordChangedAt;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        contactNo: json["contactNo"],
        otpVerified: json["otpVerified"],
        img: json["img"],
        role: json["role"],
        status: json["status"],
        contractor: json["contractor"] == null ? null : Contractor.fromJson(json["contractor"]),
        isDeleted: json["isDeleted"],
        passwordChangedAt: json["passwordChangedAt"] == null ? null : DateTime.parse(json["passwordChangedAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "contractor": contractor?.toJson(),
        "isDeleted": isDeleted,
        "passwordChangedAt": passwordChangedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Contractor {
    String? dob;
    String? language;
    String? id;
    String? location;
    int? rateHourly;
    String? skillsCategory;
    int? ratings;
    String? subscriptionStatus;
    String? customerId;
    String? paymentMethodId;
    List<String>? certificates;
    bool? isDeleted;
    List<String>? skills;
    List<Material>? materials;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? myScheduleId;
    String? gender;
    String? city;

    Contractor({
        this.dob,
        this.language,
        this.id,
        this.location,
        this.rateHourly,
        this.skillsCategory,
        this.ratings,
        this.subscriptionStatus,
        this.customerId,
        this.paymentMethodId,
        this.certificates,
        this.isDeleted,
        this.skills,
        this.materials,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.myScheduleId,
        this.gender,
        this.city,
    });

    factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        dob: json["dob"],
        language: json["language"],
        id: json["_id"],
        location: json["location"],
        rateHourly: json["rateHourly"],
        skillsCategory: json["skillsCategory"],
        ratings: json["ratings"],
        subscriptionStatus: json["subscriptionStatus"],
        customerId: json["customerId"],
        paymentMethodId: json["paymentMethodId"],
        certificates: json["certificates"] == null ? [] : List<String>.from(json["certificates"]!.map((x) => x)),
        isDeleted: json["isDeleted"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        materials: json["materials"] == null ? [] : List<Material>.from(json["materials"]!.map((x) => Material.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        myScheduleId: json["myScheduleId"],
        gender: json["gender"],
        city: json["city"],
    );

    Map<String, dynamic> toJson() => {
        "dob": dob,
        "language": language,
        "_id": id,
        "location": location,
        "rateHourly": rateHourly,
        "skillsCategory": skillsCategory,
        "ratings": ratings,
        "subscriptionStatus": subscriptionStatus,
        "customerId": customerId,
        "paymentMethodId": paymentMethodId,
        "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
        "isDeleted": isDeleted,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "myScheduleId": myScheduleId,
        "gender": gender,
        "city": city,
    };
}

class Material {
    String? name;
    String? unit;
    int? price;
    String? id;

    Material({
        this.name,
        this.unit,
        this.price,
        this.id,
    });

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
