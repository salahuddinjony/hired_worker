import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomStatusCard extends StatelessWidget {
  const CustomStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xffCDB3CD),
                child: CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 30,
                  width: 30,
                  boxShape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "AC Installation",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    bottom: 6,
                  ),
                  CustomText(
                    text: "Reference Code: #D-571224",
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_08,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(thickness: .6, color: AppColors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Status".tr,
                fontSize: 14.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black_08,
              ),
              Card(
                color: const Color(0xffCDB3CD),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4.0,
                  ),
                  child: CustomText(
                    text: "Confirmed".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.green,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              const CustomImage(imageSrc: AppIcons.calenderIcon),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "8:00-9:00 AM,  09 Dec",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    bottom: 6,
                  ),
                  CustomText(
                    text: "Schedule".tr,
                    fontSize: 12.w,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black_08,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 45,
                    width: 45,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Charli Puth",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        bottom: 6,
                      ),
                      CustomText(
                        text: "Service provider".tr,
                        fontSize: 12.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_08,
                      ),
                    ],
                  ),
                ],
              ),
              Card(
                color: AppColors.primary,
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10.0,
                  ),
                  child: Row(
                    children: [
                      const CustomImage(
                        imageSrc: AppIcons.call,
                        imageColor: AppColors.white,
                      ),
                      CustomText(
                        left: 6.w,
                        text: "Call".tr,
                        fontSize: 18.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          const Divider(thickness: .6, color: AppColors.white),
        ],
      ),
    );
  }
}
