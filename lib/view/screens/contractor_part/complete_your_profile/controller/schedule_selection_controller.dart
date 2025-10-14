import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';

class ScheduleSelectionController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  Future<void> updateContractorData(Set<String> days) async {
    if (days.isEmpty) {
      showCustomSnackBar("Please select at least one day to continue.");
      return;
    }

    final Map<String, String> dayMap = {
      'Sun': 'Sunday',
      'Mon': 'Monday',
      'Tue': 'Tuesday',
      'Wed': 'Wednesday',
      'Thu': 'Thursday',
      'Fri': 'Friday',
      'Sat': 'Saturday',
    };

    final List<Map<String, dynamic>> schedules = days.map((day) {
      return {
        "days": dayMap[day] ?? day,
        "timeSlots": ["09:00-23:00"],
      };
    }).toList();

    final Map<String, dynamic> body = {
      "schedules": schedules,
    };

    status.value = RxStatus.loading();
    try {
      final response = await ApiClient.postData(
        ApiUrl.updateSchedule,
        jsonEncode(body),
      );

      if (response.statusCode == 200) {
        status.value = RxStatus.success();
        Get.toNamed(AppRoutes.categorySeletedScreen);
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Something went wrong",
          isError: true,
        );
        status.value = RxStatus.error();
      }
    } catch (e) {
      debugPrint('Error updating contractor data: $e');
      showCustomSnackBar("Error updating contractor data: $e", isError: true);
      status.value = RxStatus.error();
    }
  }

}
