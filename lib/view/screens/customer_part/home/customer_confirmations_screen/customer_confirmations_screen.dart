import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../core/app_routes/app_routes.dart';
import 'widget/custom_status_card.dart';

class CustomerConfirmationsScreen extends StatelessWidget {
  const CustomerConfirmationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Confirmations".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  CustomText(
                    bottom: 10.h,
                    text: "Service Request History".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  const CustomStatusCard(),
                ],
              ),
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.customerHomeScreen);
              },
              title: "Back to Home".tr,
            ),
          ],
        ),
      ),
    );
  }
}
