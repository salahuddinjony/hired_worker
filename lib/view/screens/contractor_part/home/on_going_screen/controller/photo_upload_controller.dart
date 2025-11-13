import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/on_going_controller.dart';
import '../../../../../../service/api_url.dart';

class PhotoUploadController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  late String bookingId;

  final ImagePicker _picker = ImagePicker();
  final RxList<XFile> workImages = <XFile>[].obs;

  RxInt selectedDateIndex = (-1).obs;
  RxMap<String, int> materialQuantities = <String, int>{}.obs;

  @override
  void onInit() {
    super.onInit();

    bookingId =
        Get.find<OnGoingController>()
            .onGoingBookingList[Get.arguments['id']]
            .id!;
  }

  // Increase material quantity
  void increaseQuantity(String materialId, int maxQuantity) {
    final current = materialQuantities[materialId] ?? 0;

    if (current < maxQuantity) {
      materialQuantities[materialId] = current + 1;
    } else {
      showCustomSnackBar('Maximum quantity reached', isError: true);
    }
  }

  // Decrease material quantity
  void decreaseQuantity(String materialId) {
    final current = materialQuantities[materialId] ?? 0;
    if (current > 0) {
      materialQuantities[materialId] = current - 1;

      // Remove key if quantity becomes 0
      if (materialQuantities[materialId] == 0) {
        materialQuantities.remove(materialId);
      }
    }
  }

  // Get current quantity
  int getQuantity(String materialId) {
    return materialQuantities[materialId] ?? 0;
  }

  void selectDate(int index) {
    if (selectedDateIndex.value == index) {
      selectedDateIndex.value = -1;
    } else {
      selectedDateIndex.value = index;
    }
  }

  Future<void> pickWorkImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      workImages.addAll(pickedImages);
    }
  }

  Future<void> finishService() async {
    if (status.value.isLoading) return;

    status.value = RxStatus.loading();

    // patch
    final String endPoint = '${ApiUrl.bookings}/$bookingId';

    final body = {"status": "completed"};

    try {
      final response = await ApiClient.patchMultipartData(
        endPoint,
        body,
        multipartBody:
            workImages
                .map((image) => MultipartBody("file", File(image.path)))
                .toList(),
      );

      if (response.statusCode == 200) {
        Get.toNamed(
          AppRoutes.onGoingFinishScreen,
          arguments: {'id': Get.arguments['id']},
        );
      } else {
        showCustomSnackBar(response.body['message'], isError: false);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    } finally {
      status.value = RxStatus.success();
    }
  }

  Future<void> finishWeeklyService() async {
    if (selectedDateIndex.value == -1) {
      showCustomSnackBar('Please select a date first');
      return;
    } else if (workImages.isEmpty) {
      showCustomSnackBar('Please upload some of your work images.');
      return;
    }

    // debugPrint(
    //   'Entry ID: ${Get.find<OnGoingController>().onGoingBookingList[Get.arguments['id']].bookingDateAndStatus![selectedDateIndex.value].id}',
    // );
    // debugPrint('Materials: ${materialQuantities.toString()}');

    if (status.value.isLoading) return;

    status.value = RxStatus.loading();

    // patch
    final String endPoint = '${ApiUrl.weeklyBookings}/$bookingId';

    final Map<String, dynamic> body = {
      "entryId":
          Get.find<OnGoingController>()
              .onGoingBookingList[Get.arguments['id']]
              .bookingDateAndStatus![selectedDateIndex.value]
              .id!,
      "status": "completed",
      if (materialQuantities.isNotEmpty)
        "materials":
            materialQuantities.entries
                .map((entry) => {"materialId": entry.key, "count": entry.value})
                .toList(),
    };

    debugPrint(body.toString());

    try {
      final response = await ApiClient.patchMultipartData(
        endPoint,
        body,
        multipartBody:
            workImages
                .map((image) => MultipartBody("file", File(image.path)))
                .toList(),
      );

      if (response.statusCode == 200) {
        Get.toNamed(
          AppRoutes.onGoingFinishScreen,
          arguments: {'id': Get.arguments['id']},
        );
      } else {
        showCustomSnackBar(response.body['message'], isError: false);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    } finally {
      status.value = RxStatus.success();
    }
  }
}
