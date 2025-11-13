class ReviewResponse {
  final bool success;
  final String message;
  final ReviewData? data;

  ReviewResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ReviewData.fromJson(json['data']) : null,
    );
  }
}

class ReviewData {
  final dynamic user; // user can be null
  final String averageRating;
  final int totalCompletedOrder;
  final List<Review> reviews;

  ReviewData({
    required this.user,
    required this.averageRating,
    required this.totalCompletedOrder,
    required this.reviews,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      user: json['user'],
      averageRating: json['averageRating']?.toString() ?? '0.0',
      totalCompletedOrder: json['totalCompletedOrder'] ?? 0,
      reviews:
          (json['reviews'] as List?)?.map((e) => Review.fromJson(e)).toList() ??
          [],
    );
  }
}

class Review {
  final String id;
  final Customer? customerId;
  final String contractorId;
  final int stars;
  final String description;
  final bool isDeleted;
  final String createdAt;
  final String updatedAt;

  Review({
    required this.id,
    required this.customerId,
    required this.contractorId,
    required this.stars,
    required this.description,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'] ?? '',
      customerId:
          json['customerId'] != null
              ? Customer.fromJson(json['customerId'])
              : null,
      contractorId: json['contractorId'] ?? '',
      stars: json['stars'] ?? 0,
      description: json['description'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Customer {
  final String id;
  final String fullName;
  final String img;

  Customer({required this.id, required this.fullName, required this.img});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'] ?? '',
      fullName: json['fullName'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
