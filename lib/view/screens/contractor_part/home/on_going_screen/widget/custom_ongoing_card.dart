import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import 'package:servana/view/screens/contractor_part/home/controller/on_going_controller.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomOngoingCard extends StatelessWidget {
  final int index;

  const CustomOngoingCard({super.key, required this.index});

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
                imageUrl: AppConstants.electrician,
                height: 170.h,
                width: 126.w,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "In Progress",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    bottom: 10.h,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 20),
                      CustomText(
                        text: "38 Chestnut Street Staunton",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
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
                        text: "${data.totalAmount} \$ ",
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
                            data.day == null || data.day!.length != 2
                                ? " - "
                                : "${data.day?[0] ?? ""} - ${data.day?[1] ?? ""}",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Flexible(
                child: CustomButton(
                  height: 35,
                  onTap: () {},
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
                  onTap: () => (),
                  title: "Finish".tr,
                  fillColor: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(
            thickness: .5,
            color: AppColors.primary.withValues(alpha: .5),
          ),
        ],
      ),
    );
  }
}
