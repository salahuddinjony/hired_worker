class FaqResponse {
  final bool success;
  final String message;
  final Meta? meta;
  final List<FaqData> data;

  FaqResponse({
    required this.success,
    required this.message,
    this.meta,
    required this.data,
  });

  factory FaqResponse.fromJson(Map<String, dynamic> json) {
    return FaqResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => FaqData.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class Meta {
  final int page;
  final int limit;
  final int total;
  final int totalPage;

  Meta({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPage,
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

class FaqData {
  final String id;
  final List<String> question;
  final SubCategory? subCategory;
  final bool isDeleted;

  FaqData({
    required this.id,
    required this.question,
    this.subCategory,
    required this.isDeleted,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) {
    return FaqData(
      id: json['_id'] ?? '',
      question:
          (json['question'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      subCategory:
          json['subCategoryId'] != null
              ? SubCategory.fromJson(json['subCategoryId'])
              : null,
      isDeleted: json['isDeleted'] ?? false,
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final String img;

  SubCategory({required this.id, required this.name, required this.img});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      img: json['img'] ?? '',
    );
  }
}
