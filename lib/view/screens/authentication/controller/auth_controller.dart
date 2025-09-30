import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'dart:convert';

import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/screens/contractor_part/profile/model/contractor_model.dart';
import 'package:servana/view/screens/customer_part/profile/model/user_model.dart';

class AuthController extends GetxController {
  ///======================CONTROLLER=====================
  //   Customer
  // losegag554@hiepth.com
  // 12345678

  Rx<TextEditingController> nameController =
      TextEditingController(text: kDebugMode ? "Md Nishad Miah" : "").obs;
  Rx<TextEditingController> phoneController =
      TextEditingController(text: kDebugMode ? "123456789" : "").obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;

  Rx<TextEditingController> passController = TextEditingController().obs;
  Rx<TextEditingController> confirmController =
      TextEditingController(text: kDebugMode ? "12345" : "").obs;
  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<bool> isAgree = false.obs;

  Rx<bool> rememberMe = true.obs;

  Rx<bool> agreeWithTaP = true.obs;

  @override
  void onInit() async {
    super.onInit();

    bool? rememberMe = await SharePrefsHelper.getBool(AppStrings.rememberMe);

    if (rememberMe != null && rememberMe) {
      String email = await SharePrefsHelper.getString(AppStrings.email);
      String password = await SharePrefsHelper.getString(AppStrings.password);

      emailController.value.text = email;
      passController.value.text = password;
    }
  }

  ///=====================LOGIN METHOD=====================
  Rx<RxStatus> loginStatus = Rx<RxStatus>(RxStatus.success());

  Future<void> loginUser() async {
    loginStatus.value = RxStatus.loading();
    refresh();

    final body = {
      "email": emailController.value.text.trim(),
      "password": passController.value.text,
    };

    try {
      final response = await ApiClient.postData(ApiUrl.login, jsonEncode(body));

      loginStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200) {
        final data = response.body['data'];

        await SharePrefsHelper.setString(
          AppConstants.bearerToken,
          data['accessToken'],
        );
        final token = data['accessToken'];
        debugPrint(
          'Api Token: $token',
        ); // Print the token to the console for debugging

        // Decode JWT token to extract role
        try {
          Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
          String? roleFromToken = decodedToken['role'];
          String? userEmailFromToken = decodedToken['userEmail'];

          if (roleFromToken != null) {
            await SharePrefsHelper.setString(AppConstants.role, roleFromToken);
            debugPrint('Role from JWT: $roleFromToken');
            debugPrint(
              'Role saved in shared preference: ${await SharePrefsHelper.getString(AppConstants.role)}',
            );
          }
          if (userEmailFromToken != null) {
            await SharePrefsHelper.setString(
              AppStrings.email,
              userEmailFromToken,
            );
            debugPrint('User Email from JWT: $userEmailFromToken');
          }
        } catch (e) {
          debugPrint('Error decoding JWT token: $e');
        }

        //saved token in shared preference
        debugPrint(
          'saved in shared preference: $token ${await SharePrefsHelper.getString(AppConstants.bearerToken)}',
        );
        debugPrint(
          'User Role: ${await SharePrefsHelper.getString(AppConstants.role)}',
        );

        if (rememberMe.value) {
          await SharePrefsHelper.setString(
            AppStrings.email,
            emailController.value.text.trim(),
          );
          await SharePrefsHelper.setString(
            AppStrings.password,
            passController.value.text,
          );
        }

        await SharePrefsHelper.setBool(AppStrings.rememberMe, rememberMe.value);

        await getMe();
      } else {
        _handleLoginError(response);

        showCustomSnackBar(
          response.body['message'] ?? "Login Failed",
          isError: false,
        );
      }
    } catch (e) {
      loginStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  void _handleLoginError(Response response) {
    loginStatus.value = RxStatus.success();
    refresh();

    if (response.statusText == ApiClient.somethingWentWrong) {
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    } else {
      ApiChecker.checkApi(response);
    }
  }

  // ================= get me ====================
  Rx<ContractorModel> contractorModel = ContractorModel().obs;
  Rx<CustomerModel> customerModel = CustomerModel().obs;

  Future<void> getMe() async {
    loginStatus.value = RxStatus.loading();
    refresh();
    try {
      final response = await ApiClient.getData(ApiUrl.getMe);

      loginStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body['data'];
        final role = data['role'];

        await SharePrefsHelper.setString(AppConstants.userId, data['_id']);
        await SharePrefsHelper.setString(AppConstants.role, role);
        // SocketApi.init();

        if (role == 'contractor') {
          contractorModel.value = ContractorModel.fromJson(data);
        } else if (role == 'customer') {
          customerModel.value = CustomerModel.fromJson(data);
        }

        showCustomSnackBar(
          response.body['message'] ?? "Login successful",
          isError: false,
        );

        switch (role) {
          case 'contractor':
            Get.offAllNamed(AppRoutes.homeScreen);
            break;
          case 'customer':
            Get.offAllNamed(AppRoutes.customerHomeScreen);
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
      loginStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  ///=====================Register METHOD=====================
  Rx<RxStatus> signUpLoading = Rx<RxStatus>(RxStatus.success());

  Future<void> customerSignUp(bool isContactor) async {
    debugPrint('Starting customerSignUp - isContractor: $isContactor');
    debugPrint('Agreement status: ${agreeWithTaP.value}');

    if (!agreeWithTaP.value) {
      showCustomSnackBar(
        'You must first agree with our Terms and Privacy Policy',
      );
      return;
    }

    if (!agreeWithTaP.value) {
      showCustomSnackBar(
        'You must first agree with our Terms and Privacy Policy',
      );
    }

    signUpLoading.value = RxStatus.loading();
    var body = {
      "fullName": nameController.value.text,
      "email": emailController.value.text,
      "password": passController.value.text,
      "contactNo": phoneController.value.text,
      "role": isContactor ? "contractor" : "customer",
    };

    debugPrint('Registration payload: $body');

    try {
      final response = await ApiClient.postData(
        isContactor ? ApiUrl.contractorRegister : ApiUrl.customerRegister,
        jsonEncode(body),
      );

      signUpLoading.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200) {
        debugPrint(
          'Registration successful - Status Code: ${response.statusCode}',
        );
        debugPrint('Response body: ${response.body}');
        showCustomSnackBar(
          response.body['message'] ?? "Register successful",
          isError: false,
        );
        final data = response.body['data'];
        final role = data['user']['role'];
        debugPrint('User role after registration: $role');

        await SharePrefsHelper.setString(
          AppConstants.userId,
          data['user']['_id'],
        );
        await SharePrefsHelper.setString(AppConstants.role, role);
        await SharePrefsHelper.setString(
          AppConstants.bearerToken,
          data['accessToken'],
        );

        // Clear OTP controller text instead of disposing
        otpController.value.clear();
        debugPrint(
          'Navigating to OTP verification screen with arguments: [registration]',
        );
        Get.toNamed(AppRoutes.verifayCodeScreen, arguments: ['registration']);
        debugPrint(
          'Navigation call completed - should be going to OTP screen now',
        );
      } else {
        debugPrint('Registration failed - Status Code: ${response.statusCode}');
        debugPrint('Error response body: ${response.body}');
        _handleLoginError(response);
        showCustomSnackBar(
          response.body['message'] ?? "Register Failed",
          isError: false,
        );
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("Error occurred during sign up: $e");
      signUpLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    signUpLoading.value = RxStatus.success();
    signUpLoading.refresh();
  }

  /// ========== forget Password METHOD ===========
  Rx<RxStatus> forgetPasswordLoading = Rx<RxStatus>(RxStatus.success());

  Future<void> forgetPassword() async {
    forgetPasswordLoading.value = RxStatus.loading();
    var body = {"email": emailController.value.text};

    try {
      final response = await ApiClient.postData(
        ApiUrl.forgetPassword,
        jsonEncode(body),
      );

      forgetPasswordLoading.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          response.body['message'] ?? " OTP Sent successful",
          isError: false,
        );
        // Clear OTP controller text instead of disposing
        otpController.value.clear();
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
      forgetPasswordLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    forgetPasswordLoading.value = RxStatus.success();
    forgetPasswordLoading.refresh();
  }

  /// ========== veryfi OTP METHOD  ===========
  Rx<RxStatus> veryfiOTPLoading = Rx<RxStatus>(RxStatus.success());

  Future<void> resetPasswordOTP() async {
    veryfiOTPLoading.value = RxStatus.loading();
    var body = {
        "email": emailController.value.text,
        "otp": int.tryParse(otpController.value.text),
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
      veryfiOTPLoading.value = RxStatus.success();
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
      veryfiOTPLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    veryfiOTPLoading.value = RxStatus.success();
    veryfiOTPLoading.refresh();
  }

  //=============== create account otp ============
  Future<void> createAccountOTP() async {
    veryfiOTPLoading.value = RxStatus.loading();
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

      veryfiOTPLoading.value = RxStatus.success();
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
      veryfiOTPLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    veryfiOTPLoading.value = RxStatus.success();
    veryfiOTPLoading.refresh();
  }

  ////================ resend otp METHOD===========

  Rx<RxStatus> resendOTPLoading = Rx<RxStatus>(RxStatus.success());

  Future<void> resendOTP() async {
    resendOTPLoading.value = RxStatus.loading();
    var body = {"email": emailController.value.text};

    try {
      final response = await ApiClient.postData(
        ApiUrl.veryfiOTPresend,
        jsonEncode(body),
      );

      resendOTPLoading.value = RxStatus.success();
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
      resendOTPLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    resendOTPLoading.value = RxStatus.success();
    resendOTPLoading.refresh();
  }

  /// ========== Set New Password METHOD ===========
  Rx<RxStatus> setNewPasswordLoading = Rx<RxStatus>(RxStatus.success());

  Future<void> setNewPassword() async {
    setNewPasswordLoading.value = RxStatus.loading();
    var body = {
      "email": emailController.value.text,
      "newPassword": passController.value.text,
    };
    if (passController.value.text != confirmController.value.text) {
      showCustomSnackBar("Password and Confirm Password do not match");
      setNewPasswordLoading.value = RxStatus.success();
      return;
    }

    try {
      final response = await ApiClient.postData(
        ApiUrl.setNewPassword,
        jsonEncode(body),
      );

      setNewPasswordLoading.value = RxStatus.success();
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
      setNewPasswordLoading.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }

    setNewPasswordLoading.value = RxStatus.success();
    setNewPasswordLoading.refresh();
  }
}
