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
    return Scaffold(
      appBar: const CustomRoyelAppbar(leftIcon: false),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            const SizedBox(),
            const SizedBox(),

            Column(
              children: [
                Text(
                  'Thanks of Subscriptions!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                Center(child: Image.asset('assets/icons/credit-card.png')),

                const SizedBox(height: 12),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "You have successfully signed up for business user.",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Let's setup your business now.",
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
    );
  }
}
