import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_strings/app_strings.dart';

class GeneralController extends GetxController {
  @override
  void onInit() {
    getPrivacy();
    getTerms();
    getAbout();
    _loadLanguagePreference();
    super.onInit();
  }

  //========== change password ===============
  Rx<TextEditingController> oldPassController =
      TextEditingController(text: kDebugMode ? "12345678" : "").obs;
  Rx<TextEditingController> newPassController =
      TextEditingController(text: kDebugMode ? "123456780" : "").obs;
  Rx<TextEditingController> newConfirmController =
      TextEditingController(text: kDebugMode ? "123456780" : "").obs;

  //========== change password ===============

  RxBool changePasswordLoading = false.obs;
  Future<void> changePassword() async {
    changePasswordLoading.value = true;
    refresh();

    final body = {
      "oldPassword": oldPassController.value.text,
      "newPassword": newPassController.value.text,
      "confirmPassword": newConfirmController.value.text,
    };

    try {
      final response = await ApiClient.patchData(
        ApiUrl.changePassword,
        jsonEncode(body),
      );

      changePasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          response.body['message'] ?? "Password Change successful",
          isError: false,
        );
        Get.back();
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Password Change Failed",
          isError: false,
        );
      }
    } catch (e) {
      changePasswordLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  //========== privacy policy ===============
  RxString about = ''.obs;

  Future<void> getAbout() async {
    var response = await ApiClient.getData(ApiUrl.about);

    if (response.statusCode == 200) {
      try {
        var data = response.body['data'];
        about.value = data['description'] ?? '';
      } catch (e) {
        debugPrint("Parsing error: $e");
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //========== privacy policy ===============
  RxString privacy = ''.obs;

  Future<void> getPrivacy() async {
    var response = await ApiClient.getData(ApiUrl.privacyPolicy);

    if (response.statusCode == 200) {
      try {
        var data = response.body['data'];
        privacy.value = data['description'] ?? '';
      } catch (e) {
        debugPrint("Parsing error: $e");
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //========== terms condition ===============
  RxString terms = ''.obs;

  Future<void> getTerms() async {
    var response = await ApiClient.getData(ApiUrl.termsCondition);

    if (response.statusCode == 200) {
      try {
        var data = response.body['data'];
        terms.value = data['description'] ?? '';
      } catch (e) {
        debugPrint("Parsing error: $e");
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  //========== delete account ===============
  final String deleteText = '''
Are you sure you want to delete your account? Please read how account deletion will affect.
Deleting your account removes personal information our database. Your email becomes permanently reserved and same email cannot be re-use to register a new account.
''';
  Future<void> deleteAccount() async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    var response = await ApiClient.deleteData(
      ApiUrl.deleteAccount(userId: userId),
    );

    if (response.statusCode == 200) {
      Get.offAllNamed(AppRoutes.loginScreen);
      SharePrefsHelper.remove(AppConstants.userId);
      SharePrefsHelper.remove(AppConstants.bearerToken);
      SharePrefsHelper.remove(AppConstants.role);
      showCustomSnackBar(
        response.body['message'] ?? "Delete Success",
        isError: false,
      );
    } else {
      showCustomSnackBar(
        response.body['message'] ?? "Delete Failed",
        isError: false,
      );
      ApiChecker.checkApi(response);
    }
  }

  //========= language ===============
  var isChinese = false.obs;

 
  void toggleLanguage(bool value) async {
    isChinese.value = value;
     await SharePrefsHelper.setBool('isChinese', value);
    final newLocale = value ? Locale('zh', 'CN') : Locale('en', 'US');
    Get.updateLocale(newLocale);
  }

  void _loadLanguagePreference() async {
     isChinese.value = await SharePrefsHelper.getBool('isChinese') ?? false;
    final savedLocale =
        isChinese.value ? Locale('zh', 'CN') : Locale('en', 'US');
    Get.updateLocale(savedLocale);
  }
}
