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
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                text: "Welcome Back",
                fontSize: 24.w,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              CustomText(
                top: 20.h,
                text:
                    "Log in to your account using mobile\nnumber or email address",
                fontSize: 14.w,
                fontWeight: FontWeight.w300,
                color: AppColors.black,
                maxLines: 2,
              ),
              CustomFormCard(
                title: "Email",
                hintText: "Enter your email",
                controller: authController.emailController.value,
              ),
              CustomFormCard(
                title: "Password",
                hintText: "Enter your password",
                controller: authController.passController.value,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (value) {}),
                      CustomText(
                        text: "Remember me",
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
                      text: "Forgot Password ?",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              authController.loginLoading.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                      authController.loginUser();
                    },
                    title: "Login",
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Don’t have an account? ",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.accountTypeScreen);
                    },
                    child: CustomText(
                      text: "Signup",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
