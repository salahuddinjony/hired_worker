import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';

class ContractorSignUpScreen extends StatelessWidget {
  const ContractorSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    bool isContactor = Get.arguments['isContactor'] ?? false;
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "${isContactor ? 'Contractor' : 'Customer'} Sign Up",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  top: 20.h,
                  text: "Create a New Account".tr,
                  fontSize: 24.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Center(
                child: CustomText(
                  top: 10.h,
                  text:
                      "Set up your username and password.\nYou can always change it later.".tr,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                  bottom: 20.h,
                ),
              ),
              CustomFormCard(
                title: "Enter your Name",
                hintText: "enter your name".tr,
                controller: authController.nameController.value,
              ),
              CustomFormCard(
                title: "Enter Email Address".tr,
                hintText: "enter your email".tr,
                controller: authController.emailController.value,
              ),
              CustomFormCard(
                title: "Enter Mobile Number".tr,
                hintText: "enter your number".tr,
                controller: authController.phoneController.value,
              ),
              CustomFormCard(
                title: "Enter New Password".tr,
                hintText: "enter your password".tr,
                controller: authController.passController.value,
              ),
              CustomFormCard(
                title: "Enter Confirm Password".tr,
                hintText: "enter your password".tr,
                controller: authController.confirmController.value,
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  CustomText(
                    text: "I agree to the Terms and Privacy Policy.".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Obx(() {
                return authController.signUpLoading.value.isLoading
                    ? CustomLoader()
                    : CustomButton(
                      onTap: () {
                        authController.customerSignUp(isContactor);
                      },
                      title: "Submit".tr,
                    );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account?".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: CustomText(
                      text: "Login".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
