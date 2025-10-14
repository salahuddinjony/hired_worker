import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/screens/customer_part/home/model/contactor_details_model.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomReviewList extends StatelessWidget {
  final Review reviewData;
  const CustomReviewList({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    final customer = reviewData.customerId;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      margin: EdgeInsets.only(bottom: 12.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  imageUrl: customer?.img ?? AppConstants.girlsPhoto,
                  height: 48.h,
                  width: 48.w,
                  boxShape: BoxShape.circle,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           CustomText(
                              text: customer?.fullName ?? 'Unknown',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: .1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 14.r),
                                SizedBox(width: 4.w),
                                CustomText(
                                  text: reviewData.stars.toString(),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: reviewData.stars > index ? Colors.amber : Colors.grey.shade300,
                            size: 14.r,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            CustomText(
              text: reviewData.description.isNotEmpty ? reviewData.description : 'No comment provided.',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.black_04,
              textAlign: TextAlign.start,
              maxLines: 6,
            ),

            SizedBox(height: 10.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: reviewData.createdAt.split('T').first, // show date only if ISO string
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black_03,
                ),
                // Optional: show "Verified" or helpful actions in future
                const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
