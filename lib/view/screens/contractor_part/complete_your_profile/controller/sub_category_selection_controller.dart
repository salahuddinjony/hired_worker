import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/model/sub_category_model.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

class SubCategorySelectionController extends GetxController {
  // for subcategory
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  Rx<SubCategoryModel> subCategoryModel = SubCategoryModel().obs;
  String id = '';

  // for update button
  Rx<RxStatus> updateStatus = Rx<RxStatus>(RxStatus.success());


  @override
  void onInit() {
    super.onInit();

    id = Get.arguments['id'];
    getSubCategories();
  }

  Future<void> getSubCategories() async {
    status.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(ApiUrl.singleSubCategories + id + '?page=1&limit=1000');

      subCategoryModel.value = SubCategoryModel.fromJson(response.body);

      if (subCategoryModel.value.data == null ||
          subCategoryModel.value.data!.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        status.value = RxStatus.success();
      }
    } catch (e) {
      status.value = RxStatus.error();
    }
  }

  Future<void> updateContractorData(List<String> subCategoryId) async {
    if (subCategoryId.isEmpty) {
      return;
    }

    updateStatus.value = RxStatus.loading();

    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    final String uri = '${ApiUrl.updateUser}/$userId';

    final Map<String, String> body = {'data': jsonEncode({"subCategory": subCategoryId.toList()})};

    try {
      final response = await ApiClient.patchMultipartData(
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
