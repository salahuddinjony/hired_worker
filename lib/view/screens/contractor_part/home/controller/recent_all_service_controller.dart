import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../model/booking_model.dart';

class RecentAllServiceController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.loading());
  RxList<BookingModelData> recentServiceList = <BookingModelData>[].obs;

  // for pagination
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  bool isLock = false;

  final bool flagForPagination =
      (Get.arguments as Map<String, dynamic>?)?['showTotalService'] as bool? ??
      false;

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          if (!flagForPagination) {
            return;
          }

          getMoreRecentServices();
        }
      });
    });

    getRecentAllService();
  }

  Future<void> getRecentAllService() async {
    status.value = RxStatus.loading();

    try {
      // get recent services
      final response = await ApiClient.getData(
        '${ApiUrl.singleUserBookings}?page=$currentPage&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(response.body);

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        recentServiceList.addAll(bookingModel.data!);
        status.value = RxStatus.success();
      }
    } catch (e) {
      status.value = RxStatus.error(e.toString());
    }
  }

  Future<void> getMoreRecentServices() async {
    if (status.value.isLoading || status.value.isLoadingMore || isLock) return;

    status.value = RxStatus.loadingMore();
    currentPage++;

    try {
      // get recent services
      final response = await ApiClient.getData(
        '${ApiUrl.bookings}?page=$currentPage&limit=10',
      );

      final BookingModel bookingModel = BookingModel.fromJson(response.body);

      if (bookingModel.data == null || bookingModel.data!.isEmpty) {
        showCustomSnackBar('No more data to load');
        isLock = true;
      } else {
        recentServiceList.addAll(bookingModel.data!);
      }
    } catch (e) {
      currentPage--;

      showCustomSnackBar(e.toString());
    }

    status.value = RxStatus.success();
  }
}
