import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';

class SupportController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController messageEditingController = TextEditingController();

  Future<void> sendMessage() async {
    status.value = RxStatus.loading();

    final Map<String, String> data = {
      "title": titleEditingController.text,
      "details": messageEditingController.text
    };

    try {
      final response = await ApiClient.postData(ApiUrl.createSupport, jsonEncode(data));

      if (response.statusCode == 200) {
        showCustomSnackBar('Message send successfully', isError: false);
        Get.back();
        titleEditingController.clear();
        messageEditingController.clear();
      } else {
        showCustomSnackBar('Something went wrong');
      }

    } catch (e) {
      showCustomSnackBar(e.toString());
    } finally {
      status.value = RxStatus.success();
    }
  }
}