class CustomerOrderModel {
  final bool success;
  final String message;
  final Meta? meta;
  final List<BookingResult> data;

  CustomerOrderModel({
    required this.success,
    required this.message,
    this.meta,
    required this.data,
  });

  factory CustomerOrderModel.fromJson(Map<String, dynamic> json) {
    // Handle the new API structure where data contains result and meta
    final dataObject = json['data'];
    List<BookingResult> bookings = [];
    Meta? metaInfo;

    if (dataObject is Map<String, dynamic>) {
      // New API structure: data.result contains the bookings array
      bookings =
          (dataObject['result'] as List<dynamic>?)
              ?.map((e) => BookingResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [];
      // Extract meta from data.meta
      metaInfo =
          dataObject['meta'] != null
              ? Meta.fromJson(dataObject['meta'] as Map<String, dynamic>)
              : null;
    } else if (dataObject is List<dynamic>) {
      // Old API structure: data is directly an array
      bookings =
          dataObject
              .map((e) => BookingResult.fromJson(e as Map<String, dynamic>))
              .toList();
      // Meta might be at root level
      metaInfo =
          json['meta'] != null
              ? Meta.fromJson(json['meta'] as Map<String, dynamic>)
              : null;
    }

    return CustomerOrderModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: metaInfo,
      data: bookings,
    );
  }
}

class BookingResult {
  final String? id;
  final Customer? customerId;
  final Contractor? contractorId;
  final SubCategory? subCategoryId;
  final int? bookingId;
  final String? bookingType;
  final String? status;
  final String? paymentStatus;
  final List<Question> questions;
  final List<MaterialItem> material;
  final String? bookingDate;
  final dynamic day; // Can be String or List<String>
  final String? startTime;
  final String? endTime;
  final int? duration;
  final List<String> timeSlots;
  final num? price;
  final num? rateHourly;
  final num? totalAmount;
  final List<FileItem> files;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final String? location;
  final List<BookingDateAndStatus> bookingDateAndStatus;

  BookingResult({
    this.id,
    this.customerId,
    this.contractorId,
    this.subCategoryId,
    this.bookingId,
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
    this.totalAmount,
    required this.files,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.location,
    required this.bookingDateAndStatus,
  });

  factory BookingResult.fromJson(Map<String, dynamic> json) {
    // Handle 'day' as either String or List<String>
    dynamic dayValue = json['day'];
    if (dayValue is List) {
      dayValue = dayValue.map((e) => e.toString()).toList();
    } else if (dayValue is String) {
      // keep as is
    }

    // Handle files: can be a list of strings or a list of objects
    List<FileItem> filesList = [];
    if (json['files'] is List) {
      filesList = (json['files'] as List).map((e) {
        if (e is String) {
          return FileItem(url: e);
        } else if (e is Map<String, dynamic>) {
          return FileItem.fromJson(e);
        } else {
          return FileItem();
        }
      }).toList();
    }

    // Handle bookingDateAndStatus
    List<BookingDateAndStatus> bookingDateAndStatusList = [];
    if (json['bookingDateAndStatus'] is List) {
      bookingDateAndStatusList = (json['bookingDateAndStatus'] as List)
          .map((e) => BookingDateAndStatus.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return BookingResult(
      id: json['_id'] ?? '',
      customerId: json['customerId'] != null && json['customerId'] is Map<String, dynamic>
          ? Customer.fromJson(json['customerId'])
          : null,
      contractorId: json['contractorId'] != null && json['contractorId'] is Map<String, dynamic>
          ? Contractor.fromJson(json['contractorId'])
          : null,
      subCategoryId: json['subCategoryId'] != null && json['subCategoryId'] is Map<String, dynamic>
          ? SubCategory.fromJson(json['subCategoryId'])
          : null,
      bookingId: json['bookingId'] ?? 0,
      bookingType: json['bookingType'] ?? '',
      status: json['status'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
      questions: (json['questions'] as List?)?.map((e) => Question.fromJson(e)).toList() ?? [],
      material: (json['material'] as List?)?.map((e) => MaterialItem.fromJson(e)).toList() ?? [],
      bookingDate: json['bookingDate'] ?? '',
      day: dayValue,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      duration: json['duration'] ?? 0,
      timeSlots: (json['timeSlots'] as List?)?.map((e) => e.toString()).toList() ?? [],
      price: json['price'] ?? 0,
      rateHourly: json['rateHourly'] ?? 0,
      totalAmount: json['totalAmount'] ?? 0,
      files: filesList,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      location: json['location'] ?? '',
      bookingDateAndStatus: bookingDateAndStatusList,
    );
  }
}

class BookingDateAndStatus {
  final String? status;
  final List<FileItem> image;
  final List<MaterialItem> materials;
  final String? date;
  final num? amount;
  final String? id;

  BookingDateAndStatus({
    this.status,
    this.image = const [],
    this.materials = const [],
    this.date,
    this.amount,
    this.id,
  });

  factory BookingDateAndStatus.fromJson(Map<String, dynamic> json) {
    List<FileItem> imageList = [];
    if (json['image'] is List) {
      imageList = (json['image'] as List).map((e) {
        if (e is String) {
          return FileItem(url: e);
        } else if (e is Map<String, dynamic>) {
          return FileItem.fromJson(e);
        } else {
          return FileItem();
        }
      }).toList();
    }
    List<MaterialItem> materialsList = [];
    if (json['materials'] is List) {
      materialsList = (json['materials'] as List)
          .map((e) => MaterialItem.fromJson(e))
          .toList();
    }
    return BookingDateAndStatus(
      status: json['status'] ?? '',
      image: imageList,
      materials: materialsList,
      date: json['date'] ?? '',
      amount: json['amount'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}

class FileItem {
  final String? name;
  final String? url;
  final String? mimetype;
  final int? size;

  FileItem({this.name, this.url, this.mimetype, this.size});

  factory FileItem.fromJson(Map<String, dynamic> json) {
    return FileItem(
      name: json['name'],
      url: json['url'] ?? json['fileUrl'] ?? '',
      mimetype: json['mimetype'],
      size: json['size'],
    );
  }
}

class Question {
  final String? question;
  final String? answer;
  final String? id;

  Question({this.question, this.answer, this.id});

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
  final int? count;
  final num? price;
  final String? id;

  MaterialItem({this.name, this.unit, this.count, this.price, this.id});

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      name: json['name'] ?? '',
      unit: json['unit'] ?? '',
      count: json['count'] ?? 0,
      price: json['price'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      totalPage: json['totalPage'] ?? 0,
    );
  }
}

class Customer {
  final String? id;
  final String? fullName;
  final String? email;
  final String? img;

  Customer({this.id, this.fullName, this.email, this.img});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      img: json['img'] ?? '',
    );
  }
}

class Contractor {
  final String? id;
  final String? fullName;
  final String? email;
  final String? contactNo;
  final bool? otpVerified;
  final String? img;
  final String? role;
  final String? status;
  final ContractorDetails? contractor;
  final bool? isDeleted;
  final String? passwordChangedAt;
  final String? createdAt;
  final String? updatedAt;

  Contractor({
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
  });

  factory Contractor.fromJson(Map<String, dynamic> json) {
    return Contractor(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      contactNo: json['contactNo'] ?? '',
      otpVerified: json['otpVerified'] ?? false,
      img: json['img'] ?? '',
      role: json['role'] ?? '',
      status: json['status'] ?? '',
      contractor:
          json['contractor'] != null
              ? ContractorDetails.fromJson(json['contractor'])
              : null,
      isDeleted: json['isDeleted'] ?? false,
      passwordChangedAt: json['passwordChangedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class ContractorDetails {
  final String? id;
  final num? rateHourly;
  final num? ratings;

  ContractorDetails({this.id, this.rateHourly, this.ratings});

  factory ContractorDetails.fromJson(Map<String, dynamic> json) {
    return ContractorDetails(
      id: json['_id'] ?? '',
      rateHourly: json['rateHourly'] ?? 0,
      ratings: json['ratings'] ?? 0,
    );
  }
}

class SubCategory {
  final String? id;
  final String? categoryId;
  final String? name;
  final String? img;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.img,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'] ?? '',
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}