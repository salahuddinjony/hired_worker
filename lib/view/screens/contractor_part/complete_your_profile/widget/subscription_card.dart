import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class SubscriptionCard extends StatelessWidget {
  final String planName;
  final String price;
  final String duration;
  final List<String> features;
  final VoidCallback onSubscribe;
  final bool isFree;

  const SubscriptionCard({
    super.key,
    required this.planName,
    required this.price,
    required this.duration,
    required this.features,
    required this.onSubscribe,
    this.isFree = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main container
          Container(
            padding: const EdgeInsetsGeometry.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withValues(alpha: 0.7),
                  AppColors.primary.withValues(alpha: 0.5),
                  AppColors.primary.withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 220.h),
                Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      features
                          .asMap()
                          .entries
                          .map(
                            (entry) => CustomText(
                              textAlign: TextAlign.left,
                              maxLines: 10,
                              text: "${entry.key + 1}. ${entry.value}".trim(),
                              fontSize: 20.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.white,
                            ),
                          )
                          .toList(),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.all(20.sp),
                  child: CustomButton(onTap: onSubscribe, title: isFree ? "Free" : "Subscribe".tr),
                ),
              ],
            ),
          ),

          // Price badge
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Center(
              child: Stack(
                children: [
                  CustomImage(imageSrc: AppIcons.shape, height: 150.h),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 30.h,
                    child: Column(
                      children: [
                        CustomText(
                          text: '\$$price',
                          fontSize: 22.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        CustomText(
                          text: duration,
                          fontSize: 23.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Plan name banner
          Positioned(
            top: 0,
            left: 100.w,
            right: 100.w,
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFCDB3CD), Color(0xFFD87DD8)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                color: AppColors.primary,
              ),
              child: CustomText(
                text: planName,
                fontSize: 28.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
