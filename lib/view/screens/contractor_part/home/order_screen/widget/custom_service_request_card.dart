import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomServiceRequestCard extends StatelessWidget {
  const CustomServiceRequestCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 16, left: 16),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 130.h, // Increased height slightly
        decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
              child: CustomNetworkImage(
                imageUrl: AppConstants.electrician,
                height: 130.h,
                width: 150.w,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomText(
                            text: "Switchboard Install",
                            fontSize: 14.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        CustomNetworkImage(
                          imageUrl: AppConstants.profileImage,
                          height: 20,
                          width: 20,
                          boxShape: BoxShape.circle,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        CustomImage(imageSrc: AppIcons.filled),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: "4.5",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: "(87)",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_07,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.calendar_month, size: 14, color: AppColors.black_04),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: "06 Aug 2023 - 07 Aug 2023",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_04,
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          onTap: () {},
                          title: "Accept",
                          height: 26.h,
                          width: 70.w,
                          fontSize: 10.w,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {},
                          title: "Cancel",
                          height: 26.h,
                          width: 50.w,
                          fontSize: 10.w,
                          fillColor: Colors.transparent,
                          isBorder: true,
                          textColor: AppColors.red,
                          borderRadius: 10,
                          borderWidth: .3,
                        ),
                        CustomButton(
                          onTap: () {},
                          title: "View",
                          height: 26.h,
                          width: 50.w,
                          fontSize: 10.w,
                          fillColor: AppColors.cardClr,
                          textColor: AppColors.black,
                          borderRadius: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
