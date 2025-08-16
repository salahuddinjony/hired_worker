// To parse this JSON data, do
//
//     final materialModel = materialModelFromJson(jsonString);

import 'dart:convert';

MaterialModel materialModelFromJson(String str) => MaterialModel.fromJson(json.decode(str));

String materialModelToJson(MaterialModel data) => json.encode(data.toJson());

class MaterialModel {
    bool? success;
    String? message;
    Meta? meta;
    List<Datum>? data;

    MaterialModel({
        this.success,
        this.message,
        this.meta,
        this.data,
    });

    factory MaterialModel.fromJson(Map<String, dynamic> json) => MaterialModel(
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
    String? name;
    int? unit;
    int? price;
    bool? isDeleted;

    Datum({
        this.id,
        this.name,
        this.unit,
        this.price,
        this.isDeleted,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        unit: json["unit"],
        price: json["price"],
        isDeleted: json["isDeleted"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "unit": unit,
        "price": price,
        "isDeleted": isDeleted,
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
