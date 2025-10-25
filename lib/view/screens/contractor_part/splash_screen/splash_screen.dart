import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../../utils/app_strings/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () async {
        final String token = await SharePrefsHelper.getString(
          AppConstants.bearerToken,
        );
        final String userRole = await SharePrefsHelper.getString(AppConstants.role);
        final String userIdFromToken = await SharePrefsHelper.getString(
          AppConstants.userId,
        );
        debugPrint("Logged User Token: $token");
        debugPrint("Logged User Role: $userRole");
        debugPrint("Logged User ID: $userIdFromToken");

        if (token.isNotEmpty) {
          if (userRole == "customer") {
            Get.offAllNamed(AppRoutes.customerHomeScreen);
          } else if (userRole == "contractor") {
            if (await SharePrefsHelper.getBool(AppStrings.isProfileComplete) ==
                null) {
              Get.offAllNamed(AppRoutes.seletedMapScreen);
            } else {
              Get.offAllNamed(AppRoutes.homeScreen);
            }
          } else {
            Get.offAllNamed(AppRoutes.onboardingScreen);
          }
        } else {
          Get.offAllNamed(AppRoutes.onboardingScreen);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomText(
              text: "“Discover. Connect.\nGet Things Done”".tr,
              fontSize: 32.w,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              bottom: 50.h,
            ),
          ),
          Center(
            child: CustomText(
              text: "Welcome to Servana".tr,
              fontSize: 24.w,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              bottom: 20.h,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(seconds: 2),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.scale(
          scale: value,
          child: CustomImage(
            imageSrc: AppIcons.logo,
            height: 300.h * value,
            width: 300.w * value,
          ),
              );
            },
          ),
        
        ],
      ),
    );
  }
}
