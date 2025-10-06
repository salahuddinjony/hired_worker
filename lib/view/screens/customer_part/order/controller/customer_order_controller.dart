import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';

class CustomerOrderController extends GetxController {
  RxInt bookingReportIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    "Request History",
    "Complete History",
  ].obs;

  RxList<BookingResult> bookingReportList = <BookingResult>[].obs;
  Rx<RxStatus> getBookingReportStatus = RxStatus.success().obs;
  final RxInt rating = 0.obs;
  final TextEditingController reviewTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getBookingReport();
  }

  Future<void> getBookingReport() async {
    try {
      getBookingReportStatus.value = RxStatus.loading();
      final response = await ApiClient.getData(ApiUrl.getAllBookings);
      if (response.statusCode == 200) {
        final bookingReport = CustomerOrderModel.fromJson(response.body);
        bookingReportList.value = bookingReport.data?.result ?? [];
        getBookingReportStatus.value = RxStatus.success();
      } else {
        getBookingReportStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      getBookingReportStatus.value = RxStatus.error();
      print('Error in getBookingReport: $e');
    }
  }

  Future<bool> submitReview({String? bookingId, required int rating, String? review}) async {
    try {
    final body = {
        'bookingId': bookingId,
        'rating': rating,
        'review': review,
      };
      EasyLoading.show(status: 'Submitting review...');
      final response = await ApiClient.postData(ApiUrl.submitReview, body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Review submitted successfully');
        print('Review submitted successfully');
      } else {
        EasyLoading.showError('Failed to submit review: ${response.body}');
        print('Failed to submit review: ${response.body}');
        return false;
      }
      return true;
    } catch (e) {
      print('Error submitting review: $e');
      return false;
    }
  }

  // Helpers for the review UI
  void setRating(int value) {
    rating.value = value;
  }

  void clearReview() {
    rating.value = 0;
    reviewTextController.clear();
  }

  @override
  void onClose() {
    reviewTextController.dispose();
    super.onClose();
  }

}