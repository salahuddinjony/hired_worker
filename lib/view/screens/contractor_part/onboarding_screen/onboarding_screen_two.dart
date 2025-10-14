import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../utils/app_colors/app_colors.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150.h,
              left: 0,
              right: 0,
              child: const Center(child: CustomImage(imageSrc: AppImages.girlTwo))),
          Positioned(
            bottom: 0.h,
            right: 0,
            left: 0,
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: 300,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.r),
                  topRight: Radius.circular(25.r),
                ),
              ),
              child: Column(
                children: [
                  CustomText(
                    top: 20,
                    text: "Find expert services at\nyour fingertips".tr,
                    fontSize: 32.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  CustomText(
                    top: 20,
                    text:
                        "From home repairs to beauty care – get all services with ease".tr,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    maxLines: 2,
                    bottom: 20,
                  ),
                  CustomButton(
                    onTap: () async {
                      Get.toNamed(AppRoutes.loginScreen);

                      await SharePrefsHelper.setBool(AppConstants.isFirstTime, false);
                    },
                    title: "Next".tr,
                    width: MediaQuery.sizeOf(context).width / 1.2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
