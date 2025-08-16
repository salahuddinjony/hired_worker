// To parse this JSON data, do
//
//     final singleSubCategorysModel = singleSubCategorysModelFromJson(jsonString);

import 'dart:convert';

SingleSubCategorysModel singleSubCategorysModelFromJson(String str) => SingleSubCategorysModel.fromJson(json.decode(str));

String singleSubCategorysModelToJson(SingleSubCategorysModel data) => json.encode(data.toJson());

class SingleSubCategorysModel {
    bool? success;
    String? message;
    Meta? meta;
    List<Datum>? data;

    SingleSubCategorysModel({
        this.success,
        this.message,
        this.meta,
        this.data,
    });

    factory SingleSubCategorysModel.fromJson(Map<String, dynamic> json) => SingleSubCategorysModel(
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
    CategoryId? categoryId;
    String? name;
    String? img;
    bool? isDeleted;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.categoryId,
        this.name,
        this.img,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        categoryId: json["categoryId"] == null ? null : CategoryId.fromJson(json["categoryId"]),
        name: json["name"],
        img: json["img"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "categoryId": categoryId?.toJson(),
        "name": name,
        "img": img,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class CategoryId {
    String? id;
    String? name;

    CategoryId({
        this.id,
        this.name,
    });

    factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
        id: json["_id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
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
