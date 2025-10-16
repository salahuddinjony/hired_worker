import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';

class CreateHelpController extends GetxController {
  // Text editing controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  // Loading state
  RxBool isLoading = false.obs;

  // Create support ticket
  Future<void> createSupportTicket() async {
    // Validate inputs
    if (titleController.text.trim().isEmpty) {
      showCustomSnackBar("Please enter a title".tr);
      return;
    }

    if (detailsController.text.trim().isEmpty) {
      showCustomSnackBar("Please enter details".tr);
      return;
    }

    try {
      isLoading.value = true;

      // Prepare request body
      final body = jsonEncode({
        "title": titleController.text.trim(),
        "details": detailsController.text.trim(),
      });
      EasyLoading.show();

      // Make API call
      Response response = await ApiClient.postData(ApiUrl.createSupport, body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData =
            response.body is String ? jsonDecode(response.body) : response.body;

        if (responseData['success'] == true) {
          EasyLoading.showSuccess("Submitted successfully".tr);

          // Clear the form
          titleController.clear();
          detailsController.clear();

          // Go back after a short delay
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.back();
          });
        } else {
          showCustomSnackBar(
            responseData['message'] ?? "Failed to create support ticket".tr,
          );
        }
      } else {
        showCustomSnackBar("Failed to create support ticket".tr);
      }
    } catch (e) {
      debugPrint('Error creating support ticket: $e');
      showCustomSnackBar("An error occurred. Please try again".tr);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    detailsController.dispose();
    super.onClose();
  }
}
