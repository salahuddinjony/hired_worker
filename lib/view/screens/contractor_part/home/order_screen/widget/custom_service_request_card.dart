import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomServiceRequestCard extends StatelessWidget {
  final String title;
  final String rating;
  final DateTime dateTime;
  final String id;
  final String? image;

  const CustomServiceRequestCard({
    super.key,
    required this.title,
    required this.rating,
    required this.dateTime,
    required this.id,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 16, left: 16),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(horizontal: image != null && image!.isNotEmpty ? 0 : 15.w),
        width: MediaQuery.sizeOf(context).width,
        height: 130.h, // Increased height slightly
        decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (image != null && image!.isNotEmpty) ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
              child: CustomNetworkImage(
                imageUrl: image!,
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
                            textAlign: TextAlign.start,
                            text: title,
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
                          text: rating,
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 14,
                          color: AppColors.black_04,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: DateFormat('dd MMM yyyy').format(dateTime),
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
                          onTap: () {
                            Get.find<ContractorHomeController>().acceptOrder(
                              id,
                            );
                          },
                          title: "Accept".tr,
                          height: 26.h,
                          width: 70.w,
                          fontSize: 10.w,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          onTap: () {
                            Get.find<ContractorHomeController>().cancelOrder(
                              id,
                            );
                          },
                          title: "Cancel".tr,
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
                          title: "View".tr,
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
