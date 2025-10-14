import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';

import '../../../../../utils/app_strings/app_strings.dart';

class ContractorHomeController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.loading());

  Rx<BookingModel> bookingModel = BookingModel().obs;
  Rx<BookingModel> pendingBookingList = BookingModel().obs;
  Rx<BookingModel> onGoingBookingList = BookingModel().obs;
  Rx<BookingModel> completeBookingList = BookingModel().obs;
  RxInt onGoingServices = 0.obs;
  RxInt requestedServices = 0.obs;

  // for request screen
  RxInt currentIndex = 0.obs;
  RxList<String> nameList =
      [AppStrings.serviceReuest, AppStrings.deliveredService].obs;

  @override
  void onInit() {
    super.onInit();
    getAllBookings();
  }

  Future<void> getAllBookings() async {
    status.value = RxStatus.loading();

    try {
      // get recent services
      final response = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?page=1&limit=10',
      );

      bookingModel.value = BookingModel.fromJson(response.body);

      // get pending (request) services
      final pendingServiceResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=pending',
      );

      pendingBookingList.value = BookingModel.fromJson(
        pendingServiceResponse.body,
      );

      requestedServices.value = pendingBookingList.value.data!.length;

      // get completed services
      final completedServiceResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=completed',
      );

      completeBookingList.value = BookingModel.fromJson(
        completedServiceResponse.body,
      );

      // get ongoing service number
      final ongoingResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=ongoing',
      );

      onGoingBookingList.value = BookingModel.fromJson(
        ongoingResponse.body,
      );

      onGoingServices.value = onGoingBookingList.value.data!.length;

      status.value = RxStatus.success();
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
      status.value = RxStatus.error('Something went wrong. Please try again later.');
    }
  }

  Future<void> acceptOrder(String id) async {
    final Map<String, String> data = {"status": "accepted"};

    try {
      final response = await ApiClient.patchMultipartData(
        '${ApiUrl.bookings}/$id',
        data,
        multipartBody: null,
      );

      if (response.statusCode == 200) {
        removeBookingData(id);

        onGoingServices.value++;

        if (requestedServices.value > 1) {
          requestedServices.value--;
        }

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

      removeBookingData(id);

      if (requestedServices.value > 1) {
        requestedServices.value--;
      }

      showCustomSnackBar(response.body['message'], isError: false);
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  void removeBookingData(String id) {
    pendingBookingList.value.data!.removeWhere((element) {
      return element.id == id;
    });

    pendingBookingList.refresh();
  }
}
