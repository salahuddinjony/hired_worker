import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class CustomerSuccessfullyPaidScreen extends StatelessWidget {
  const CustomerSuccessfullyPaidScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomRoyelAppbar(leftIcon: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: CustomText(
                text: "Successfully Paid".tr,
                fontSize: 24.w,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
            const CustomImage(imageSrc: AppImages.cardImage),
            CustomText(
              text: "You have successfully signed up for Business user.\nLet’s setup your Business now".tr,
              fontSize: 14.w,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            CustomButton(onTap: (){
              Get.toNamed(AppRoutes.customerConfirmationsScreen);
            }, title: "Continue".tr,)
          ],
        ),
      ),
    );
  }
}
