import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import 'package:servana/view/screens/customer_part/order/payment_webview_screen/payment_webview_screen.dart';
import '../../../../components/custom_button/custom_button.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'dart:convert';

class CustomarServiceContractorDetailsScreen extends StatelessWidget {
  // Payment checkout method
  Future<void> initiatePaymentCheckout(
    BuildContext context,
    ContractorBookingController controller,
    String bookingId,
  ) async {
    try {
      EasyLoading.show(
        status: 'Processing payment...'.tr,
        maskType: EasyLoadingMaskType.black,
      );
      final Map<String, dynamic> requestBody = {
        "bookingId": bookingId,
        "amount": controller.totalAmount,
      };
      debugPrint('Payment checkout request: $requestBody');
      final response = await ApiClient.postData(
        ApiUrl.createCheckoutSession,
        jsonEncode(requestBody),
      );
      EasyLoading.dismiss();
      debugPrint('Payment checkout response: ${response.body}');
      if (response.statusCode == 200 &&
          response.body != null &&
          response.body['success'] == true) {
        final String checkoutUrl = response.body['data'];
        debugPrint('Opening payment URL: $checkoutUrl');
        final result = await Get.to(
          () => const PaymentWebViewScreen(),
          arguments: checkoutUrl,
        );
        if (result == 'success') {
          EasyLoading.showSuccess(
            'Payment completed successfully'.tr,
            duration: const Duration(seconds: 2),
          );
          Get.back();
        } else if (result == 'cancelled') {
          EasyLoading.showInfo(
            'Payment was cancelled'.tr,
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        EasyLoading.showError(
          response.body?['message'] ?? 'Failed to create payment checkout',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      debugPrint('Payment checkout error: $e');
      EasyLoading.showError(
        'An error occurred during payment checkout'.tr,
        duration: const Duration(seconds: 2),
      );
    }
  }

  const CustomarServiceContractorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final ContractorBookingController controller = args['controller'];
    final String contractorId = args['contractorId']?.toString() ?? '';
    final String subcategoryId = args['subcategoryId']?.toString() ?? '';
    final String contractorName = args['contractorName'] ?? '';
    final String categoryName = args['categoryName'] ?? '';
    final String subCategoryName = args['subCategoryName'] ?? '';
    final bool isUpdate = args['isUpdate'] ?? false;
    final String bookingId = args['bookingId']?.toString() ?? '';
    final String updateBookingId = args['updateBookingId']?.toString() ?? '';
    final String paymentedTotalAmountString =
        args['paymentedTotalAmount']?.toString() ?? '0';
    final String contractorIdForTimeSlot =
        args['contractorIdForTimeSlot']?.toString() ?? '';

    final int paymentedTotalAmount = int.tryParse(paymentedTotalAmountString) ?? 0;
    final int totalAmount = controller.totalAmount;
    final bool isUpdateMode = isUpdate == true;
    final int paymentAmount =
        isUpdateMode ? (totalAmount - paymentedTotalAmount) : totalAmount;


    //get parcentegae, its used to calculate payment amount
    controller.getParcentage();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Details".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Service Contractor".tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              const Divider(thickness: .4, color: AppColors.black_02),

              // (contractor details rendered below)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        top: 4,
                        text: "Name : $contractorName",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      CustomText(
                        top: 4,
                        text: "\$ ${controller.hourlyRate}/h",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  CustomText(
                    top: 4,
                    text: "Category : ${categoryName} - ${subCategoryName}",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    bottom: 20,
                  ),
                ],
              ),

              CustomText(
                text: "Required Questions".tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              const Divider(thickness: .4, color: AppColors.black_02),

              // Questions list (read-only answers)
              controller.questions.isEmpty
                  ? CustomText(
                    text: "No Questions".tr,
                    fontSize: 14.w,
                    color: AppColors.black,
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(controller.questions.length, (
                      index,
                    ) {
                      final q = controller.questions[index];
                      final questionText =
                          (q['question']?.toString() ?? q.toString());
                      final answer =
                          (index < controller.questionsAndAnswers.length)
                              ? (controller
                                      .questionsAndAnswers[index]['answer'] ??
                                  '')
                              : '';
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "\u2022 Question : $questionText",
                            fontSize: 14.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          const SizedBox(height: 4),
                          CustomText(
                            text:
                                "Answer  : ${answer.isNotEmpty ? answer : 'Yes'}",
                            fontSize: 14.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            bottom: 12,
                          ),
                        ],
                      );
                    }),
                  ),

              (controller.materialsAndQuantity.any((material) {
                    final countRaw = material['count'] ?? '0';
                    final count = int.tryParse(countRaw.toString()) ?? 0;
                    return count > 0;
                  }))
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Materials".tr,
                        fontSize: 18.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      const Divider(thickness: .4, color: AppColors.black_02),

                      // Materials list (read-only)
                      Column(
                        children: List.generate(
                          controller.materialsAndQuantity.length,
                          (index) {
                            final mat = controller.materialsAndQuantity[index];
                            final countRaw = mat['count'] ?? '0';
                            final count =
                                int.tryParse(countRaw.toString()) ?? 0;
                            if (count <= 0) return const SizedBox.shrink();
                            final rawPrice = mat['price'] ?? '0';
                            final priceDouble =
                                double.tryParse(rawPrice.toString()) ?? 0.0;
                            final totalPrice = priceDouble * count;
                            final name = (mat['name'] ?? '').toString();

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 6.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: CustomText(
                                            text: '\u2022 $name',
                                            fontSize: 14.w,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        CustomText(
                                          text:
                                              '- $count x \$ ${priceDouble.toStringAsFixed(2)}',
                                          fontSize: 14.w,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  CustomText(
                                    text:
                                        '\$ ${totalPrice.toStringAsFixed(2)}',
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const Divider(
                        thickness: .4,
                        color: Color.fromARGB(255, 146, 126, 126),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Materials Total: ",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          const Expanded(child: SizedBox()),
                          CustomText(
                            text:
                                "\$ ${controller.materialsTotalAmount.toStringAsFixed(2)}",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),

              CustomText(
                top: 20,
                text: "Booking Type".tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              const Divider(thickness: .5, color: AppColors.black_02),
              // Read-only booking type
              Row(
                children: [
                  const Icon(
                    Icons.book_online,
                    size: 16,
                    color: AppColors.black_08,
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text:
                        controller.bookingType.value == 'oneTime'
                            ? "Hourly Booking".tr
                            : "Weekly Booking".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (controller.bookingType.value == 'weekly') ...[
                // show selected days for weekly booking
                Row(
                  children: [
                    CustomText(
                      text:
                          "Selected Days: ${controller.selectedDates.length} days - \$ ${controller.selectedDates.length} x ${controller.totalDurationAmount}",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    const Expanded(child: SizedBox()),
                    CustomText(
                      text: "\$ ${controller.weeklyTotalAmount.toString()}",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ],
              CustomText(
                top: 20,
                text: "Durations".tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              const Divider(thickness: .4, color: AppColors.black_02),

              const SizedBox(height: 8),
              // durations display (read-only)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        "Duration : ( ${controller.durations.value} x \$ ${controller.hourlyRate} ) ",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 8),
                  CustomText(
                    text: "\$ ${controller.totalDurationAmount.toString()}",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Duration/time display (read-only)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.black_08,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text:
                        'Start Time'.tr +
                        ": ${controller.startTimeController.value.text}",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  const SizedBox(width: 20),
                  const Icon(
                    Icons.access_time_filled,
                    size: 16,
                    color: AppColors.black_08,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text:
                        'End Time'.tr +
                        ": ${controller.endTimeController.value.text}",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(thickness: .6, color: AppColors.black_02),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 18,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black_02.withValues(alpha: .06),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black_02.withValues(alpha: .08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Total Amount',
                          fontSize: 18.w,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        const SizedBox(height: 10),
                        if (isUpdateMode) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Paid:',
                                fontSize: 15.w,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_08,
                              ),
                              const SizedBox(width: 8),
                            
                              CustomText(
                                text:
                                    '\$ ${paymentedTotalAmount.toStringAsFixed(2)}',
                                fontSize: 18.w,
                                fontWeight: FontWeight.bold,
                                color: AppColors.green,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                          // parcentage amount for per transaction fee
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             Obx(() {
                                return CustomText(
                                  text: 'Booking Fee (${controller.parcentage.value.toStringAsFixed(0)}% of \$${paymentAmount.toStringAsFixed(0)}):',
                                  fontSize: 15.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_08,
                                );
                              }),
                              const SizedBox(width: 8),
                            
                             Obx(() {
                                final parcentageAmount = controller.parcentage.value * paymentAmount / 100;
                                return CustomText(
                                  text:
                                      '\$ ${parcentageAmount.toStringAsFixed(2)}',
                                  fontSize: 18.w,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.red,
                                );
                              })
                            ],
                          ),
                       if(isUpdateMode) ...[
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: 'Payable:',
                                fontSize: 15.w,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_08,
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.black_09.withValues(
                                    alpha: .08,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '\$',
                                        style: TextStyle(
                                          fontSize: 18.w,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.baseline,
                                        baseline: TextBaseline.alphabetic,
                                        child: Obx(() {
                                          final parcentageAmount = controller.parcentage.value * paymentAmount / 100;
                                          final payableAmount = paymentAmount + parcentageAmount;
                                          return Text(
                                            '${payableAmount.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 30.w,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black_09,
                                            ),
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.black_09.withValues(alpha: .08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '\$ ',
                                    style: TextStyle(
                                      fontSize: 22.w,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.baseline,
                                    baseline: TextBaseline.alphabetic,
                                    child: Obx(() {
                                      final parcentageAmount = controller.parcentage.value * paymentAmount / 100;
                                      final payableAmount = paymentAmount + parcentageAmount;
                                      return Text(
                                        '${payableAmount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 36.w,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black_09,
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20, top: 8),
        child: SafeArea(
          child: GetBuilder<ContractorBookingController>(
            builder: (_) {
              // If already paid, skip payment and place booking directly
              if (paymentAmount <= 0) {
                return CustomButton(
                  onTap: () async {
                    controller.collectAllAnswers();
                    final bookingSuccess =
                        isUpdateMode
                            ? await controller.updateBooking(
                              id: updateBookingId,
                              booking_update: true,
                              bookingId: bookingId,
                              contractorId: contractorId,
                              subcategoryId: subcategoryId,
                            )
                            : await controller.createBooking(
                              paymentedBookingId: '',
                              contractorId: contractorId,
                              subcategoryId: subcategoryId,
                            );
                    if (bookingSuccess) {
                      Get.toNamed(AppRoutes.customerRequestHistoryScreen);
                    } else {
                      debugPrint('Booking creation failed');
                    }
                  },
                  title: isUpdateMode ? "Confirm Booking".tr : "Book Now".tr,
                );
              }
              // Otherwise, show payment button and process payment for remaining amount
              return CustomButton(
                onTap: () async {
                  controller.collectAllAnswers();
                  // Step 1: Call payment API to get payment URL for remaining amount
                  final int finalPaymentAmount =
                      paymentAmount + (controller.parcentage.value * paymentAmount / 100).toInt();
                  EasyLoading.show(status: 'Processing payment...');
                  final Map<String, dynamic> requestBody = {
                    "contractorId": contractorId,
                    "amount": finalPaymentAmount,
                  };
                  final response = await ApiClient.postData(
                    ApiUrl.createCheckoutSession,
                    jsonEncode(requestBody),
                  );
                  EasyLoading.dismiss();
                  if (response.statusCode == 200 &&
                      response.body != null &&
                      response.body['success'] == true) {
                    final String checkoutUrl = response.body['data'];
                    // Step 2: Navigate to payment webview with URL
                    final paymentResult = await Get.to(
                      () => const PaymentWebViewScreen(),
                      arguments: checkoutUrl,
                    );
                    if (paymentResult is Map &&
                        paymentResult['status'] == 'success') {
                      // Step 3: Place booking
                      final bookingIdResult = paymentResult['bookingId'] ?? '';
                      final bookingSuccess =
                          isUpdateMode
                              ? await controller.updateBooking(
                                id: updateBookingId,
                                booking_update: true,
                                bookingId: bookingId,
                                contractorId: contractorId,
                                subcategoryId: subcategoryId,
                              )
                              : await controller.createBooking(
                                paymentedBookingId: bookingIdResult,
                                contractorId: contractorId,
                                subcategoryId: subcategoryId,
                              );
                      if (bookingSuccess) {
                        Get.toNamed(AppRoutes.customerRequestHistoryScreen);
                      } else {
                        debugPrint('Booking creation failed');
                      }
                    } else {
                      EasyLoading.showInfo(
                        'Payment was not completed or was cancelled.',
                      );
                    }
                  } else {
                    EasyLoading.showError(
                      response.body?['message'] ??
                          'Failed to create payment checkout',
                      duration: const Duration(seconds: 2),
                    );
                  }
                },
                title:
                    isUpdateMode
                        ?  "Pay & Update Booking".tr
                        : "Pay & Book Now".tr,
              );
            },
          ),
        ),
      ),
    );
  }
}
