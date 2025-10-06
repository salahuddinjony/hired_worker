import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/screens/customer_part/order/controller/customer_order_controller.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class RequestHistoryServiceDetailsPage extends StatelessWidget {
  const RequestHistoryServiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerOrderController>();

    // If a booking was passed as an argument, show the details for that booking
    final passed = Get.arguments;
    final BookingResult? bookingArg = passed is BookingResult ? passed : null;

    // split bookings into completed and others
    List<BookingResult> all = controller.bookingReportList;
    List<BookingResult> completed =
        all
            .where((b) => (b.status ?? '').toLowerCase() == 'completed')
            .toList();
    List<BookingResult> requests =
        all
            .where((b) => (b.status ?? '').toLowerCase() != 'completed')
            .toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Service Details"),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              bookingArg != null
                  ? buildDetailView(context, bookingArg)
                  : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),
                        TabBar(
                          labelColor: AppColors.black,
                          indicatorColor: AppColors.primary,
                          unselectedLabelColor: Color(0xff6F767E),
                          tabs: [
                            Tab(text: 'Request History'.tr),
                            Tab(text: 'Completed'.tr),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        // Constrain TabBarView to a fixed height so it plays nicely inside a scroll view
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: TabBarView(
                            children: [
                              // Requests list
                              _buildBookingList(requests),
                              // Completed list
                              _buildBookingList(completed),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
        ),
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
                CircleAvatar(
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
                      text: 'Reference Code: #${booking.id ?? ''}',
                      fontSize: 12.w,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6F767E),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xffCDB3CD),
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
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        Divider(thickness: .3, color: AppColors.black_02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Name : ${booking.contractorId ?? 'N/A'}",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              text: "${booking.price ?? ''} \\",
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
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        Divider(thickness: .3, color: AppColors.black_02),
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
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        Divider(thickness: .3, color: AppColors.black_02),
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
            color: Color(0xff6F767E),
          ),
        CustomText(
          top: 20,
          text: "Booking Type".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        Divider(thickness: .3, color: AppColors.black_02),
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
        CustomText(
          top: 20,
          text: "Durations".tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        Divider(thickness: .3, color: AppColors.black_02),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "${booking.startTime ?? ''} - ${booking.endTime ?? ''}",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              text: "(${booking.duration ?? ''} Minutes)",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
        SizedBox(height: 30),
        CustomButton(
          onTap: () {
            Get.toNamed('/customarServiceDetailsScreen');
          },
          title: "Service Update".tr,
        ),
      ],
    );
  }

  Widget _buildBookingList(List<BookingResult> list) {
    if (list.isEmpty) {
      return Center(child: Text('No data available'.tr));
    }

    return ListView.separated(
      padding: EdgeInsets.only(top: 8, bottom: 16),
      itemBuilder: (context, index) {
        final booking = list[index];
        return Column(
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
                          text: 'Reference Code: #${booking.id ?? ''}',
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6F767E),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xffCDB3CD),
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
            SizedBox(height: 12.h),
            Row(
              children: [
                CustomImage(imageSrc: AppIcons.calenderIcon),
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
                      color: Color(0xff6F767E),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
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
                          fontSize: 14.w,
                          fontWeight: FontWeight.w700,
                          bottom: 4.h,
                        ),
                        CustomText(
                          text: booking.bookingType ?? '',
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6F767E),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffCDB3CD),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        text: 'Update'.tr,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: AppColors.primary, width: .6),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: CustomText(
                        text: 'Cancel'.tr,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(thickness: .6, color: AppColors.white),
          ],
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemCount: list.length,
    );
  }
}
