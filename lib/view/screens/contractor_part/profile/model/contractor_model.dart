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
    String? id;
    String? location;
    int? rateHourly;
    String? skillsCategory;
    int? ratings;
    String? subscriptionStatus;
    String? customerId;
    String? paymentMethodId;
    List<dynamic>? certificates;
    bool? isDeleted;
    List<dynamic>? skills;
    List<dynamic>? materials;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? myScheduleId;

    Contractor({
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
    });

    factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        id: json["_id"],
        location: json["location"],
        rateHourly: json["rateHourly"],
        skillsCategory: json["skillsCategory"],
        ratings: json["ratings"],
        subscriptionStatus: json["subscriptionStatus"],
        customerId: json["customerId"],
        paymentMethodId: json["paymentMethodId"],
        certificates: json["certificates"] == null ? [] : List<dynamic>.from(json["certificates"]!.map((x) => x)),
        isDeleted: json["isDeleted"],
        skills: json["skills"] == null ? [] : List<dynamic>.from(json["skills"]!.map((x) => x)),
        materials: json["materials"] == null ? [] : List<dynamic>.from(json["materials"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        myScheduleId: json["myScheduleId"],
    );

    Map<String, dynamic> toJson() => {
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
        "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "myScheduleId": myScheduleId,
    };
}
