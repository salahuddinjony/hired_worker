// Generated model for banners API response
// Matches the JSON structure returned by the API (see example in the issue)

class BannersResponse {
	final bool success;
	final String message;
	final List<BannerItem> data;

	BannersResponse({required this.success, required this.message, required this.data});

	factory BannersResponse.fromJson(Map<String, dynamic> json) {
		return BannersResponse(
			success: json['success'] ?? false,
			message: json['message'] ?? '',
			data: json['data'] != null
					? List<BannerItem>.from((json['data'] as List).map((e) => BannerItem.fromJson(e)))
					: <BannerItem>[],
		);
	}

	Map<String, dynamic> toJson() => {
				'success': success,
				'message': message,
				'data': data.map((e) => e.toJson()).toList(),
			};
}

class BannerItem {
	final String id;
	final String image;
	final Category? category;
	final SubCategory? subCategory;
	final String type;
	final DateTime? createdAt;
	final DateTime? updatedAt;
	final int? v;

	BannerItem({
		required this.id,
		required this.image,
		this.category,
		this.subCategory,
		required this.type,
		this.createdAt,
		this.updatedAt,
		this.v,
	});

	factory BannerItem.fromJson(Map<String, dynamic> json) {
		return BannerItem(
			id: json['_id'] ?? '',
			image: json['image'] ?? '',
			category: json['category'] != null ? Category.fromJson(json['category']) : null,
			subCategory: json['subCategory'] != null ? SubCategory.fromJson(json['subCategory']) : null,
			type: json['type'] ?? '',
			createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
			updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
			v: json['__v'] is int ? json['__v'] as int : null,
		);
	}

	Map<String, dynamic> toJson() => {
				'_id': id,
				'image': image,
				'category': category?.toJson(),
				'subCategory': subCategory?.toJson(),
				'type': type,
				'createdAt': createdAt?.toIso8601String(),
				'updatedAt': updatedAt?.toIso8601String(),
				'__v': v,
			};
}

class Category {
	final String id;
	final String name;

	Category({required this.id, required this.name});

	factory Category.fromJson(Map<String, dynamic> json) => Category(
				id: json['_id'] ?? '',
				name: json['name'] ?? '',
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
			};
}

class SubCategory {
	final String id;
	final String name;

	SubCategory({required this.id, required this.name});

	factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
				id: json['_id'] ?? '',
				name: json['name'] ?? '',
			);

	Map<String, dynamic> toJson() => {
				'_id': id,
				'name': name,
			};
}

