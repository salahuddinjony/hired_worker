// To parse this JSON data, do
//
//     final contactorDetailsModel = contactorDetailsModelFromJson(jsonString);

import 'dart:convert';

ContactorDetailsModel contactorDetailsModelFromJson(String str) => ContactorDetailsModel.fromJson(json.decode(str));

String contactorDetailsModelToJson(ContactorDetailsModel data) => json.encode(data.toJson());

class ContactorDetailsModel {
    bool? success;
    String? message;
    Data? data;

    ContactorDetailsModel({
        this.success,
        this.message,
        this.data,
    });

    factory ContactorDetailsModel.fromJson(Map<String, dynamic> json) => ContactorDetailsModel(
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
    User? user;
    String? averageRating;
    int? totalCompletedOrder;
    List<dynamic>? reviews;

    Data({
        this.user,
        this.averageRating,
        this.totalCompletedOrder,
        this.reviews,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        averageRating: json["averageRating"],
        totalCompletedOrder: json["totalCompletedOrder"],
        reviews: json["reviews"] == null ? [] : List<dynamic>.from(json["reviews"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "averageRating": averageRating,
        "totalCompletedOrder": totalCompletedOrder,
        "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x)),
    };
}

class User {
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

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
    DateTime? dob;
    String? gender;
    String? experience;
    String? bio;
    String? city;
    String? language;
    String? location;
    int? rateHourly;
    String? skillsCategory;
    int? ratings;
    String? subscriptionStatus;
    String? customerId;
    String? paymentMethodId;
    List<dynamic>? certificates;
    MySchedule? myScheduleId;
    bool? isDeleted;
    List<Skill>? skills;
    List<dynamic>? materials;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? userId;

    Contractor({
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
        this.v,
        this.userId,
    });

    factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
        id: json["_id"],
        dob: json["dob"] == null || json["dob"] == "" ? null : DateTime.parse(json["dob"]),
        gender: json["gender"],
        experience: json["experience"],
        bio: json["bio"],
        city: json["city"],
        language: json["language"],
        location: json["location"],
        rateHourly: json["rateHourly"],
        skillsCategory: json["skillsCategory"],
        ratings: json["ratings"],
        subscriptionStatus: json["subscriptionStatus"],
        customerId: json["customerId"],
        paymentMethodId: json["paymentMethodId"],
        certificates: json["certificates"] == null ? [] : List<dynamic>.from(json["certificates"]!.map((x) => x)),
        myScheduleId: json["myScheduleId"] == null ? null : MySchedule.fromJson(json["myScheduleId"]),
        isDeleted: json["isDeleted"],
        skills: json["skills"] == null ? [] : List<Skill>.from(json["skills"]!.map((x) => Skill.fromJson(x))),
        materials: json["materials"] == null ? [] : List<dynamic>.from(json["materials"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "dob": dob?.toIso8601String(),
        "gender": gender,
        "experience": experience,
        "bio": bio,
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
        "myScheduleId": myScheduleId?.toJson(),
        "isDeleted": isDeleted,
        "skills": skills == null ? [] : List<dynamic>.from(skills!.map((x) => x.toJson())),
        "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "userId": userId,
    };
}

class MySchedule {
    String? id;
    String? contractorId;
    List<Schedule>? schedules;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    MySchedule({
        this.id,
        this.contractorId,
        this.schedules,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory MySchedule.fromJson(Map<String, dynamic> json) => MySchedule(
        id: json["_id"],
        contractorId: json["contractorId"],
        schedules: json["schedules"] == null ? [] : List<Schedule>.from(json["schedules"]!.map((x) => Schedule.fromJson(x))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "contractorId": contractorId,
        "schedules": schedules == null ? [] : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Schedule {
    String? days;
    List<String>? timeSlots;
    String? id;

    Schedule({
        this.days,
        this.timeSlots,
        this.id,
    });

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        days: json["days"],
        timeSlots: json["timeSlots"] == null ? [] : List<String>.from(json["timeSlots"]!.map((x) => x)),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "days": days,
        "timeSlots": timeSlots == null ? [] : List<dynamic>.from(timeSlots!.map((x) => x)),
        "_id": id,
    };
}

class Skill {
    String? name;
    String? id;

    Skill({
        this.name,
        this.id,
    });

    factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        name: json["name"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "_id": id,
    };
}
