// To parse this JSON data, do
//
//     final getAllContactorModel = getAllContactorModelFromJson(jsonString);

import 'dart:convert';

GetAllContactorModel getAllContactorModelFromJson(String str) => GetAllContactorModel.fromJson(json.decode(str));

String getAllContactorModelToJson(GetAllContactorModel data) => json.encode(data.toJson());

class GetAllContactorModel {
    bool? success;
    String? message;
    Meta? meta;
    List<Datum>? data;

    GetAllContactorModel({
        this.success,
        this.message,
        this.meta,
        this.data,
    });

    factory GetAllContactorModel.fromJson(Map<String, dynamic> json) => GetAllContactorModel(
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "meta": meta?.toJson(),
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? dob;
    String? gender;
    String? city;
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
    List<dynamic>? materials;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.dob,
        this.gender,
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
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        dob: json["dob"],
        gender: json["gender"],
        city: json["city"],
        language: json["language"],
        location: json["location"],
        rateHourly: json["rateHourly"],
        skillsCategory: json["skillsCategory"],
        ratings: json["ratings"],
        subscriptionStatus: json["subscriptionStatus"],
        customerId: json["customerId"],
        paymentMethodId: json["paymentMethodId"],
        certificates: json["certificates"] == null ? [] : List<String>.from(json["certificates"]!.map((x) => x)),
        myScheduleId: json["myScheduleId"],
        isDeleted: json["isDeleted"],
        skills: json["skills"] == null ? [] : List<String>.from(json["skills"]!.map((x) => x)),
        materials: json["materials"] == null ? [] : List<dynamic>.from(json["materials"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "dob": dob,
        "gender": gender,
        "city": city,
        "language": language,
        "location": location,
        "rateHourly": rateHourly,
        "skillsCategory": skillsCategory,
        "ratings": ratings,
        "subscriptionStatus": subscriptionStatus,
        "customerId": customerId,
        "paymentMethodId": paymentMethodId,
        "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
        "myScheduleId": myScheduleId,
        "isDeleted": isDeleted,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x)),
        "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class Meta {
    int? page;
    int? limit;
    int? total;
    int? totalPage;

    Meta({
        this.page,
        this.limit,
        this.total,
        this.totalPage,
    });

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
