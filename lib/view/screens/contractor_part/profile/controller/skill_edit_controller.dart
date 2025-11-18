import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';

import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

class SkillEditController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  List<String> skills = [];

  @override
  void onInit() {
    super.onInit();
    skills = Get.arguments['skill'];
  }

  Future<void> updateContractorData(Set<String> skills) async {
    if (skills.isEmpty) {
      return;
    }

    status.value = RxStatus.loading();

    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    final String uri = '${ApiUrl.updateUser}/$userId';

    final Map<String, String> body = {
      'data': jsonEncode({'skills': skills.toList()}),
    };

    try {
      final response = await ApiClient.patchMultipartData(
        uri,
        body,
        multipartBody: [],
      );

      if (response.statusCode == 200) {
        status.value = RxStatus.success();

        Get.find<ProfileController>().getMe();

        Get.back();
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "response.statusText",
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
