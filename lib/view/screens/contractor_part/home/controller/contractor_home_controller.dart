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
        '${ApiUrl.bookings}?page=1&limit=10',
      );

      bookingModel.value = BookingModel.fromJson(response.body);

      // get pending (request) services
      final pendingServiceResponse = await ApiClient.getData(
        '${ApiUrl.bookings}?status=pending',
      );

      pendingBookingList.value = BookingModel.fromJson(
        pendingServiceResponse.body,
      );

      requestedServices.value = pendingBookingList.value.data!.result!.length;

      // get completed services
      final completedServiceResponse = await ApiClient.getData(
        '${ApiUrl.bookings}?status=completed',
      );

      completeBookingList.value = BookingModel.fromJson(
        completedServiceResponse.body,
      );

      // get ongoing service number
      final ongoingResponse = await ApiClient.getData(
        '${ApiUrl.bookings}?status=ongoing',
      );

      if (ongoingResponse.body != null &&
          ongoingResponse.body['meta'] != null) {
        final totalOngoing = ongoingResponse.body['meta']['total'] ?? 0;
        onGoingServices.value = totalOngoing;
      }

      status.value = RxStatus.success();
    } catch (e) {
      status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> acceptOrder(String id) async {
    Map<String, String> data = {"status": "ongoing"};

    try {
      final response = await ApiClient.patchData(
        '${ApiUrl.bookings}/$id',
        jsonEncode(data),
      );

      removeBookingData(id);

      onGoingServices.value++;

      if (requestedServices.value > 1) {
        requestedServices.value--;
      }

      showCustomSnackBar(response.body['message'], isError: false);
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  Future<void> cancelOrder(String id) async {
    Map<String, String> data = {"status": "cancelled"};

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
    pendingBookingList.value.data!.result!.removeWhere((element) {
      return element.id == id;
    });

    pendingBookingList.refresh();
  }
}
