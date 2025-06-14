import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'dart:convert';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../service/api_check.dart';
import '../../../../service/api_client.dart';
import '../../../../service/api_url.dart';
import '../../../../utils/ToastMsg/toast_message.dart';
import '../../../../utils/app_strings/app_strings.dart';

class AuthController extends GetxController {
  ///======================CONTROLLER=====================
  Rx<TextEditingController> nameController =
      TextEditingController(text: kDebugMode ? "Tayebur Rahman" : "").obs;
  Rx<TextEditingController> phoneController =
      TextEditingController(text: kDebugMode ? "123456789" : "").obs;
  Rx<TextEditingController> emailController =
      TextEditingController(
        text: kDebugMode ? "tayebrayhan10@gmail.com" : "",
      ).obs;

  Rx<TextEditingController> passController =
      TextEditingController(text: kDebugMode ? "12345678" : "").obs;
  Rx<TextEditingController> confirmController =
      TextEditingController(text: kDebugMode ? "12345678" : "").obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<bool> isAgree = false.obs;

  ///=====================LOGIN METHOD=====================
  RxBool loginLoading = false.obs;
  Future<void> loginUser() async {
    loginLoading.value = true;
    refresh();
 
    final body = {
      "email": emailController.value.text.trim(),
      "password": passController.value.text,
    };

    try {
      final response = await ApiClient.postData(ApiUrl.login, jsonEncode(body));

      loginLoading.value = false;
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        final user = data['user'];
        final role = user['authId']['role'];

        await SharePrefsHelper.setString(
          AppConstants.bearerToken,
          data['accessToken'],
        );
        await SharePrefsHelper.setString(AppConstants.userId, data['id']);
        await SharePrefsHelper.setString(AppConstants.role, role);

        // showCustomSnackBar(
        //   response.body['message'] ?? "Login successful",
        //   isError: false,
        // );

        // if (role == "USER") {
        //   Get.offAllNamed(AppRoutes.candidateHomeScreen);
        // } else {
        //   Get.offAllNamed(AppRoutes.employerHomeScreen);
        // }
      } else {
        _handleLoginError(response);

        showCustomSnackBar(
          response.body['message'] ?? "Login Failed",
          isError: false,
        );
      }
    } catch (e) {
      loginLoading.value = false;
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  void _handleLoginError(Response response) {
    loginLoading.value = false;
    refresh();

    if (response.statusText == ApiClient.somethingWentWrong) {
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  // ///=====================Register METHOD=====================
  // RxBool signUpLoading = false.obs;

  // RxBool isUser = true.obs;

  // void setUser() {
  //   isUser.value = !isUser.value;
  // }

  // void selectUser() => isUser.value = true;
  // void selectEmployer() => isUser.value = false;

  // Future<void> signUp() async {
  //   String role = isUser.value ? 'USER' : 'EMPLOYER';

  //   signUpLoading.value = true;
  //   var body = {
  //     "name": nameController.value.text,
  //     "email": emailController.value.text,
  //     "phone_number": phoneController.value.text,
  //     "password": passController.value.text,
  //     "confirmPassword": confirmController.value.text,
  //     "role": role,
  //   };

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.register,
  //       jsonEncode(body),
  //     );

  //     signUpLoading.value = false;
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Register successful",
  //         isError: false,
  //       );
  //       otpController.value.dispose();
  //       otpController.value = TextEditingController();
  //       Get.toNamed(AppRoutes.verifayCodeScreen, arguments: ['registration']);
  //     } else {
  //       _handleLoginError(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Register Failed",
  //         isError: false,
  //       );
  //       ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     signUpLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   signUpLoading.value = false;
  //   signUpLoading.refresh();
  // }

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

  // /// ========== forget Password METHOD ===========
  // RxBool forgetPasswordLoading = false.obs;

  // Future<void> forgetPassword() async {
  //   forgetPasswordLoading.value = true;
  //   var body = {"email": emailController.value.text};

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.forgetPassword,
  //       jsonEncode(body),
  //     );

  //     forgetPasswordLoading.value = false;
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       showCustomSnackBar(
  //         response.body['message'] ?? " OTP Sent successful",
  //         isError: false,
  //       );
  //       otpController.value.dispose();
  //       otpController.value = TextEditingController();
  //       Get.toNamed(AppRoutes.verifayCodeScreen, arguments: ['null']);
  //     } else {
  //       _handleLoginError(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? " OTP Sent Failed",
  //         isError: false,
  //       );
  //       ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     forgetPasswordLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   forgetPasswordLoading.value = false;
  //   forgetPasswordLoading.refresh();
  // }

  // /// ========== veryfi OTP METHOD  ===========
  // RxBool veryfiOTPLoading = false.obs;

  // Future<void> veryfiOTP() async {
  //   veryfiOTPLoading.value = true;
  //   var body = {
  //     "code": otpController.value.text,
  //     "email": emailController.value.text,
  //   };

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.veryfiOTP,
  //       jsonEncode(body),
  //     );

  //     veryfiOTPLoading.value = false;
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       showCustomSnackBar(
  //         response.body['message'] ?? "OTP Verification successful",
  //         isError: false,
  //       );

  //       Get.offAllNamed(AppRoutes.resetPasswordScreen);
  //     } else {
  //       _handleLoginError(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? "OTP Verification Failed",
  //         isError: false,
  //       );
  //       ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     veryfiOTPLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   veryfiOTPLoading.value = false;
  //   veryfiOTPLoading.refresh();
  // }

  // ////================ resend otp METHOD===========

  // RxBool resendOTPLoading = false.obs;

  // Future<void> resendOTP() async {
  //   resendOTPLoading.value = true;
  //   var body = {"email": emailController.value.text};

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.veryfiOTPresend,
  //       jsonEncode(body),
  //     );

  //     resendOTPLoading.value = false;
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
  //     resendOTPLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   resendOTPLoading.value = false;
  //   resendOTPLoading.refresh();
  // }

  // /// ========== Set New Password METHOD ===========
  // RxBool setNewPasswordLoading = false.obs;

  // Future<void> setNewPassword() async {
  //   setNewPasswordLoading.value = true;
  //   var body = {
  //     "newPassword": passController.value.text,
  //     "confirmPassword": confirmController.value.text,
  //   };

  //   try {
  //     final response = await ApiClient.postData(
  //       ApiUrl.setNewPassword(email: emailController.value.text),
  //       jsonEncode(body),
  //     );

  //     setNewPasswordLoading.value = false;
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Set Password successful",
  //         isError: false,
  //       );
  //       Get.offAllNamed(AppRoutes.loginScreen);
  //     } else {
  //       _handleLoginError(response);
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Set Password  Failed",
  //         isError: false,
  //       );
  //       ApiChecker.checkApi(response);
  //     }
  //   } catch (e) {
  //     setNewPasswordLoading.value = false;
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }

  //   setNewPasswordLoading.value = false;
  //   setNewPasswordLoading.refresh();
  // 
  }

