import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class PricingCard extends StatelessWidget {
  final String hourlyRate;

  const PricingCard({Key? key, required this.hourlyRate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.currency_exchange,
                    size: 20.w,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 12.w),
                CustomText(
                  text: "Hourly Rate",
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black_08,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        CustomText(
                          text: "\$ ",
                          fontSize: 20.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        CustomText(
                          text: hourlyRate,
                          fontSize: 32.w,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text: "/hr",
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_08,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: "Professional Rate",
                      fontSize: 12.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_08,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, size: 14.w, color: Colors.green),
                      SizedBox(width: 4.w),
                      CustomText(
                        text: "Competitive",
                        fontSize: 11.w,
                        fontWeight: FontWeight.w500,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(height: 16.h),
            // Container(
            //   padding: EdgeInsets.all(12.w),
            //   decoration: BoxDecoration(
            //     color: AppColors.primary.withValues(alpha: 0.05),
            //     borderRadius: BorderRadius.circular(8.r),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(Icons.info_outline, size: 16.w, color: AppColors.primary),
            //       SizedBox(width: 8.w),
            //       Expanded(child: CustomText(text: "Rate includes all basic tools and materials", fontSize: 12.w, fontWeight: FontWeight.w400, color: AppColors.black_08, maxLines: 2)),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
