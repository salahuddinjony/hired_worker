import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Forgot Password", leftIcon: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                top: 30.h,
                text: "We will email you a link\nto reset your password.",
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                bottom: 20.h,
              ),
            ),
            CustomFormCard(
              title: "Email",
              hintText: "example@.com",
              controller: authController.emailController.value,
            ),
            SizedBox(height: 30.h),
            Obx(() {
              return authController.forgetPasswordLoading.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                      authController.forgetPassword();
                    },
                    title: "Send",
                  );
            }),
          ],
        ),
      ),
    );
  }
}
