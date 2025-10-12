import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/screens/customer_part/order/controller/customer_order_controller.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../review_page/review_page.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class RequestHistoryServiceDetailsPage extends StatelessWidget {
  const RequestHistoryServiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerOrderController>();

    final passed = Get.arguments;
    final BookingResult? bookingArg = passed is BookingResult ? passed : null;

    // split bookings into completed and others

    return Scaffold(
      appBar: const CustomRoyelAppbar(leftIcon: true, titleName: "Service Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: buildDetailView(context, bookingArg!),
      ),
    );
  }

  Widget buildDetailView(BuildContext context, BookingResult booking) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Color(0xffCDB3CD),
                  child: CustomImage(imageSrc: AppIcons.cleaner),
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
                      text: '#${booking.bookingId ?? ''}',
                      fontSize: 12.w,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff6F767E),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xffCDB3CD),
                borderRadius: BorderRadius.circular(7),
              ),
              child: CustomText(
                text: booking.status ?? '',
                fontSize: 14.w,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        CustomText(
          top: 20.h,
          text: "Service Contractor".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const Divider(thickness: .3, color: AppColors.black_02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Name : ${booking.contractorId?.fullName ?? 'N/A'}",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              text:
                  "${booking.rateHourly != null ? '\$${booking.rateHourly}/hr' : ''}",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
        CustomText(
          top: 4,
          text: "Category : ${booking.subCategoryId?.name ?? ''}",
          fontSize: 16.w,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          bottom: 20,
        ),
        CustomText(
          text: "Requirement Question".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const Divider(thickness: .3, color: AppColors.black_02),
        if (booking.questions.isNotEmpty) ...[
          CustomText(
            text: "Question : ${booking.questions.first.question ?? ''}",
            fontSize: 16.w,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          CustomText(
            top: 4,
            text: "Answer : ${booking.questions.first.answer ?? ''}",
            fontSize: 16.w,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            bottom: 20,
          ),
        ],
        CustomText(
          text: "Materials".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const Divider(thickness: .3, color: AppColors.black_02),
        if (booking.material.isNotEmpty)
          ...booking.material.map(
            (m) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "${m.name ?? ''}",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "${m.price ?? ''}",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
          )
        else
          CustomText(
            top: 8,
            text: 'No materials'.tr,
            fontSize: 14.w,
            fontWeight: FontWeight.w500,
            color: const Color(0xff6F767E),
          ),
        CustomText(
          top: 20,
          text: "Booking Type".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const Divider(thickness: .3, color: AppColors.black_02),
        Row(
          children: [
            Radio(value: true, groupValue: (true), onChanged: (value) {}),
            CustomText(
              text: booking.bookingType ?? 'One Time',
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
        const SizedBox(height: 8),
        CustomText(
          text: "Schedule".tr,
          fontSize: 16.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const SizedBox(height: 8),
        if (booking.day is String)
          Chip(
            label: Text(
              booking.day as String,
              style: TextStyle(
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
            backgroundColor: const Color(0xffEDEDED),
          )
        else if (booking.day is List)
          () {
            final dayList =
                (booking.day as List).map((e) => e.toString()).toList();
            return dayList.isNotEmpty
                ? Wrap(
                  spacing: 8,
                  children:
                      dayList
                          .map(
                            (day) => Chip(
                              label: Text(
                                day,
                                style: TextStyle(
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ),
                              backgroundColor: const Color(0xffEDEDED),
                            ),
                          )
                          .toList(),
                )
                : CustomText(
                  text: 'No schedule selected'.tr,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff6F767E),
                );
          }()
        else
          CustomText(
            text: 'No schedule available'.tr,
            fontSize: 14.w,
            fontWeight: FontWeight.w500,
            color: const Color(0xff6F767E),
          ),
        CustomText(
          top: 20,
          text: "Durations".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const Divider(thickness: .3, color: AppColors.black_02),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text:
                  "Start: ${booking.startTime ?? ''} - End: ${booking.endTime ?? ''}",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              text: "(${booking.duration ?? ''} Hours)",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
        const SizedBox(height: 30),
        booking.status?.toLowerCase() != 'completed'
            ? CustomButton(
              onTap: () {
                // Navigate to ReviewPage and pass the booking as argument
                Get.to(
                  () => const ReviewPage(),
                  arguments: {'contractorId': booking.contractorId?.id},
                );
                debugPrint(
                  'Navigating to ReviewPage with contractorId: ${booking.contractorId?.id}',
                );
              },
              title: "Review".tr,
            )
            : CustomButton(
              onTap: () {
                Get.toNamed('/customarServiceDetailsScreen');
              },
              title: "Service Update".tr,
            ),
      ],
    );
  }
}
