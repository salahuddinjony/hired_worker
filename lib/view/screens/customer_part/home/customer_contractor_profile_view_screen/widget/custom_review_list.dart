import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomReviewList extends StatelessWidget {
  final dynamic reviewData;
  const CustomReviewList({super.key, required this.reviewData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 40.h,
                    width: 40.w,
                    boxShape: BoxShape.circle,
                  ),
                  CustomText(
                    left: 10,
                    text: "Mehedi Bin Ab. Salam",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              CustomText(
                text: "12/12/2024",
                fontSize: 12.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ],
          ),
          SizedBox(height: 6.h,),
          Row(
            children: List.generate(5, (value) {
              return Icon(
                Icons.star,
                color: AppColors.blue,
                size: 14,
              );
            }),
          ),
          CustomText(
            top: 10,
            text:
            "Emily Jani exceeded my expectations! Quick, reliable, and fixed my plumbing issue with precision. Highly recommend.",
            fontSize: 12.w,
            fontWeight: FontWeight.w400,
            color: AppColors.black_04,
            textAlign: TextAlign.start,
            maxLines: 10,
          ),
        ],
      ),
    );
  }
}
