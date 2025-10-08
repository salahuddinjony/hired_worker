import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import '../../../../components/custom_button/custom_button.dart';

class CustomarServiceContractorDetailsScreen extends StatelessWidget {
  CustomarServiceContractorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = Get.arguments ?? {};
    final ContractorBookingController controller = args['controller'];
    final String contractorId = args['contractorId']?.toString() ?? '';
    final String subcategoryId = args['subcategoryId']?.toString() ?? '';
    final String contractorName = args['contractorName'] ?? '';
    final String categoryName = args['categoryName'] ?? '';
    final String subCategoryName = args['subCategoryName'] ?? '';

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
              Divider(thickness: .4, color: AppColors.black_02),

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
                        text: "${controller.hourlyRate}\$/h",
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
                text: "Requirement Question".tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              Divider(thickness: .4, color: AppColors.black_02),

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
                          SizedBox(height: 4),
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
                      Divider(thickness: .4, color: AppColors.black_02),

                      // Materials list (read-only)
                      Column(
                        children: List.generate(
                          controller.materialsAndQuantity.length,
                          (index) {
                            final mat = controller.materialsAndQuantity[index];
                            final countRaw = mat['count'] ?? '0';
                            final count =
                                int.tryParse(countRaw.toString()) ?? 0;
                            if (count <= 0) return SizedBox.shrink();
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
                                        SizedBox(width: 8),
                                        CustomText(
                                          text:
                                              '- $count x \$${priceDouble.toStringAsFixed(2)}',
                                          fontSize: 14.w,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  CustomText(
                                    text: '\$${totalPrice.toStringAsFixed(2)}',
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
                      Divider(
                        thickness: .4,
                        color: const Color.fromARGB(255, 146, 126, 126),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Materials Total: ",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          Expanded(child: SizedBox()),
                          CustomText(
                            text:
                                "\$${controller.materialsTotalAmount.toStringAsFixed(2)}",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ],
                  )
                  : SizedBox.shrink(),

              CustomText(
                top: 20,
                text: "Booking Type".tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              Divider(thickness: .5, color: AppColors.black_02),
              // Read-only booking type
              Row(
                children: [
                  Icon(Icons.book_online, size: 16, color: AppColors.black_08),
                  SizedBox(width: 8),
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
              SizedBox(height: 20),
              if (controller.bookingType.value == 'weekly') ...[
                // show selected days for weekly booking
                Row(
                  children: [
                    CustomText(
                      text:
                          "Selected Days: ${controller.selectedDates.length} days -  \$${controller.selectedDates.length} x ${controller.totalDurationAmount}",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    Expanded(child: SizedBox()),
                    CustomText(
                      text: controller.weeklyTotalAmount.toString() + "\$",
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
              Divider(thickness: .4, color: AppColors.black_02),

              SizedBox(height: 8),
              // durations display (read-only)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text:
                        "Duration : ( ${controller.durations.value} x ${controller.hourlyRate}\$ ) ",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    text: "\$${controller.totalDurationAmount.toString()}",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),

              SizedBox(height: 40),

              // Duration/time display (read-only)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, size: 16, color: AppColors.black_08),
                  SizedBox(width: 4),
                  CustomText(
                    text:
                        'Start Time'.tr +
                        ": ${controller.startTimeController.value.text}",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.access_time_filled,
                    size: 16,
                    color: AppColors.black_08,
                  ),
                  SizedBox(width: 4),
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

              SizedBox(height: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(thickness: .4, color: AppColors.black_02),
                  SizedBox(height: 16),
                  CustomText(
                    text: 'Total Amount',
                    fontSize: 16.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\$',
                          style: TextStyle(
                            fontSize: 20.w,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        TextSpan(
                          text: controller.totalAmount.toString(),
                          style: TextStyle(
                            fontSize: 33.w,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
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
              return Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () async {
                        // collect answers and open checkout
                        controller.collectAllAnswers();
                        final bookingSuccess = await controller.createBooking(
                          contractorId: contractorId,
                          subcategoryId: subcategoryId,
                        );
                        if (bookingSuccess) {
                          Get.toNamed(AppRoutes.customerRequestHistoryScreen);
                        } else {
                          debugPrint('Booking creation failed');
                        }
                        debugPrint(
                          'All questions Q and A : ${controller.questionsAndAnswers}',
                        );
                      },
                      title: "Book Now".tr,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
