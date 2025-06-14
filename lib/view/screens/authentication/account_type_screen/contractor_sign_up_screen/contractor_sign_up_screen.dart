import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class ContractorSignUpScreen extends StatelessWidget {
  const ContractorSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName: "Contractor Sign Up",
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
                  text: "Create New Account",
                  fontSize: 24.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Center(
                child: CustomText(
                  top: 10.h,
                  text:
                      "Set up your username and password.\nYou can always change it later.",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                  bottom: 20.h,
                ),
              ),
              CustomFormCard(
                title: "Enter Name",
                hintText: "enter your name",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Enter Email Address",
                hintText: "enter your email",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Enter Mobile Number",
                hintText: "enter your number",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Enter New Password",
                hintText: "enter your password",
                controller: TextEditingController(),
              ),
              CustomFormCard(
                title: "Enter Confirm Password",
                hintText: "enter your password",
                controller: TextEditingController(),
              ),
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value) {}),
                  CustomText(
                    text: "I agree to the Terms and Privacy Policy.",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              CustomButton(
                onTap: () {
                  Get.toNamed(AppRoutes.verifayCodeScreen);
                },
                title: "Submit",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account? ",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: CustomText(
                      text: "Login",
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
