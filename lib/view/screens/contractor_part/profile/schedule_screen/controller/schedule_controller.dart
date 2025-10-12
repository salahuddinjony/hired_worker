import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';

import '../../../../../../service/api_client.dart';
import '../../../../../../service/api_url.dart';
import '../../../../../../utils/ToastMsg/toast_message.dart';

class ScheduleController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  final Map<String, Map<String, dynamic>> scheduleData =
      <String, Map<String, dynamic>>{};

  void updateDaySchedule(
    String day,
    String fullDay,
    bool isAvailable,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  ) {
    if (isAvailable && startTime != null && endTime != null) {
      scheduleData[fullDay] = {
        'isAvailable': isAvailable,
        'startTime': startTime,
        'endTime': endTime,
      };
    } else {
      scheduleData.remove(fullDay);
    }

    debugPrint('Updated schedule data: $scheduleData');
  }

  String formatTimeForApi(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Future<void> updateContractorData() async {
    if (scheduleData.isEmpty) {
      showCustomSnackBar(
        "Please set availability for at least one day to continue.",
      );
      return;
    }

    final List<Map<String, dynamic>> schedules =
        scheduleData.entries.map((entry) {
          final day = entry.key;
          final data = entry.value;
          final startTime = formatTimeForApi(data['startTime'] as TimeOfDay);
          final endTime = formatTimeForApi(data['endTime'] as TimeOfDay);

          return {
            "days": day,
            "timeSlots": ["$startTime-$endTime"],
          };
        }).toList();

    final Map<String, dynamic> body = {"schedules": schedules};

    debugPrint('Sending schedule data: ${jsonEncode(body)}');

    status.value = RxStatus.loading();
    try {
      final response = await ApiClient.postData(
        ApiUrl.updateSchedule,
        jsonEncode(body),
      );

      if (response.statusCode == 200) {
        showCustomSnackBar("Schedule updated successfully!", isError: false);

        // to refresh ta data
        await Get.find<ProfileController>().getMe();
        status.value = RxStatus.success();

        Get.back();
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
