import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';

class OnGoingController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.loading());
  Rx<RxStatus> statusForRating = Rx<RxStatus>(RxStatus.success());

  RxList<BookingModelData> onGoingBookingList = <BookingModelData>[].obs;
  RxDouble rating = 5.0.obs;

  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  bool isLock = false;

  @override
  void onInit() {
    super.onInit();
    getOnGoingBookings();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreOnGoingBookings();
      }
    });
  }

  Future<void> getOnGoingBookings() async {
    status.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=ongoing&page=$currentPage&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(response.body);

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        onGoingBookingList.addAll(bookingModel.data!);
        status.value = RxStatus.success();
      }

      status.value = RxStatus.success();
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
      status.value = RxStatus.error(
        'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> getMoreOnGoingBookings() async {
    if (status.value.isLoading || status.value.isLoadingMore || isLock) return;

    status.value = RxStatus.loadingMore();
    currentPage++;

    try {
      final response = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=ongoing&page=$currentPage&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(response.body);

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        showCustomSnackBar('No more data to load');
        isLock = true;
      } else {
        onGoingBookingList.addAll(bookingModel.data!);
      }
    } catch (e) {
      currentPage--;
      debugPrint('xxx ${e.toString()}');
      showCustomSnackBar(e.toString());
    }

    status.value = RxStatus.success();
  }

  Future<void> finishOrder(String id) async {
    final Map<String, String> data = {"status": "ongoing"};

    try {
      final response = await ApiClient.patchMultipartData(
        '${ApiUrl.bookings}/$id',
        data,
        multipartBody: null,
      );

      if (response.statusCode == 200) {
        // update home screen data
        Get.find<ContractorHomeController>().getAllBookings();

        showCustomSnackBar('Order accepted successfully', isError: false);
      } else {
        showCustomSnackBar('Something went wrong', isError: false);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  Future<void> cancelOrder(String id) async {
    final Map<String, String> data = {"status": "cancelled"};

    try {
      final response = await ApiClient.patchData(
        '${ApiUrl.bookings}/$id',
        jsonEncode(data),
      );

      // update home screen data
      getOnGoingBookings();
      Get.find<ContractorHomeController>().getAllBookings();

      showCustomSnackBar(response.body['message'], isError: false);
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  Future<void> rateCustomer(String id) async {
    if (statusForRating.value.isLoading) return;

    statusForRating.value = RxStatus.loading();

    final Map<String, dynamic> data = {
      "customerId": id,
      "stars": rating.value,
    };

    try {
      final response = await ApiClient.postData(
        ApiUrl.rateCustomer,
        jsonEncode(data),
      );

      showCustomSnackBar(response.body['message'], isError: false);
    } catch (e) {
      showCustomSnackBar(e.toString());
    } finally {
      statusForRating.value = RxStatus.success();
    }
  }
}
