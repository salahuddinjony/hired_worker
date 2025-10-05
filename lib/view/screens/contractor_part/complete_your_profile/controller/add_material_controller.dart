import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';

import 'dart:convert'; // add this

class MaterialController extends GetxController {
  // for add contractor date
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  // for update contractor date
  Future<void> updateContractorData(
    List<Map<String, String>> materials, [
    bool flag = true,
  ]) async {
    if (materials.isEmpty) {
      showCustomSnackBar("Please create at least one to continue.");
      return;
    }

    status.value = RxStatus.loading();

    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    String uri = '${ApiUrl.updateUser}/$userId';

    Map<String, String> body = {
      "data": jsonEncode({"materials": materials}),
    };

    debugPrint("====> API Body: $body");

    try {
      Response response;

      if (flag) {
        response = await ApiClient.patchMultipartData(
          uri,
          body,
          multipartBody: [],
        );
      } else {
        response = await ApiClient.patchData(uri, jsonEncode(body));
      }

      if (response.statusCode == 200) {
        status.value = RxStatus.success();

        if (!flag) {
          showCustomSnackBar('Material added successfully', isError: false);
        }
        if (flag) Get.toNamed(AppRoutes.chargeScreen);
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

  Future<void> addMaterial(String name, String unit, double price) async {
    showCustomSnackBar(
      'Please wait while your materials are being added...',
      isError: false,
    );

    try {
      Map<String, dynamic> data = {"name": name, "unit": unit, "price": price};

      final response = await ApiClient.postData(
        ApiUrl.createMaterial,
        jsonEncode(data),
      );

      if (response.statusCode == 200) {
        Get.find<ProfileController>().getMe();
        showCustomSnackBar('Material added successfully', isError: false);
      } else {
        showCustomSnackBar(response.body['message'], isError: true);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  Future<void> updateMaterial(
    String name,
    String unit,
    double price,
    String id,
  ) async {
    showCustomSnackBar(
      'Please wait while your materials are being updated...',
      isError: false,
    );

    try {
      Map<String, dynamic> data = {
        "name": name,
        "unit": unit,
        "price": price,
        "id": id,
      };

      final response = await ApiClient.putData(
        ApiUrl.updateMaterial,
        data,
      );

      if (response.statusCode == 200) {
        Get.find<ProfileController>().getMe();
        showCustomSnackBar('Material updated successfully', isError: false);
      } else {
        showCustomSnackBar(response.body['message'], isError: true);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }

  Future<void> deleteMaterial(String id) async {
    showCustomSnackBar(
      'Please wait while your materials are being deleted...',
      isError: false,
    );

    try {
      final response = await ApiClient.deleteData(ApiUrl.deleteMaterial + id);

      if (response.statusCode == 200) {
        Get.find<ProfileController>().getMe();
        showCustomSnackBar('Material deleted successfully', isError: false);
      } else {
        showCustomSnackBar(response.body['message'], isError: true);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }
  }
}
