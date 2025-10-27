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
    String? adminAccept;

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
        this.adminAccept,
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
        adminAccept: json["adminAccept"],
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
        "adminAccept": adminAccept,
    };
}

class Customer {
    String? id;
    String? dob;
    String? gender;
    String? city;
    String? language;
    num? balance;
    List<Location>? location;
    bool? isDeleted;
    int? v;
    String? userId;

    Customer({
        this.id,
        this.dob,
        this.gender,
        this.city,
        this.language,
        this.balance,
        this.location,
        this.isDeleted,
        this.v,
        this.userId,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["_id"],
        dob: json["dob"],
        gender: json["gender"],
        city: json["city"],
        language: json["language"],
        balance: json["balance"],
        location: json["location"] == null
                ? null
                : List<Location>.from(
                        (json["location"] as List).map((x) => Location.fromJson(x))),
        isDeleted: json["isDeleted"],
        v: json["__v"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "dob": dob,
        "gender": gender,
        "city": city,
        "language": language,
        "balance": balance,
        "location": location == null
                ? null
                : List<dynamic>.from(location!.map((x) => x.toJson())),
        "isDeleted": isDeleted,
        "__v": v,
        "userId": userId,
    };
}

class Location {
    String? type;
    List<double>? coordinates;
    String? address;
    String? street;
    String? unit;
    String? name;
    bool? isSelect;
    String? id;

    Location({
        this.type,
        this.coordinates,
        this.address,
        this.street,
        this.unit,
        this.name,
        this.isSelect,
        this.id,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
                ? null
                : List<double>.from((json["coordinates"] as List).map((x) => x.toDouble())),
        address: json["address"],
        street: json["street"],
        unit: json["unit"],
        name: json["name"],
        isSelect: json["isSelect"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates,
        "address": address,
        "street": street,
        "unit": unit,
        "name": name,
        "isSelect": isSelect,
        "_id": id,
    };
}
