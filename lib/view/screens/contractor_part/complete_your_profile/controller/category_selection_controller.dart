import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/model/category_model.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

class CategorySelectionController extends GetxController {
  // for category
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  Rx<CategoryModel> categoryModel = CategoryModel().obs;

  // for update button
  Rx<RxStatus> updateStatus = Rx<RxStatus>(RxStatus.success());


  @override
  void onInit() {
    super.onInit();

    getCategories();
  }

  Future<void> getCategories() async {
    status.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(ApiUrl.categories);

      categoryModel.value = CategoryModel.fromJson(response.body);

      if (categoryModel.value.data == null ||
          categoryModel.value.data!.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        status.value = RxStatus.success();
      }
    } catch (e) {
      status.value = RxStatus.error();
    }
  }

  Future<void> updateContractorData(String? category) async {
    if (category == null) {
      showCustomSnackBar("Please select at least one day to continue.");
      return;
    }

    updateStatus.value = RxStatus.loading();

    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    String uri = '${ApiUrl.updateUser}/$userId';

    Map<String, String> body = {'data': '{"skillsCategory": "$category"}'};

    try {
      var response = await ApiClient.patchMultipartData(
        uri,
        body,
        multipartBody: [],
      );

      if (response.statusCode == 200) {
        updateStatus.value = RxStatus.success();

        Get.toNamed(AppRoutes.certificateScreen);
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "response.statusText",
          isError: true,
        );

        updateStatus.value = RxStatus.error();
      }
    } catch (e) {
      debugPrint('Error updating contractor data: $e');

      showCustomSnackBar("Error updating contractor data: $e", isError: true);

      updateStatus.value = RxStatus.error();
    }
  }
}
