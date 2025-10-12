import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';

class VerifayCodeScreen extends StatelessWidget {
  const VerifayCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final email = authController.emailController.value.text;

    final args = Get.arguments;
    final String register = args[0];
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Verify Your Email".tr, leftIcon: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                top: 30.h,
                text: "${"We just sent 4-digit code to".tr} $email",
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                bottom: 20.h,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CustomText(
                top: 30.h,
                text: "Enter Code".tr,
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                bottom: 20.h,
              ),
            ),
            CustomPinCode(controller: authController.otpController.value),
            SizedBox(height: 30.h),
            Obx(() {
              return authController.veryfiOTPLoading.value.isLoading
                  ? const CustomLoader()
                  : CustomButton(
                    onTap: () {
                      if (authController.otpController.value.text.isNotEmpty) {
                        switch (register) {
                          case 'registration':
                            authController.createAccountOTP();
                            break;
                          case 'forgot':
                            authController.resetPasswordOTP();
                            break;
                          default:
                        }
                      } else {
                        showCustomSnackBar("Please Enter OTP", isError: false);
                      }
                    },
                    title: "Verify email".tr,
                  );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Didn’t receive a code".tr,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                ),
                TextButton(
                  onPressed: () {
                    authController.resendOTP();
                  },
                  child: CustomText(
                    text: "Resend".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
