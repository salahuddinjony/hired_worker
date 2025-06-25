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
import 'dart:convert';

import 'package:servana/utils/app_strings/app_strings.dart';

class AuthController extends GetxController {
  ///======================CONTROLLER=====================
  Rx<TextEditingController> nameController =
      TextEditingController(text: kDebugMode ? "Md Nishad Miah" : "").obs;
  Rx<TextEditingController> phoneController =
      TextEditingController(text: kDebugMode ? "123456789" : "").obs;
  Rx<TextEditingController> emailController =
      TextEditingController(
        text:
            kDebugMode
                ? "milerob944@ethsms.com"
                : "", // lefano5794@ethsms.com contactor //nolocid282@finfave.com user
      ).obs;

  Rx<TextEditingController> passController =
      TextEditingController(text: kDebugMode ? "cus12345" : "").obs;
  Rx<TextEditingController> confirmController =
      TextEditingController(text: kDebugMode ? "cus12345" : "").obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<bool> isAgree = false.obs;

  ///=====================LOGIN METHOD=====================
  Rx<RxStatus> loginLoading = Rx<RxStatus>(RxStatus.success());
  Future<void> loginUser() async {
    loginLoading.value = RxStatus.loading();
    refresh();

    final body = {
      "email": emailController.value.text.trim(),
      "password": passController.value.text,
    };

    try {
      final response = await ApiClient.postData(ApiUrl.login, jsonEncode(body));

      loginLoading.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200) {
        final data = response.body['data'];

        await SharePrefsHelper.setString(
          AppConstants.bearerToken,
          data['accessToken'],
        );
        await getMe();
      } else {
        _handleLoginError(response);

        showCustomSnackBar(
          response.body['message'] ?? "Login Failed",
          isError: false,
        );
      }
    } catch (e) {
      loginLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  void _handleLoginError(Response response) {
    loginLoading.value = RxStatus.success();
    refresh();

    if (response.statusText == ApiClient.somethingWentWrong) {
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  // ================= get me ====================

  Future<void> getMe() async {
    loginLoading.value = RxStatus.loading();
    refresh();
    try {
      final response = await ApiClient.getData(ApiUrl.getMe);

      loginLoading.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        final role = data['role'];

        await SharePrefsHelper.setString(AppConstants.userId, data['_id']);
        await SharePrefsHelper.setString(AppConstants.role, role);

        showCustomSnackBar(
          response.body['message'] ?? "Login successful",
          isError: false,
        );

        switch (role) {
          case 'contractor':
            Get.offAllNamed(AppRoutes.customerHomeScreen);
            break;
          case 'customer':
            Get.offAllNamed(AppRoutes.homeScreen);
            break;
          default:
        }
      } else {
        _handleLoginError(response);

        showCustomSnackBar(
          response.body['message'] ?? "Login Failed",
          isError: false,
        );
      }
    } catch (e) {
      loginLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  ///=====================Register METHOD=====================
  RxBool signUpLoading = false.obs;

  Future<void> customerSignUp(bool isContactor) async {
    signUpLoading.value = true;
    var body = {
      "fullName": nameController.value.text,
      "email": emailController.value.text,
      "password": passController.value.text,
      "contactNo": phoneController.value.text,
      "role": isContactor ? "contractor" : "customer",
    };

    try {
      final response = await ApiClient.postData(
        isContactor ? ApiUrl.contractorRegister : ApiUrl.customerRegister,
        jsonEncode(body),
      );

      signUpLoading.value = false;
      refresh();

      if (response.statusCode == 200) {
        showCustomSnackBar(
          response.body['message'] ?? "Register successful",
          isError: false,
        );
        final data = response.body['data'];
        final role = data['user']['role'];

        await SharePrefsHelper.setString(AppConstants.userId, data['user']['_id']);
        await SharePrefsHelper.setString(AppConstants.role, role);
        await SharePrefsHelper.setString(
          AppConstants.bearerToken,
          data['accessToken'],
        );
        
        otpController.value.dispose();
        otpController.value = TextEditingController();
        Get.toNamed(AppRoutes.verifayCodeScreen, arguments: ['registration']);
      } else {
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? "Register Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      signUpLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    signUpLoading.value = false;
    signUpLoading.refresh();
  }

  // /// ========== active Code METHOD ===========
  // RxBool activeCodeLoading = false.obs;

  // Future<void> activeCode() async {
  //   activeCodeLoading.value = true;
  //   var body = {
  //     "activation_code": otpController.value.text,
  //     "userEmail": emailController.value.text,
  //   };

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.activeUser,
  //       jsonEncode(body),
  //     );

  //     activeCodeLoading.value = false;
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final data = response.body['data'];
  //       final user = data['user'];
  //       final role = user['role'];

  //       await SharePrefsHelper.setString(
  //         AppConstants.bearerToken,
  //         data['accessToken'],
  //       );
  //       await SharePrefsHelper.setString(AppConstants.userId, data['id']);
  //       await SharePrefsHelper.setString(AppConstants.role, role);

  //       showCustomSnackBar(
  //         response.body['message'] ?? "Register successful",
  //         isError: false,
  //       );

  //       if (role == "USER") {
  //         Get.offAllNamed(AppRoutes.candidateHomeScreen);
  //       } else {
  //         Get.offAllNamed(AppRoutes.subscriptionScreen);
  //       }
  //     } else {
  //       _handleLoginError(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Register Failed",
  //         isError: false,
  //       );
  //       ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     activeCodeLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   activeCodeLoading.value = false;
  //   activeCodeLoading.refresh();
  // }

  // /// ========== activeResend METHOD ===========

  // RxBool activeResendLoading = false.obs;

  // Future<void> activeResend() async {
  //   activeResendLoading.value = true;
  //   var body = {"email": emailController.value.text};

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.activeResend,
  //       jsonEncode(body),
  //     );

  //     activeResendLoading.value = false;
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Resend OTP successful",
  //         isError: false,
  //       );
  //     } else {
  //       _handleLoginError(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Resend OTP  Failed",
  //         isError: false,
  //       );
  //       ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     activeResendLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   activeResendLoading.value = false;
  //   activeResendLoading.refresh();
  // }

  /// ========== forget Password METHOD ===========
  RxBool forgetPasswordLoading = false.obs;

  Future<void> forgetPassword() async {
    forgetPasswordLoading.value = true;
    var body = {"email": emailController.value.text};

    try {
      final response = await ApiClient.postData(
        ApiUrl.forgetPassword,
        jsonEncode(body),
      );

      forgetPasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          response.body['message'] ?? " OTP Sent successful",
          isError: false,
        );
        otpController.value.dispose();
        otpController.value = TextEditingController();
        Get.toNamed(AppRoutes.verifayCodeScreen, arguments: ['forgot']);
      } else {
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? " OTP Sent Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      forgetPasswordLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    forgetPasswordLoading.value = false;
    forgetPasswordLoading.refresh();
  }

  /// ========== veryfi OTP METHOD  ===========
  RxBool veryfiOTPLoading = false.obs;

  Future<void> resetPasswordOTP() async {
    veryfiOTPLoading.value = true;
    var body = {
      'Otp': {
        "email": emailController.value.text,
        "otp": int.tryParse(otpController.value.text),
      },
    };

    try {
      final response = await ApiClient.postData(
        ApiUrl.mailForgetOtp,
        jsonEncode(body),
      );
      final data = response.body['data'];

      await SharePrefsHelper.setString(
        AppConstants.bearerToken,
        data['resetToken'],
      );
      veryfiOTPLoading.value = false;
      refresh();

      if (response.statusCode == 200) {
        showCustomSnackBar(
          response.body['message'] ?? "OTP Verification successful",
          isError: false,
        );

        Get.offAllNamed(AppRoutes.resetPasswordScreen);
      } else {
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? "OTP Verification Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      veryfiOTPLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    veryfiOTPLoading.value = false;
    veryfiOTPLoading.refresh();
  }

  //=============== create account otp ============
  Future<void> createAccountOTP() async {
    veryfiOTPLoading.value = true;
    final role = await SharePrefsHelper.getString(AppConstants.role);
    var body = {
      "email": emailController.value.text,
      "otp": int.tryParse(otpController.value.text),
    };

    try {
      final response = await ApiClient.postData(
        ApiUrl.veryfiOTP,
        jsonEncode(body),
      );

      veryfiOTPLoading.value = false;
      refresh();

      if (response.statusCode == 200) {
        showCustomSnackBar(
          response.body['message'] ?? "OTP Verification successful",
          isError: false,
        );
        switch (role) {
          case 'contractor':
            Get.offAllNamed(AppRoutes.seletedMapScreen);
            break;
          case 'customer':
            Get.offAllNamed(AppRoutes.loginScreen);
            break;
          default:
        }
      } else {
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? "OTP Verification Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      veryfiOTPLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    veryfiOTPLoading.value = false;
    veryfiOTPLoading.refresh();
  }

  ////================ resend otp METHOD===========

  RxBool resendOTPLoading = false.obs;

  Future<void> resendOTP() async {
    resendOTPLoading.value = true;
    var body = {"email": emailController.value.text};

    try {
      final response = await ApiClient.postData(
        ApiUrl.veryfiOTPresend,
        jsonEncode(body),
      );

      resendOTPLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          response.body['message'] ?? "Resend OTP successful",
          isError: false,
        );
      } else {
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? "Resend OTP  Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      resendOTPLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    resendOTPLoading.value = false;
    resendOTPLoading.refresh();
  }

  /// ========== Set New Password METHOD ===========
  RxBool setNewPasswordLoading = false.obs;

  Future<void> setNewPassword() async {
    setNewPasswordLoading.value = true;
    var body = {
      "email": emailController.value.text,
      "newPassword": passController.value.text,
    };

    try {
      final response = await ApiClient.postData(
        ApiUrl.setNewPassword,
        jsonEncode(body),
      );

      setNewPasswordLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          response.body['message'] ?? "Set Password successful",
          isError: false,
        );
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? "Set Password  Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      setNewPasswordLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    setNewPasswordLoading.value = false;
    setNewPasswordLoading.refresh();
  }
}
