// BookingModel.dart

class BookingModel {
  bool? success;
  String? message;
  Meta? meta;
  List<BookingModelData>? data;

  BookingModel({
    this.success,
    this.message,
    this.meta,
    this.data,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
    success: json["success"],
    message: json["message"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    data: json["data"] == null
        ? []
        : List<BookingModelData>.from(
        json["data"].map((x) => BookingModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

// -------------------- BookingModelData --------------------

class BookingModelData {
  String? id;
  Customer? customerId;
  ContractorWrapper? contractorId;
  SubCategory? subCategoryId;
  int? bookingId;
  String? bookingType;
  DateTime? bookingDate;
  List<String>? day;
  String? startTime;
  String? endTime;
  num? duration;
  List<String>? timeSlots;
  List<QuestionElement>? questions;
  List<MaterialItem>? material;
  num? rateHourly;
  num? totalAmount;
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
    this.bookingId,
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
    this.totalAmount,
    this.status,
    this.paymentStatus,
    this.files,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingModelData.fromJson(Map<String, dynamic> json) {
    List<String> parsedDay = [];
    if (json["day"] != null) {
      if (json["day"] is String) {
        parsedDay = [json["day"]];
      } else if (json["day"] is List) {
        parsedDay = List<String>.from(json["day"].map((x) => x.toString()));
      }
    }

    return BookingModelData(
      id: json["_id"],
      customerId: json["customerId"] == null
          ? null
          : Customer.fromJson(json["customerId"]),
      contractorId: json["contractorId"] == null
          ? null
          : ContractorWrapper.fromJson(json["contractorId"]),
      subCategoryId: json["subCategoryId"] == null
          ? null
          : SubCategory.fromJson(json["subCategoryId"]),
      bookingId: json["bookingId"],
      bookingType: json["bookingType"],
      bookingDate: json["bookingDate"] == null
          ? null
          : DateTime.parse(json["bookingDate"]),
      day: parsedDay,
      startTime: json["startTime"],
      endTime: json["endTime"],
      duration: json["duration"],
      timeSlots: json["timeSlots"] == null
          ? []
          : List<String>.from(json["timeSlots"].map((x) => x)),
      questions: json["questions"] == null
          ? []
          : List<QuestionElement>.from(
          json["questions"].map((x) => QuestionElement.fromJson(x))),
      material: json["material"] == null
          ? []
          : List<MaterialItem>.from(
          json["material"].map((x) => MaterialItem.fromJson(x))),
      rateHourly: json["rateHourly"],
      totalAmount: json["totalAmount"],
      status: json["status"],
      paymentStatus: json["paymentStatus"],
      files: json["files"] == null
          ? []
          : List<dynamic>.from(json["files"].map((x) => x)),
      isDeleted: json["isDeleted"],
      createdAt:
      json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      updatedAt:
      json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId?.toJson(),
    "contractorId": contractorId?.toJson(),
    "subCategoryId": subCategoryId?.toJson(),
    "bookingId": bookingId,
    "bookingType": bookingType,
    "bookingDate": bookingDate?.toIso8601String(),
    "day": day ?? [],
    "startTime": startTime,
    "endTime": endTime,
    "duration": duration,
    "timeSlots": timeSlots == null
        ? []
        : List<dynamic>.from(timeSlots!.map((x) => x)),
    "questions": questions == null
        ? []
        : List<dynamic>.from(questions!.map((x) => x.toJson())),
    "material": material == null
        ? []
        : List<dynamic>.from(material!.map((x) => x.toJson())),
    "rateHourly": rateHourly,
    "totalAmount": totalAmount,
    "status": status,
    "paymentStatus": paymentStatus,
    "files":
    files == null ? [] : List<dynamic>.from(files!.map((x) => x)),
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

// -------------------- Nested Models --------------------

// ✅ Customer (now includes img)
class Customer {
  String? id;
  String? fullName;
  String? email;
  String? img;

  Customer({this.id, this.fullName, this.email, this.img});

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "img": img,
  };
}

// ✅ Contractor (nested inside contractorId)
class Contractor {
  String? id;
  double? ratings;

  Contractor({this.id, this.ratings});

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
    id: json["_id"],
    ratings: (json["ratings"] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "ratings": ratings,
  };
}

// ✅ ContractorWrapper (outer object with nested contractor)
class ContractorWrapper {
  String? id;
  String? fullName;
  String? img;
  Contractor? contractor;

  ContractorWrapper({
    this.id,
    this.fullName,
    this.img,
    this.contractor,
  });

  factory ContractorWrapper.fromJson(Map<String, dynamic> json) =>
      ContractorWrapper(
        id: json["_id"],
        fullName: json["fullName"],
        img: json["img"],
        contractor: json["contractor"] == null
            ? null
            : Contractor.fromJson(json["contractor"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "img": img,
    "contractor": contractor?.toJson(),
  };
}

class SubCategory {
  String? id;
  String? name;
  String? img;

  SubCategory({this.id, this.name, this.img});

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["_id"],
    name: json["name"],
    img: json["img"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "img": img,
  };
}

class MaterialItem {
  String? name;
  String? unit;
  int? count;
  int? price;
  String? id;

  MaterialItem({this.name, this.unit, this.count, this.price, this.id});

  factory MaterialItem.fromJson(Map<String, dynamic> json) => MaterialItem(
    name: json["name"],
    unit: json["unit"],
    count: json["count"],
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "unit": unit,
    "count": count,
    "price": price,
    "_id": id,
  };
}

class QuestionElement {
  String? question;
  String? answer;
  String? id;

  QuestionElement({this.question, this.answer, this.id});

  factory QuestionElement.fromJson(Map<String, dynamic> json) =>
      QuestionElement(
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
