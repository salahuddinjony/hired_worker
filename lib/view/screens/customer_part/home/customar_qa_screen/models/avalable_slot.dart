class AvailableSlotResponse {
  final bool success;
  final String message;
  final AvailableSlotData? data;

  AvailableSlotResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory AvailableSlotResponse.fromJson(Map<String, dynamic> json) {
    return AvailableSlotResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? AvailableSlotData.fromJson(json['data']) : null,
    );
  }
}

class AvailableSlotData {
  final bool success;
  final String message;
  final List<String> availableSlots;

  AvailableSlotData({
    required this.success,
    required this.message,
    required this.availableSlots,
  });

  factory AvailableSlotData.fromJson(Map<String, dynamic> json) {
    return AvailableSlotData(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      availableSlots: (json['availableSlots'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}
