import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_button/custom_button.dart';

class CustomarServiceContractorDetailsScreen extends StatelessWidget {
  const CustomarServiceContractorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Service Contractor",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Name : Thomas",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "50\$/hr",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            CustomText(
              top: 4,
              text: "Category : Electrician ( Fan installation )",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              bottom: 20,
            ),
            CustomText(
              text: "Requirement Question",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            CustomText(
              text: "Question : Do you have existing wiring ?",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              top: 4,
              text: "Answer : Yes",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              bottom: 20,
            ),
            CustomText(
              text: "Materials",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Ceiling Fan - 1  ",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "100\$/hr",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20,),
        child: CustomButton(onTap: (){
          Get.toNamed(AppRoutes.customerSuccessfullyPaidScreen);
        },title: "Continue",),
      ),
    );
  }
}
