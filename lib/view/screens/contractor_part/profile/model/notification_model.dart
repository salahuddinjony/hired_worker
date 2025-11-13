class NotificationModel {
  bool? success;
  String? message;
  Meta? meta;
  List<CustomNotification>? data;

  NotificationModel({this.success, this.message, this.meta, this.data});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        success: json["success"],
        message: json["message"],
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data:
            json["data"] == null
                ? []
                : List<CustomNotification>.from(
                  json["data"]!.map((x) => CustomNotification.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CustomNotification {
  String? id;
  String? userId;
  String? title;
  String? message;
  List<String>? isRead;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  CustomNotification({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.isRead,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomNotification.fromJson(
    Map<String, dynamic> json,
  ) => CustomNotification(
    id: json["_id"],
    userId: json["userId"],
    title: json["title"],
    message: json["message"],
    isRead:
        json["isRead"] == null
            ? []
            : List<String>.from(json["isRead"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "title": title,
    "message": message,
    "isRead": isRead == null ? [] : List<dynamic>.from(isRead!.map((x) => x)),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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
