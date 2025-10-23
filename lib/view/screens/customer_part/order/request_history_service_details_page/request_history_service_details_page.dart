import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/extension/extension.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../review_page/review_page.dart';
import '../../../../../utils/app_icons/app_icons.dart';
import '../../../../components/custom_image/custom_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class RequestHistoryServiceDetailsPage extends StatelessWidget {
  const RequestHistoryServiceDetailsPage({super.key});

  // // Payment checkout method
  // Future<void> initiatePaymentCheckout(BookingResult booking) async {
  //   try {
  //     // Show EasyLoading indicator
  //     EasyLoading.show(
  //       status: 'Processing payment...'.tr,
  //       maskType: EasyLoadingMaskType.black,
  //     );

  //     // Prepare request body as JSON string
  //     final Map<String, dynamic> requestBody = {
  //       "bookingId": booking.bookingId ?? "",
  //       "amount": booking.totalAmount ?? 0,
  //     };

  //     debugPrint('Payment checkout request: $requestBody');

  //     final response = await ApiClient.postData(
  //       ApiUrl.createCheckoutSession,
  //       jsonEncode(requestBody),
  //     );

  //     EasyLoading.dismiss();

  //     debugPrint('Payment checkout response: ${response.body}');

  //     if (response.statusCode == 200 &&
  //         response.body != null &&
  //         response.body['success'] == true) {
  //       final String checkoutUrl = response.body['data'];

  //       debugPrint('Opening payment URL: $checkoutUrl');

  //       // Navigate to custom WebView screen with back button
  //       final result = await Get.to(
  //         () => const PaymentWebViewScreen(),
  //         arguments: checkoutUrl,
  //       );

  //       // Handle the result from WebView
  //       if (result == 'success') {
  //         EasyLoading.showSuccess(
  //           'Payment completed successfully'.tr,
  //           duration: const Duration(seconds: 2),
  //         );
  //         // Optionally refresh the booking data or navigate back
  //         Get.back();
  //       } else if (result == 'cancelled') {
  //         EasyLoading.showInfo(
  //           'Payment was cancelled'.tr,
  //           duration: const Duration(seconds: 2),
  //         );
  //       }
  //     } else {
  //       EasyLoading.showError(
  //         response.body?['message'] ?? 'Failed to create payment checkout',
  //         duration: const Duration(seconds: 2),
  //       );
  //     }
  //   } catch (e) {
  //     // Dismiss EasyLoading if still open
  //     EasyLoading.dismiss();
  //     debugPrint('Payment checkout error: $e');
  //     EasyLoading.showError(
  //       'An error occurred during payment checkout'.tr,
  //       duration: const Duration(seconds: 2),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final passed = Get.arguments;
    final BookingResult? bookingArg = passed is BookingResult ? passed : null;

    // split bookings into completed and others

    return Scaffold(
      appBar: const CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Service Details",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // keep horizontal padding and ensure bottom padding so button isn't hidden
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            // add extra bottom padding to account for system insets (gesture nav / keyboard)
            bottom: 24.h + MediaQuery.of(context).viewPadding.bottom,
          ),
          child: buildDetailView(context, bookingArg!),
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
                      text: booking.bookingId.toString(),
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
            Builder(
              builder: (context) {
                final status = (booking.status ?? '').toLowerCase();

                // Define colors based on status
                Color backgroundColor;
                Color textColor;

                switch (status) {
                  case 'completed':
                    backgroundColor = Colors.green.withValues(alpha: .15);
                    textColor = Colors.green.shade700;
                    break;
                  case 'accepted':
                    backgroundColor = Colors.blue.withValues(alpha: .15);
                    textColor = Colors.blue.shade700;
                    break;
                  case 'ongoing':
                  case 'on-going':
                    backgroundColor = Colors.purple.withValues(alpha: .15);
                    textColor = Colors.purple.shade700;
                    break;
                  case 'pending':
                    backgroundColor = Colors.amber.withValues(alpha: .15);
                    textColor = Colors.amber.shade800;
                    break;
                  case 'rejected':
                  case 'cancelled':
                    backgroundColor = Colors.red.withValues(alpha: .15);
                    textColor = Colors.red.shade700;
                    break;
                  default:
                    backgroundColor = const Color(0xffCDB3CD);
                    textColor = AppColors.primary;
                }

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: CustomText(
                    text: booking.status ?? '',
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                );
              },
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
                  "${booking.rateHourly != null ? 'AUD ${booking.rateHourly}/hr' : ''}",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
        CustomText(
          top: 4,
          text: "Task : ${booking.subCategoryId?.name ?? ''}",
          fontSize: 16.w,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
          bottom: 20,
        ),
        CustomText(
          text: "Required Questions".tr,
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
                  text:
                      "${m.name ?? ''} - ${m.count ?? ''} x AUD ${m.price ?? ''}",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "AUD ${(m.price ?? 0) * (m.count ?? 0)}",
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
              text: booking.bookingType == 'oneTime' ? 'One Time' : 'Weekly',
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
        Card(
          margin: EdgeInsets.only(top: 20.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            child: Builder(
              builder: (context) {
                final status = (booking.paymentStatus ?? '').toLowerCase();
                final bool isPaid = status == 'paid';
                final bool isPending =
                    status == 'pending' || status == 'awaiting';
                final Color bgColor =
                    isPaid
                        ? Colors.green.withValues(alpha: .12)
                        : isPending
                        ? Colors.orange.withValues(alpha: .12)
                        : Colors.red.withValues(alpha: .08);
                final Color fgColor =
                    isPaid
                        ? Colors.green
                        : isPending
                        ? Colors.orange
                        : Colors.red;
                final IconData icon =
                    isPaid
                        ? Icons.check_circle_outline
                        : isPending
                        ? Icons.hourglass_top
                        : Icons.cancel_outlined;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(icon, color: fgColor, size: 28.w),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Payment Status".tr,
                            fontSize: 14.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                          SizedBox(height: 6.h),
                          CustomText(
                            text: booking.paymentStatus.safeCap(),
                            fontSize: 16.w,
                            fontWeight: FontWeight.w600,
                            color: fgColor,
                          ),
                          if (booking.paymentStatus?.toLowerCase() == 'paid' &&
                              booking.totalAmount != null) ...[
                            SizedBox(height: 6.h),
                            CustomText(
                              text: "Amount Paid: AUD ${booking.totalAmount}",
                              fontSize: 14.w,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff6F767E),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: fgColor.withOpacity(0.18)),
                      ),
                      child: Text(
                        (isPaid
                            ? 'Paid'
                            : isPending
                            ? 'Pending'
                            : 'Unpaid'),
                        style: TextStyle(
                          fontSize: 13.w,
                          fontWeight: FontWeight.w600,
                          color: fgColor,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        CustomText(
          top: 20,
          text: "Total Amount".tr + ": AUD ${booking.totalAmount ?? '0'}",
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          color: AppColors.black,
        ),
        const SizedBox(height: 30),
        booking.status?.toLowerCase() == 'completed'
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
            : booking.status?.toLowerCase() == 'pending'
            ? CustomButton(
              onTap: () {
                final controller = Get.find<ContractorBookingController>();
                Get.toNamed(
                  AppRoutes.customarMaterialsScreen,
                  arguments: {
                    'contractorId': booking.contractorId?.id,
                    'subcategoryId': booking.subCategoryId?.id ?? '',
                    'materials': booking.material,
                    'controller': controller,
                    'contractorName': booking.contractorId?.fullName,
                    'categoryName': "",
                    'subCategoryName': booking.subCategoryId?.name ?? '',
                    'bookingType': booking.bookingType ?? 'oneTime',
                    'duration': booking.duration?.toString() ?? '1',
                    'startTime': booking.startTime ?? '',
                    'endTime': booking.endTime ?? '',
                    'selectedDates':
                        booking.day is List
                            ? (booking.day as List)
                                .map((e) => e.toString())
                                .toList()
                            : booking.day is String
                            ? [booking.day as String]
                            : [],
                    'hourlyRate': booking.rateHourly ?? 0,
                    'bookingId': booking.id,
                    'isUpdate': true,
                  },
                );
              },
              title: "Service Update".tr,
            )
            : CustomButton(
              onTap: () {
                Get.back();
              },
              title: "Back".tr,
            ),
      ],
    );
  }
}
