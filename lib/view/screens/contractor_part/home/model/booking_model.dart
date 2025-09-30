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
    data: json["data"] == null ? [] : List<BookingModelData>.from(json["data"]!.map((x) => BookingModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "meta": meta?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BookingModelData {
  String? id;
  String? customerId;
  ContractorId? contractorId;
  SubCategoryId? subCategoryId;
  BookingType? bookingType;
  DateTime? bookingDate;
  String? day;
  StartTime? startTime;
  EndTime? endTime;
  int? duration;
  List<String>? timeSlots;
  List<QuestionElement>? questions;
  List<dynamic>? materials;
  int? rateHourly;
  int? price;
  int? totalAmount;
  int? systemFeeAmount;
  int? contractorAmount;
  String? status;
  PaymentStatus? paymentStatus;
  ContractorResponse? contractorResponse;
  ContractorPayout? contractorPayout;
  bool? isDeleted;
  List<WorkSession>? workSessions;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Material>? material;
  int? periodInDays;
  String? paymentIntent;

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
    this.materials,
    this.rateHourly,
    this.price,
    this.totalAmount,
    this.systemFeeAmount,
    this.contractorAmount,
    this.status,
    this.paymentStatus,
    this.contractorResponse,
    this.contractorPayout,
    this.isDeleted,
    this.workSessions,
    this.createdAt,
    this.updatedAt,
    this.material,
    this.periodInDays,
    this.paymentIntent,
  });

  factory BookingModelData.fromJson(Map<String, dynamic> json) => BookingModelData(
    id: json["_id"],
    customerId: json["customerId"],
    contractorId: json["contractorId"] == null ? null : ContractorId.fromJson(json["contractorId"]),
    subCategoryId: json["subCategoryId"] == null ? null : SubCategoryId.fromJson(json["subCategoryId"]),
    bookingType: bookingTypeValues.map[json["bookingType"]]!,
    bookingDate: json["bookingDate"] == null ? null : DateTime.parse(json["bookingDate"]),
    day: json["day"],
    startTime: startTimeValues.map[json["startTime"]]!,
    endTime: endTimeValues.map[json["endTime"]]!,
    duration: json["duration"],
    timeSlots: json["timeSlots"] == null ? [] : List<String>.from(json["timeSlots"]!.map((x) => x)),
    questions: json["questions"] == null ? [] : List<QuestionElement>.from(json["questions"]!.map((x) => QuestionElement.fromJson(x))),
    materials: json["materials"] == null ? [] : List<dynamic>.from(json["materials"]!.map((x) => x)),
    rateHourly: json["rateHourly"],
    price: json["price"],
    totalAmount: json["totalAmount"],
    systemFeeAmount: json["systemFeeAmount"],
    contractorAmount: json["contractorAmount"],
    status: json["status"]!,
    paymentStatus: paymentStatusValues.map[json["paymentStatus"]]!,
    contractorResponse: json["contractorResponse"] == null ? null : ContractorResponse.fromJson(json["contractorResponse"]),
    contractorPayout: json["contractorPayout"] == null ? null : ContractorPayout.fromJson(json["contractorPayout"]),
    isDeleted: json["isDeleted"],
    workSessions: json["workSessions"] == null ? [] : List<WorkSession>.from(json["workSessions"]!.map((x) => WorkSession.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    material: json["material"] == null ? [] : List<Material>.from(json["material"]!.map((x) => Material.fromJson(x))),
    periodInDays: json["periodInDays"],
    paymentIntent: json["paymentIntent"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "customerId": customerId,
    "contractorId": contractorId?.toJson(),
    "subCategoryId": subCategoryId?.toJson(),
    "bookingType": bookingTypeValues.reverse[bookingType],
    "bookingDate": bookingDate?.toIso8601String(),
    "day": day,
    "startTime": startTimeValues.reverse[startTime],
    "endTime": endTimeValues.reverse[endTime],
    "duration": duration,
    "timeSlots": timeSlots == null ? [] : List<dynamic>.from(timeSlots!.map((x) => x)),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
    "materials": materials == null ? [] : List<dynamic>.from(materials!.map((x) => x)),
    "rateHourly": rateHourly,
    "price": price,
    "totalAmount": totalAmount,
    "systemFeeAmount": systemFeeAmount,
    "contractorAmount": contractorAmount,
    // ignore: collection_methods_unrelated_type
    "status": statusValues.reverse[status],
    "paymentStatus": paymentStatusValues.reverse[paymentStatus],
    "contractorResponse": contractorResponse?.toJson(),
    "contractorPayout": contractorPayout?.toJson(),
    "isDeleted": isDeleted,
    "workSessions": workSessions == null ? [] : List<dynamic>.from(workSessions!.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "material": material == null ? [] : List<dynamic>.from(material!.map((x) => x.toJson())),
    "periodInDays": periodInDays,
    "paymentIntent": paymentIntent,
  };
}

enum BookingType {
  // ignore: constant_identifier_names
  BOOKING_TYPE_ONE_TIME,
  // ignore: constant_identifier_names
  ONE_TIME,
  // ignore: constant_identifier_names
  WEEKLY
}

final bookingTypeValues = EnumValues({
  "OneTime": BookingType.BOOKING_TYPE_ONE_TIME,
  "oneTime": BookingType.ONE_TIME,
  "Weekly": BookingType.WEEKLY
});

class ContractorId {
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

  ContractorId({
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

  factory ContractorId.fromJson(Map<String, dynamic> json) => ContractorId(
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
  int? rateHourly;
  int? ratings;

  Contractor({
    this.id,
    this.rateHourly,
    this.ratings,
  });

  factory Contractor.fromJson(Map<String, dynamic> json) => Contractor(
    id: json["_id"],
    rateHourly: json["rateHourly"],
    ratings: json["ratings"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "rateHourly": rateHourly,
    "ratings": ratings,
  };
}

class ContractorPayout {
  Status? status;
  int? amount;

  ContractorPayout({
    this.status,
    this.amount,
  });

  factory ContractorPayout.fromJson(Map<String, dynamic> json) => ContractorPayout(
    status: statusValues.map[json["status"]]!,
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "amount": amount,
  };
}

enum Status {
  // ignore: constant_identifier_names
  COMPLETED,
  // ignore: constant_identifier_names
  ONGOING,
  // ignore: constant_identifier_names
  PENDING
}

final statusValues = EnumValues({
  "completed": Status.COMPLETED,
  "ongoing": Status.ONGOING,
  "pending": Status.PENDING
});

class ContractorResponse {
  String? status;
  String? acceptanceNotes;
  DateTime? respondedAt;

  ContractorResponse({
    this.status,
    this.acceptanceNotes,
    this.respondedAt,
  });

  factory ContractorResponse.fromJson(Map<String, dynamic> json) => ContractorResponse(
    status: json["status"],
    acceptanceNotes: json["acceptanceNotes"],
    respondedAt: json["respondedAt"] == null ? null : DateTime.parse(json["respondedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "acceptanceNotes": acceptanceNotes,
    "respondedAt": respondedAt?.toIso8601String(),
  };
}

enum EndTime {
  THE_1100,
  THE_1300,
  THE_1400
}

final endTimeValues = EnumValues({
  "11:00": EndTime.THE_1100,
  "13:00": EndTime.THE_1300,
  "14:00": EndTime.THE_1400
});

class Material {
  Name? name;
  Unit? unit;
  int? price;
  String? id;

  Material({
    this.name,
    this.unit,
    this.price,
    this.id,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
    name: nameValues.map[json["name"]]!,
    unit: unitValues.map[json["unit"]]!,
    price: json["price"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "name": nameValues.reverse[name],
    "unit": unitValues.reverse[unit],
    "price": price,
    "_id": id,
  };
}

enum Name {
  DRILL,
  HAMMER
}

final nameValues = EnumValues({
  "Drill": Name.DRILL,
  "Hammer": Name.HAMMER
});

enum Unit {
  PCS
}

final unitValues = EnumValues({
  "pcs": Unit.PCS
});

enum PaymentStatus {
  CAPTURED,
  PENDING
}

final paymentStatusValues = EnumValues({
  "captured": PaymentStatus.CAPTURED,
  "pending": PaymentStatus.PENDING
});

class QuestionElement {
  QuestionEnum? question;
  Answer? answer;
  String? id;

  QuestionElement({
    this.question,
    this.answer,
    this.id,
  });

  factory QuestionElement.fromJson(Map<String, dynamic> json) => QuestionElement(
    question: questionEnumValues.map[json["question"]]!,
    answer: answerValues.map[json["answer"]]!,
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "question": questionEnumValues.reverse[question],
    "answer": answerValues.reverse[answer],
    "_id": id,
  };
}

enum Answer {
  INDOOR,
  NONE,
  THE_10_AM,
  YES
}

final answerValues = EnumValues({
  "Indoor": Answer.INDOOR,
  "None": Answer.NONE,
  "10 AM": Answer.THE_10_AM,
  "Yes": Answer.YES
});

enum QuestionEnum {
  DO_YOU_HAVE_ANY_SPECIAL_REQUESTS,
  DO_YOU_NEED_THE_ELECTRICIAN_TO_BRING_THEIR_OWN_TOOLS,
  IS_THIS_AN_INDOOR_OR_OUTDOOR_JOB,
  WHAT_IS_YOUR_PREFERRED_TIME
}

final questionEnumValues = EnumValues({
  "Do you have any special requests?": QuestionEnum.DO_YOU_HAVE_ANY_SPECIAL_REQUESTS,
  "Do you need the electrician to bring their own tools?": QuestionEnum.DO_YOU_NEED_THE_ELECTRICIAN_TO_BRING_THEIR_OWN_TOOLS,
  "Is this an indoor or outdoor job?": QuestionEnum.IS_THIS_AN_INDOOR_OR_OUTDOOR_JOB,
  "What is your preferred time?": QuestionEnum.WHAT_IS_YOUR_PREFERRED_TIME
});

enum StartTime {
  THE_0900,
  THE_1100,
  THE_1300
}

final startTimeValues = EnumValues({
  "09:00": StartTime.THE_0900,
  "11:00": StartTime.THE_1100,
  "13:00": StartTime.THE_1300
});

class SubCategoryId {
  String? id;
  String? name;

  SubCategoryId({
    this.id,
    this.name,
  });

  factory SubCategoryId.fromJson(Map<String, dynamic> json) => SubCategoryId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class WorkSession {
  DateTime? startTime;
  DateTime? endTime;

  WorkSession({
    this.startTime,
    this.endTime,
  });

  factory WorkSession.fromJson(Map<String, dynamic> json) => WorkSession(
    startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
    endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
  );

  Map<String, dynamic> toJson() => {
    "startTime": startTime?.toIso8601String(),
    "endTime": endTime?.toIso8601String(),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
