import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import '../../../../../../utils/app_strings/app_strings.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';

class OrderController extends GetxController {
  // for tab
  RxInt currentIndex = 0.obs;
  RxList<String> nameList =
      [AppStrings.serviceReuest, AppStrings.deliveredService].obs;

  // for screen state
  Rx<RxStatus> commonStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<RxStatus> statusForPending = Rx<RxStatus>(RxStatus.loading());
  Rx<RxStatus> statusForComplete = Rx<RxStatus>(RxStatus.loading());

  RxList<BookingModelData> pendingBookingList = <BookingModelData>[].obs;
  RxList<BookingModelData> completedBookingList = <BookingModelData>[].obs;

  // for pending list
  ScrollController pendingScrollController = ScrollController();
  int pendingPageNumber = 1;
  bool isPendingLock = false;

  // for delivered list
  ScrollController completedScrollController = ScrollController();
  int completedPageNumber = 1;
  bool isCompletedLock = false;

  @override
  void onInit() {
    super.onInit();

    callAllMethods();

    pendingScrollController.addListener(() {
      if (pendingScrollController.position.pixels ==
          pendingScrollController.position.maxScrollExtent) {
        getMorePendingBookings();
      }
    });

    completedScrollController.addListener(() {
      if (completedScrollController.position.pixels ==
          completedScrollController.position.maxScrollExtent) {
        getMoreCompletedBookings();
      }
    });
  }

  Future<void> callAllMethods() async {
    commonStatus.value = RxStatus.loading();

    await Future.wait([getPendingBookings(), getCompletedBookings()]);

    commonStatus.value = RxStatus.success();
  }

  Future<void> getPendingBookings() async {
    statusForPending.value = RxStatus.loading();

    pendingBookingList.clear();

    try {
      final pendingServiceResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=pending&page=$pendingPageNumber&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(
        pendingServiceResponse.body,
      );

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        statusForPending.value = RxStatus.empty();
      } else {
        pendingBookingList.addAll(bookingModel.data!);
        statusForPending.value = RxStatus.success();
      }
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
      statusForPending.value = RxStatus.error(
        'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> getMorePendingBookings() async {
    if (statusForPending.value.isLoading ||
        statusForPending.value.isLoadingMore ||
        isPendingLock)
      return;

    statusForPending.value = RxStatus.loadingMore();
    pendingPageNumber++;

    try {
      final pendingServiceResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=pending&page=$pendingPageNumber&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(
        pendingServiceResponse.body,
      );

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        showCustomSnackBar('No more data load');
        isPendingLock = true;
      } else {
        pendingBookingList.addAll(bookingModel.data!);
      }
    } catch (e) {
      pendingPageNumber--;
      debugPrint('xxx ${e.toString()}');
      showCustomSnackBar(e.toString());
    }

    statusForPending.value = RxStatus.success();
  }

  Future<void> getCompletedBookings() async {
    statusForComplete.value = RxStatus.loading();

    completedBookingList.clear();

    try {
      final completedServiceResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=completed',
      );

      final BookingModel bookingModel = BookingModel.fromJson(
        completedServiceResponse.body,
      );

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        statusForComplete.value = RxStatus.empty();
      } else {
        completedBookingList.addAll(bookingModel.data!);
        statusForComplete.value = RxStatus.success();
      }
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
      statusForComplete.value = RxStatus.error(
        'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> getMoreCompletedBookings() async {
    if (statusForComplete.value.isLoadingMore ||
        statusForComplete.value.isLoading ||
        isCompletedLock)
      return;
    statusForComplete.value = RxStatus.loadingMore();
    completedPageNumber++;

    try {
      final completedServiceResponse = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?status=completed&page=$completedPageNumber&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(
        completedServiceResponse.body,
      );

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        showCustomSnackBar('No more data load');
        isCompletedLock = true;
      } else {
        completedBookingList.addAll(bookingModel.data!);
      }
    } catch (e) {
      completedPageNumber--;
      debugPrint('xxx ${e.toString()}');
      showCustomSnackBar(e.toString());
    }

    statusForComplete.value = RxStatus.success();
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
        callAllMethods();
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

      if (response.statusCode == 200) {
        callAllMethods();
        Get.find<ContractorHomeController>().getAllBookings();
        showCustomSnackBar('Order cancelled successfully', isError: false);
      } else {
        showCustomSnackBar('Something went wrong', isError: false);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }
}
