import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';
import '../model/customer_order_model.dart';

typedef BookingTapCallback = void Function(BookingResult booking);

class BookingCard extends StatelessWidget {
  final BookingResult booking;
  final bool isCompleted;
  final VoidCallback? onTap;

  BookingCard({Key? key, required this.booking, this.onTap})
    : isCompleted = (booking.status ?? '').toLowerCase() == 'completed',
      super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = isCompleted ? AppColors.green : const Color(0xffCDB3CD);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: borderColor.withValues(alpha: .25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: borderColor.withValues(alpha: .15),
                        child: const CustomImage(imageSrc: AppIcons.cleaner),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: booking.subCategoryId?.name ?? 'Service',
                            fontSize: 16.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                            bottom: 4.h,
                          ),
                          CustomText(
                            text: 'Reference Code: #${booking.id ?? ''}',
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6F767E),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_sharp),
                ],
              ),
              const Divider(thickness: .6, color: AppColors.white),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Status".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff6F767E),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: borderColor.withValues(alpha: .25),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: CustomText(
                      text: booking.status ?? '',
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: isCompleted ? AppColors.green : AppColors.primary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  const CustomImage(imageSrc: AppIcons.calenderIcon),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            '${booking.startTime ?? ''} - ${booking.endTime ?? ''}, ${booking.bookingDate ?? ''}',
                        fontSize: 16.w,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        bottom: 4.h,
                      ),
                      CustomText(
                        text: 'Schedule'.tr,
                        fontSize: 12.w,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6F767E),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 26,
                        child: CustomImage(imageSrc: AppIcons.girlVactor),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                booking.contractorId != null
                                    ? '${booking.contractorId}'
                                    : 'Not Assigned',
                            fontSize: 16.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                            bottom: 4.h,
                          ),
                          CustomText(
                            text: 'Service provider'.tr,
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6F767E),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffCDB3CD),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (isCompleted) {
                              debugPrint('Navigate to message screen');
                            } else {
                              debugPrint('Navigate to update screen');
                            }
                          },
                          child: Row(
                            children: [
                              Icon(
                                isCompleted ? Icons.message : Icons.edit,
                                color: AppColors.primary,
                                size: 18.w,
                              ),
                              SizedBox(width: 6.w),
                              CustomText(
                                text: isCompleted ? 'Message'.tr : 'Update'.tr,
                                fontSize: 14.w,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
