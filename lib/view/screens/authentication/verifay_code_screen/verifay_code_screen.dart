import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_pin_code/custom_pin_code.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
class VerifayCodeScreen extends StatelessWidget {
  const VerifayCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(titleName: "Verify Your Email",leftIcon: true,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: CustomText(
                top: 30.h,
                text: "We just sent 4-digit code to\nsm**********@.live, enter it bellow ",
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                bottom: 20.h,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: CustomText(
                top: 30.h,
                text: "Enter Code",
                fontSize: 16.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                bottom: 20.h,
              ),
            ),
            CustomPinCode(controller: TextEditingController()),
            SizedBox(height: 30.h,),
            CustomButton(onTap: (){
              Get.toNamed(AppRoutes.seletedMapScreen);
            }, title: "Verify email",),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: "Didn’t receive a code", fontSize: 14.w, fontWeight: FontWeight.w300, color: AppColors.black,),
                TextButton(onPressed: (){
                 // Get.toNamed(AppRoutes.accountTypeScreen);
                }, child: CustomText(text: "Resend", fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.lightBlue,))
              ],
            )
          ],
        ),
      ),
    );
  }
}
