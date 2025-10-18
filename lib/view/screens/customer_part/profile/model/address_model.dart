class SavedAddress {
  final String? id;
  final String title;
  final String address;
  final String? flatNo;
  final String? directions;
  final String city;
  final double? latitude;
  final double? longitude;
  final bool isSelected;

  SavedAddress({
    this.id,
    required this.title,
    required this.address,
    this.flatNo,
    this.directions,
    required this.city,
    this.latitude,
    this.longitude,
    this.isSelected = false,
  });

  SavedAddress copyWith({
    String? id,
    String? title,
    String? address,
    String? flatNo,
    String? directions,
    String? city,
    double? latitude,
    double? longitude,
    bool? isSelected,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      flatNo: flatNo ?? this.flatNo,
      directions: directions ?? this.directions,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'flatNo': flatNo,
      'directions': directions,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'isSelected': isSelected,
    };
  }

  factory SavedAddress.fromJson(Map<String, dynamic> json) {
    return SavedAddress(
      id: json['id'],
      title: json['title'] ?? '',
      address: json['address'] ?? '',
      flatNo: json['flatNo'],
      directions: json['directions'],
      city: json['city'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      isSelected: json['isSelected'] ?? false,
    );
  }
}
