// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
    bool? success;
    String? message;
    Data? data;

    CustomerModel({
        this.success,
        this.message,
        this.data,
    });

    factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
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
    Customer? customer;
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
        this.customer,
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
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
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
        "customer": customer?.toJson(),
        "isDeleted": isDeleted,
        "passwordChangedAt": passwordChangedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Customer {
    String? id;
    String? dob;
    String? gender;
    String? city;
    String? language;
    String? location;
    bool? isDeleted;
    int? v;

    Customer({
        this.id,
        this.dob,
        this.gender,
        this.city,
        this.language,
        this.location,
        this.isDeleted,
        this.v,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        dob: json["dob"],
        gender: json["gender"],
        city: json["city"],
        language: json["language"],
        location: json["location"],
        isDeleted: json["isDeleted"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "dob": dob,
        "gender": gender,
        "city": city,
        "language": language,
        "location": location,
        "isDeleted": isDeleted,
        "__v": v,
    };
}
