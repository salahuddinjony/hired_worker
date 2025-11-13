class SubCategoryModel {
  bool? success;
  String? message;
  List<Datum>? data;

  SubCategoryModel({this.success, this.message, this.data});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        success: json["success"],
        message: json["message"],
        data:
            json["data"] == null
                ? []
                : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? categoryId;
  String? name;
  String? img;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    this.id,
    this.categoryId,
    this.name,
    this.img,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    categoryId: json["categoryId"],
    name: json["name"],
    img: json["img"],
    isDeleted: json["isDeleted"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "categoryId": categoryId,
    "name": name,
    "img": img,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
