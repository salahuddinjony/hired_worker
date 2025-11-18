class LocationModel {
  final String? type;
  final List<double>? coordinates;
  final String? address;
  final String? id;

  LocationModel({this.type, this.coordinates, this.address, this.id});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type'],
      coordinates:
          (json['coordinates'] as List<dynamic>?)
              ?.map(
                (e) => e is double ? e : double.tryParse(e.toString()) ?? 0.0,
              )
              .toList(),
      address: json['address'],
      id: json['_id'] ?? json['id'],
    );
  }
}
