class BookingModel {
  bool? success;
  String? message;
  BookingData? data;

  BookingModel({
    this.success,
    this.message,
    this.data,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : BookingData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class BookingData {
  List<BookingModelData>? result;
  Meta? meta;

  BookingData({
    this.result,
    this.meta,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
    result: json["result"] == null
        ? []
        : List<BookingModelData>.from(
        json["result"]!.map((x) => BookingModelData.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class BookingModelData {
  String? id;
  String? customerId;
  dynamic contractorId;
  dynamic subCategoryId;
  String? bookingType;
  DateTime? bookingDate;
  String? day;
  String? startTime;
  String? endTime;
  int? duration;
  List<String>? timeSlots;
  List<QuestionElement>? questions;
  List<Material>? material;
  int? rateHourly;
  int? price;
  String? status;
  String? paymentStatus;
  List<dynamic>? files;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookingModelData({
    this.id,
    this.customerId,
    this.contractorId,
    this.subCategoryId,
    this.bookingType,
    this.bookingDate,
    this.day,
    this.startTime,
    this.endTime,
    this.duration,
    this.timeSlots,
    this.questions,
    this.material,
    this.rateHourly,
    this.price,
    this.status,
    this.paymentStatus,
    this.files,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingModelData.fromJson(Map<String, dynamic> json) => BookingModelData(
    id: json["_id"],
    customerId: json["customerId"],
    contractorId: json["contractorId"],
    subCategoryId: json["subCategoryId"],
    bookingType: json["bookingType"],
    bookingDate: json["bookingDate"] == null
        ? null
        : DateTime.parse(json["bookingDate"]),
    day: json["day"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    duration: json["duration"],
    timeSlots: json["timeSlots"] == null
        ? []
        : List<String>.from(json["timeSlots"]!.map((x) => x)),
    questions: json["questions"] == null
        ? []
        : List<QuestionElement>.from(
        json["questions"]!.map((x) => QuestionElement.fromJson(x))),
    material: json["material"] == null
        ? []
        : List<Material>.from(
        json["material"]!.map((x) => Material.fromJson(x))),
    rateHourly: json["rateHourly"],
    price: json["price"],
    status: json["status"],
    paymentStatus: json["paymentStatus"],
    files: json["files"] == null
        ? []
        : List<dynamic>.from(json["files"]!.map((x) => x)),
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId,
    "contractorId": contractorId,
    "subCategoryId": subCategoryId,
    "bookingType": bookingType,
    "bookingDate": bookingDate?.toIso8601String(),
    "day": day,
    "startTime": startTime,
    "endTime": endTime,
    "duration": duration,
    "timeSlots":
    timeSlots == null ? [] : List<dynamic>.from(timeSlots!.map((x) => x)),
    "questions": questions == null
        ? []
        : List<dynamic>.from(questions!.map((x) => x.toJson())),
    "material": material == null
        ? []
        : List<dynamic>.from(material!.map((x) => x.toJson())),
    "rateHourly": rateHourly,
    "price": price,
    "status": status,
    "paymentStatus": paymentStatus,
    "files": files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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

class QuestionElement {
  String? question;
  String? answer;
  String? id;

  QuestionElement({
    this.question,
    this.answer,
    this.id,
  });

  factory QuestionElement.fromJson(Map<String, dynamic> json) => QuestionElement(
    question: json["question"],
    answer: json["answer"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "_id": id,
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