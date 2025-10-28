import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/on_going_controller.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomOngoingCard extends StatelessWidget {
  final int index;
  final bool isShowButton;

  const CustomOngoingCard({super.key, this.isShowButton = true, required this.index,});

  @override
  Widget build(BuildContext context) {
    final BookingModelData data =
        Get.find<OnGoingController>().onGoingBookingList[index];

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: data.subCategoryId?.img ?? "",
                // height: 170.h,
                height: 160.h,
                width: 126.w,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "In Progress",
                          fontSize: 18.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          bottom: 10.h,
                        ),

                        GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.ongoingDetailsScreen, arguments: {'index': index},);
                          },
                          child: Container(
                            padding: const EdgeInsetsGeometry.symmetric(vertical: 2, horizontal: 6,),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: CustomText(
                              text: "View",
                              fontSize: 16.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,

                            ),
                          ),
                        ),

                      ],
                    ),
                    // Row(
                    //   children: [
                    //     const Icon(Icons.location_on_outlined, size: 20),
                    //     CustomText(
                    //       text: "38 Chestnut Street Staunton",
                    //       fontSize: 14.w,
                    //       fontWeight: FontWeight.w400,
                    //       color: AppColors.black,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 8.h),
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: data.customerId?.img ?? "",
                          height: 20,
                          width: 20,
                          boxShape: BoxShape.circle,
                        ),
                        CustomText(
                          left: 8,
                          text: data.customerId?.fullName ?? " - ",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.home_repair_service, size: 20),
                        CustomText(
                          left: 8,
                          text: data.subCategoryId?.name ?? " - ",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.price_check, size: 20),
                        CustomText(
                          left: 8,
                          text: "\$ ${data.totalAmount}",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 20),
                        CustomText(
                          left: 8,
                          text:
                              data.day == null || data.day!.isEmpty
                                  ? " - "
                                  : data.day!.length == 2
                                  ? "${data.day?[0] ?? " - "} - ${data.day?[1] ?? " - "}"
                                  : "${data.day?[0] ?? " - "}",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        Expanded(
                          child: CustomText(
                            left: 8,
                            text: data.location ?? " - ",
                            fontSize: 14.w,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          if (isShowButton) Row(
            children: [
              Flexible(
                child: CustomButton(
                  height: 35,
                  onTap: () {
                    Get.find<OnGoingController>().cancelOrder(data.id!);
                  },
                  title: "Cancel".tr,
                  isBorder: true,
                  fillColor: Colors.transparent,
                  borderWidth: 1,
                  textColor: AppColors.red,
                ),
              ),
              SizedBox(width: 10.w),
              Flexible(
                child: CustomButton(
                  height: 35,
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.uploadPhotoScreen,
                      arguments: {'id': index},
                    );
                  },
                  title: "Finish".tr,
                  fillColor: AppColors.primary,
                ),
              ),
            ],
          ),
          if (isShowButton)  const SizedBox(height: 20),
        ],
      ),
    );
  }
}
