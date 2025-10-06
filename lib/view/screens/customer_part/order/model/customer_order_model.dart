class CustomerOrderModel {
  final bool success;
  final String message;
  final BookingData? data;

  CustomerOrderModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory CustomerOrderModel.fromJson(Map<String, dynamic> json) {
    return CustomerOrderModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? BookingData.fromJson(json['data']) : null,
    );
  }
}

class BookingData {
  final List<BookingResult> result;
  final Meta? meta;

  BookingData({
    required this.result,
    this.meta,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      result: (json['result'] as List?)
              ?.map((e) => BookingResult.fromJson(e))
              .toList() ??
          [],
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }
}

class BookingResult {
  final String? id;
  final String? customerId;
  final dynamic contractorId;
  final SubCategory? subCategoryId;
  final String? bookingType;
  final String? status;
  final String? paymentStatus;
  final List<Question> questions;
  final List<MaterialItem> material;
  final String? bookingDate;
  final String? day;
  final String? startTime;
  final String? endTime;
  final int? duration;
  final List<String> timeSlots;
  final num? price;
  final num? rateHourly;
  final List<dynamic> files;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  BookingResult({
    this.id,
    this.customerId,
    this.contractorId,
    this.subCategoryId,
    this.bookingType,
    this.status,
    this.paymentStatus,
    required this.questions,
    required this.material,
    this.bookingDate,
    this.day,
    this.startTime,
    this.endTime,
    this.duration,
    required this.timeSlots,
    this.price,
    this.rateHourly,
    required this.files,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory BookingResult.fromJson(Map<String, dynamic> json) {
    return BookingResult(
      id: json['_id'] ?? '',
      customerId: json['customerId'] ?? '',
      contractorId: json['contractorId'],
      subCategoryId: json['subCategoryId'] != null &&
              json['subCategoryId'] is Map<String, dynamic>
          ? SubCategory.fromJson(json['subCategoryId'])
          : null,
      bookingType: json['bookingType'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      questions: (json['questions'] as List?)
              ?.map((e) => Question.fromJson(e))
              .toList() ??
          [],
      material: (json['material'] as List?)
              ?.map((e) => MaterialItem.fromJson(e))
              .toList() ??
          [],
      bookingDate: json['bookingDate'] ?? '',
      day: json['day'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      duration: json['duration'] ?? 0,
      timeSlots:
          (json['timeSlots'] as List?)?.map((e) => e.toString()).toList() ?? [],
      price: json['price'] ?? 0,
      rateHourly: json['rateHourly'] ?? 0,
      files: json['files'] ?? [],
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Question {
  final String? question;
  final String? answer;
  final String? id;

  Question({
    this.question,
    this.answer,
    this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      id: json['_id'] ?? '',
    );
  }
}

class MaterialItem {
  final String? name;
  final String? unit;
  final num? price;
  final String? id;

  MaterialItem({
    this.name,
    this.unit,
    this.price,
    this.id,
  });

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      price: json['price'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}

class SubCategory {
  final String? id;
  final String? name;

  SubCategory({
    this.id,
    this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({
    this.page,
    this.limit,
    this.total,
    this.totalPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}
