import '../../view/screens/contractor_part/home/model/booking_model.dart';

String getSubCategoryName(BookingModelData data) {
  if (data.subCategoryId == null) return ' - ';

  if (data.subCategoryId is Map<String, dynamic>) {
    return (data.subCategoryId as Map<String, dynamic>)['name']?.toString() ?? ' - ';
  }

  return data.subCategoryId?.name ?? ' - ';
}