import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

class ChargeController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  num? hourlyRate;

  @override
  void onInit() {
    super.onInit();

    hourlyRate = Get.arguments['rate'];
  }

  Future<void> updateContractorData(String rateHourly) async {
    if (rateHourly.isEmpty) {
      showCustomSnackBar("Please enter amount to continue.");
      return;
    }

    status.value = RxStatus.loading();

    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    final String uri = '${ApiUrl.updateUser}/$userId';

    final Map<String, String> body = {'data': '{"rateHourly": "$rateHourly"}'};

    try {
      final response = await ApiClient.patchMultipartData(
        uri,
        body,
        multipartBody: [],
      );

      if (response.statusCode == 200) {
        status.value = RxStatus.success();

        if (hourlyRate != null) {
          showCustomSnackBar("Successfully updated", isError: false);
          Get.find<ProfileController>().getMe();
          Get.back();
        } else {
          Get.toNamed(AppRoutes.subscribeScreen);
        }
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
