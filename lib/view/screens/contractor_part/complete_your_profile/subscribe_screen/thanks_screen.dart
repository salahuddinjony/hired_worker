import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';

import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text('Tap again to exit!'),
      ),
      child: Scaffold(
        appBar: const CustomRoyelAppbar(leftIcon: false),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Thanks For Your Subscription!',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
      
                  Center(child: Image.asset('assets/icons/credit-card.png')),
      
                  const SizedBox(height: 12),
      
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      textAlign: TextAlign.center,
                      "You have successfully signed up as a business user.",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please sign in to get started!",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
      
              SizedBox(
                width: context.width * 0.7,
                child: CustomButton(onTap: () {
                  Get.toNamed(AppRoutes.loginScreen);
                }, title: "Go to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
