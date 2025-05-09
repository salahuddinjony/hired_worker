import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import 'widget/custom_review_list.dart';
import 'widget/custom_skills_container.dart';

class CustomerContractorProfileViewScreen extends StatelessWidget {
  const CustomerContractorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imageUrl: AppConstants.electrician,
            height: MediaQuery.sizeOf(context).height / 3,
            width: MediaQuery.sizeOf(context).width,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            child: CustomRoyelAppbar(leftIcon: true),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Thomas",
                          fontSize: 24.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text: "Electrician (AC Repair)",
                          fontSize: 18.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CustomImage(imageSrc: AppIcons.callCircle),
                        SizedBox(width: 12.w),
                        CustomImage(imageSrc: AppIcons.heartMajor),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Card(
                  color: AppColors.white,
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CustomImage(imageSrc: AppImages.likeImage),
                            CustomText(
                              text: "4.8",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "Rating",
                              fontSize: 10.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomImage(imageSrc: AppImages.clickImage),
                            CustomText(
                              text: "56 Orders",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "Completed ",
                              fontSize: 10.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            CustomImage(imageSrc: AppImages.manPower),
                            CustomText(
                              text: "4 Years",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "Experience",
                              fontSize: 10.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Skills",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    bottom: 8.h,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomSkillsContainer(text: "Fan Installation"),
                      CustomSkillsContainer(text: "AC Repair"),
                      CustomSkillsContainer(text: "AC Installation"),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(onTap: () {
                  Get.toNamed(AppRoutes.customarQaScreen);
                }, title: "Book"),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    top: 20,
                    text: "Available",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    bottom: 8.h,
                  ),
                ),
                Row(
                  children: [
                    CustomSkillsContainer(text: "7:00AM"),
                    CustomText(
                      text: "To",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_08,
                      right: 6,
                    ),
                    CustomSkillsContainer(text: "10:00PM"),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    top: 20,
                    text: "Bio",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    bottom: 8.h,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text:
                        "I'm Logan , a dedicated Electrician professional with a passion for delivering top notch service to ensure your home's Electricity runs smoothly. With years of hands-on experience.",
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    maxLines: 10,
                    textAlign: TextAlign.start,
                    color: AppColors.black,
                    bottom: 10.h,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: "Review",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    bottom: 8.h,
                  ),
                ),
               Column(
                 children: List.generate(4, (value){
                   return CustomReviewList();
                 }),
               )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
