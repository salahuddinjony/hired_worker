import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_colors/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 150.h,
              left: 0,
              right: 0,
              child: Center(child: CustomImage(imageSrc: AppImages.girlOne))),
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
                    text: "Find expert services at\nyour fingertips",
                    fontSize: 32.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                  CustomText(
                    top: 20,
                    text:
                        "From home repairs to beauty care – get all services with ease",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    maxLines: 2,
                    bottom: 20,
                  ),
                  CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.onboardingScreenTwo);
                    },
                    title: "Next",
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
