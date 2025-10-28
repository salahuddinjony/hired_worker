import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import 'package:servana/view/screens/contractor_part/home/order_screen/controller/order_controller.dart';
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
  final String? status;
  final bool isButtonShow;
  final double height;
  final int? index;
  final String? location;
  final String? customerImage;
  final String? customerName;
  final String? subcategoryName;
  final num? hourlyRate;

  const CustomServiceRequestCard({
    super.key,
    required this.title,
    required this.rating,
    required this.dateTime,
    required this.id,
    required this.image,
    required this.status,
    this.isButtonShow = true,
    this.height = 210,
    this.index,
    this.location, this.customerImage, this.customerName, this.subcategoryName, this.hourlyRate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, right: 16, left: 16),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: image != null && image!.isNotEmpty ? 0 : 15.w,
        ),
        width: MediaQuery.sizeOf(context).width,
        height: height.h,
        // Increased height slightly
        decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null && image!.isNotEmpty)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13),
                    ),
                    child: CustomNetworkImage(
                      imageUrl: image!,
                      height: 150.h,
                      width: 150.w,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
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
                            // SizedBox(width: 4.w),
                            // CustomNetworkImage(
                            //   imageUrl: AppConstants.profileImage,
                            //   height: 20,
                            //   width: 20,
                            //   boxShape: BoxShape.circle,
                            // ),
                          ],
                        ),
                        // SizedBox(height: 4.h),
                        // Row(
                        //   children: [
                        //     const CustomImage(imageSrc: AppIcons.filled),
                        //     SizedBox(width: 4.w),
                        //     CustomText(
                        //       text: rating,
                        //       fontSize: 12.w,
                        //       fontWeight: FontWeight.w500,
                        //       color: AppColors.black,
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl: customerImage ?? "",
                              height: 20,
                              width: 20,
                              boxShape: BoxShape.circle,
                            ),
                            CustomText(
                              left: 8,
                              text:  customerName ?? " - ",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ],
                        ),

                        SizedBox(height: 4.h),

                        Row(
                          children: [
                            const Icon(Icons.home_repair_service, size: 20),
                            CustomText(
                              left: 8,
                              text: subcategoryName ?? " - ",
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),


                        CustomText(
                          text: "\$ ${hourlyRate ?? " - "}",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black_04,
                          bottom: 3.h,
                        ),
                        SizedBox(height: 6.h),

                        Row(
                          children: [
                            const Icon(
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

                        SizedBox(height: 6.h),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 14,
                              color: AppColors.black_04,
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: CustomText(
                                text: location ?? " - ",
                                fontSize: 12.w,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black_04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (isButtonShow)
             SizedBox(height: 12.h,),

            if (isButtonShow)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {
                      Get.find<OrderController>().acceptOrder(id);
                    },
                    title: "Accept".tr,
                    height: 26.h,
                    width: 70.w,
                    fontSize: 10.w,
                    borderRadius: 10,
                  ),
                  CustomButton(
                    onTap: () {
                      Get.find<OrderController>().cancelOrder(id);
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
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.orderDetailsScreen1,
                        arguments: {'index': index},
                      );
                    },
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
    );
  }
}
