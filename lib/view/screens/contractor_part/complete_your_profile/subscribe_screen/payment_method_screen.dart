import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/extensions/widget_extension.dart';

import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Payment Method"),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select payment gateway"),
                Container(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 1.0.h,
                    horizontal: 6.0.w,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    "Add New",
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ).onTap(() {
                    debugPrint('click on add new button');
                  }),
                ),
              ],
            ),

            SizedBox(height: 16.h),

            Container(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.black12, width: 1.2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 6.0,
                    children: [
                      Icon(Icons.circle),
                      Text(
                        'Stripe',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),

                  SvgPicture.asset("assets/icons/stripe.svg"),
                ],
              ),
            ).onTap(() {

            }),

            Spacer(),

            SizedBox(
              width: context.width * 0.7,
              child: CustomButton(onTap: () {
                Get.toNamed(AppRoutes.thanksScreen);
              }, title: "Continue".tr),
            ),

            const SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}
