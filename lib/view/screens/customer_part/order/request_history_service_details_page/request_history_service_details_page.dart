import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class RequestHistoryServiceDetailsPage extends StatelessWidget {
  const RequestHistoryServiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Service Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Color(0xffCDB3CD),
                      child: CustomImage(imageSrc: AppIcons.cleaner),
                    ),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "House Cleaning".tr,
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          bottom: 4.h,
                        ),
                        CustomText(
                          text: "Reference Code: #D-571224",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6F767E),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffCDB3CD),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: CustomText(
                    text: "Pending".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            CustomText(
              top: 20.h,
              text: "Service Contractor".tr,
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
              text: "Requirement Question".tr,
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
              text: "Materials".tr,
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
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Wire - 10m",
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
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Switchboard - 1",
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
              top: 20,
              text: "Booking Type".tr,
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            Row(
              children: [
                Radio(value: true, groupValue: (true), onChanged: (value) {}),
                CustomText(
                  text: "One Time".tr,
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            CustomText(
              top: 20,
              text: "Durations".tr,
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "09 : 00 Am - 12 : 00 Pm",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "(4 Hours)",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(height: 30),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.customarServiceDetailsScreen);
              },
              title: "Service Update".tr,
            ),
          ],
        ),
      ),
    );
  }
}
