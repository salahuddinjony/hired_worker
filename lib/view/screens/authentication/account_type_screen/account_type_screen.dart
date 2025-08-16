import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import '../../../../utils/app_colors/app_colors.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CustomImage(
                imageSrc: AppIcons.logo,
                width: 150.w,
                height: 150.h,
              ),
            ),
            CustomText(
              top: 80.h,
              text: "Create a New Account".tr,
              fontSize: 24.w,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              bottom: 20.h,
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(
                  AppRoutes.contractorSignUpScreen,
                  arguments: {'isContactor': false},
                );
              },
              fillColor: AppColors.backgroundClr,
              borderWidth: 1,
              isBorder: true,
              textColor: AppColors.black,
              title: "Customer".tr,
            ),
            CustomText(
              top: 12.h,
              bottom: 12.h,
              text: "or".tr,
              fontSize: 20.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(
                  AppRoutes.contractorSignUpScreen,
                  arguments: {'isContactor': true},
                );
              },
              title: "Contractor".tr,
            ),
          ],
        ),
      ),
    );
  }
}
