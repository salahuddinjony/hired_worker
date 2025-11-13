import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Obx(() {
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CustomImage(
                      imageSrc: AppIcons.logo,
                      width: 150.w,
                      height: 150.h,
                    ),
                  ),
                  CustomText(
                    top: 50.h,
                    text: "Welcome Back".tr,
                    fontSize: 24.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                  CustomText(
                    top: 20.h,
                    bottom: 20.h,
                    text:
                        "Log in to your account using mobile\nnumber or email address"
                            .tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                    maxLines: 2,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        CustomFormCard(
                          title: "Email".tr,
                          hintText: "Enter your email".tr,
                          controller: authController.emailController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter an email";
                            } else if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                        ),
                        CustomFormCard(
                          isPassword: true,
                          title: "Password".tr,
                          hintText: "Enter your password".tr,
                          controller: authController.passController.value,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a password";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: authController.rememberMe.value,
                            onChanged: (value) {
                              authController.rememberMe.value = value ?? true;
                            },
                          ),
                          CustomText(
                            text: "Remember me".tr,
                            fontSize: 14.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgotPasswordScreen);
                        },
                        child: CustomText(
                          text: "Forgot Password ?".tr,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.lightBlue,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  authController.loginStatus.value.isLoading
                      ? const CustomLoader()
                      : CustomButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            authController.loginUser();
                          }
                        },
                        title: "Login".tr,
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Don’t have an account?".tr,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.accountTypeScreen);
                        },
                        child: CustomText(
                          text: "Signup".tr,
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
          ),
        );
      }),
    );
  }
}
