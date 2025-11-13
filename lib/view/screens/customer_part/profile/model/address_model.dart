class SavedAddress {
  final String? id;
  final String? type;
  final String title;
  final String address;
  final String? unit;
  final String? street;
  final String? direction;
  final String? name;
  final String city;
  final double? latitude;
  final double? longitude;
  final bool isSelected;

  SavedAddress({
    this.id,
    this.type,
    required this.title,
    required this.address,
    this.name,
    this.unit,
    this.street,
    this.direction,
    required this.city,
    this.latitude,
    this.longitude,
    this.isSelected = false,
  });

  SavedAddress copyWith({
    String? id,
    String? type,
    String? title,
    String? address,
    String? street,
    String? unit,
    String? name,
    String? direction,
    String? city,
    double? latitude,
    double? longitude,
    bool? isSelected,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      address: address ?? this.address,
      unit: unit ?? this.unit,
      street: street ?? this.street,
      name: name ?? this.name,
      direction: direction ?? this.direction,
      city: city ?? this.city,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'name': title,
      'address': address,
      'unit': unit,
      'street': street,
      'direction': direction,
      'name': name,
      'city': city,
      'latitude': latitude,
      'longitude': longitude,
      'isSelect': isSelected,
      'coordinates':
          latitude != null && longitude != null ? [longitude, latitude] : null,
    };
  }

  factory SavedAddress.fromJson(Map<String, dynamic> json) {
    // coordinates: [longitude, latitude]
    double? latitude;
    double? longitude;
    if (json['coordinates'] is List && json['coordinates'].length == 2) {
      longitude = (json['coordinates'][0] as num?)?.toDouble();
      latitude = (json['coordinates'][1] as num?)?.toDouble();
    } else {
      latitude = (json['latitude'] as num?)?.toDouble();
      longitude = (json['longitude'] as num?)?.toDouble();
    }
    return SavedAddress(
      id: json['_id'] ?? json['id'],
      type: json['type'],
      title: json['name'] ?? json['title'] ?? '',
      address: json['address'] ?? '',
      unit: json['unit'],
      street: json['street'],
      name: json['name'],
      direction: json['direction'],
      city: json['city'] ?? '',
      latitude: latitude,
      longitude: longitude,
      isSelected: json['isSelect'] ?? json['isSelected'] ?? false,
    );
  }
}
