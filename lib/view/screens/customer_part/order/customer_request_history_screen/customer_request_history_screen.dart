import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class CustomerRequestHistoryScreen extends StatelessWidget {
  const CustomerRequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Request History"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Service Request History",
              fontSize: 14.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              bottom: 30.h,
            ),
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
                      text: "House Cleaning",
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
            Divider(thickness: .6, color: AppColors.white),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Status",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6F767E),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffCDB3CD),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: CustomText(
                    text: "Pending",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                CustomImage(imageSrc: AppIcons.calenderIcon),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "8:00-9:00 AM,  09 Dec",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      bottom: 4.h,
                    ),
                    CustomText(
                      text: "Schedule",
                      fontSize: 12.w,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6F767E),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Row(
                children: [
                  CircleAvatar(
                    //  foregroundColor: AppColors.red,
                    radius: 26,
                    //  backgroundColor: Color(0xffCDB3CD),
                    child: CustomImage(imageSrc: AppIcons.girlVactor),
                  ),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Sindenayu",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        bottom: 4.h,
                      ),
                      CustomText(
                        text: "Service provider",
                        fontSize: 12.w,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6F767E),
                      ),
                    ],
                  ),
                ],
              ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffCDB3CD),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        text: "Update",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 6,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.primary,width: .6),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        text: "Cancel",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            Divider(thickness: .6, color: AppColors.white),
            SizedBox(height: 10.h),
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xffCDB3CD),
                  child: CustomImage(imageSrc: AppIcons.ac),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "AC Installation",
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
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Status",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6F767E),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withValues(alpha: .3),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: CustomText(
                    text: "Confirmed",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                CustomImage(imageSrc: AppIcons.calenderIcon),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "8:00-9:00 AM,  09 Dec",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                      bottom: 4.h,
                    ),
                    CustomText(
                      text: "Schedule",
                      fontSize: 12.w,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6F767E),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomNetworkImage(imageUrl: AppConstants.girlsPhoto, height: 35, width: 35,boxShape: BoxShape.circle,),
                    SizedBox(width: 12.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Sindenayu",
                          fontSize: 16.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                          bottom: 4.h,
                        ),
                        CustomText(
                          text: "Service provider",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6F767E),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffCDB3CD),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomImage(imageSrc: AppIcons.call)
                    ),
                    SizedBox(width: 6,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xffCDB3CD),
                        borderRadius: BorderRadius.circular(7),
                      ), child: CustomImage(imageSrc: AppIcons.message)
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
          ],
        ),
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 1),
    );
  }
}
