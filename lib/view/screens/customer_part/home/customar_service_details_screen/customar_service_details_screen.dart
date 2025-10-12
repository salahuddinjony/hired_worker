import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../customar_qa_screen/booking_controller/contractor_booking_controller.dart';

class CustomarServiceDetailsScreen extends StatelessWidget {
  const CustomarServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final ContractorBookingController controller = args['controller'];
    final String contractorId = args['contractorId']?.toString() ?? '';
    final String subcategoryId = args['subcategoryId']?.toString() ?? '';
    final String contractorName = args['contractorName'] ?? '';
    final String categoryName = args['categoryName'] ?? '';
    final String subCategoryName = args['subCategoryName'] ?? '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                CustomNetworkImage(
                  imageUrl: AppConstants.electrician,
                  height: MediaQuery.sizeOf(context).height / 3.5,
                  width: MediaQuery.sizeOf(context).width,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomRoyelAppbar(leftIcon: true),
                      CustomText(
                        left: 20.w,
                        text: "AC Regular\nService",
                        fontSize: 28.w,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -35.h,
                  left: 20,
                  right: 20,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Obx(() {
                        final isOneTime =
                            controller.bookingType.value == 'oneTime';
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap:
                                  (){
                                    debugPrint('CustomarServiceDetailsScreen: One Time selected');
                                    controller.selectedDates.length > 1
                                        ? controller.dayController.value.clear()
                                        : null;
                                    controller.bookingType.value = 'oneTime';
                                  },
                                     
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isOneTime
                                          ? AppColors.primary
                                          : AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color:
                                          isOneTime
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                    CustomText(
                                      left: 8.w,
                                      text: "One Time".tr,
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          isOneTime
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap:
                                  () => controller.bookingType.value = 'weekly',
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      !isOneTime
                                          ? AppColors.primary
                                          : AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      color:
                                          !isOneTime
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                    CustomText(
                                      left: 8.w,
                                      text: "Weekly".tr,
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          !isOneTime
                                              ? AppColors.white
                                              : AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Hours -".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      SizedBox(width: 8.w),
                      Obx(() {
                        final selected =
                            int.tryParse(controller.durations.value) ?? 1;
                        return Row(
                          children: List.generate(5, (index) {
                            final isSelected = selected == (index + 1);
                            return GestureDetector(
                              onTap: () {
                                controller.durations.value = '${index + 1}';
                                // controller.durationController.text = controller.durations.value;
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                ),
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      isSelected
                                          ? AppColors.primary
                                          : AppColors.white,
                                  child: CustomText(
                                    text: "${index + 1}",
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        isSelected
                                            ? AppColors.white
                                            : AppColors.black,
                                  ),
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Obx(
                    () => CustomFormCard(
                      readOnly: true,
                      onTap: () {
                        debugPrint(
                          'CustomarServiceDetailsScreen: Date field tapped',
                        );
                      
                        controller.selectDate(context,controller.bookingType.value == 'oneTime' );
                      },
                      title: controller.bookingType.value == 'oneTime'
                          ? "Select Date".tr
                          : "Select Multiple Dates ".tr,
                      hintText:
                          controller.dayController.value.text.isEmpty
                              ? "mm/dd/yyyy"
                              : controller.dayController.value.text,
                      prefixIcon: const Icon(
                        Icons.calendar_month,
                        color: AppColors.black_08,
                      ),
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.black_08,
                      ),
                      controller: controller.dayController.value,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(
                          () => CustomFormCard(
                            readOnly: true,
                            title: "Start time".tr,

                            onTap: () {
                              debugPrint(
                                'CustomarServiceDetailsScreen: From field tapped',
                              );
                              controller.selectTime(
                                context,
                                controller.startTimeController.value,
                              );
                            },
                            hintText:
                                controller
                                        .startTimeController
                                        .value
                                        .text
                                        .isEmpty
                                    ? "hh:mm"
                                    : controller.startTimeController.value.text,
                            prefixIcon: const Icon(
                              Icons.access_time,
                              color: AppColors.black_08,
                            ),
                            controller: controller.startTimeController.value,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),

                      Expanded(
                        child: Obx(
                          () => CustomFormCard(
                            readOnly: true,
                            title: "End time".tr,

                            onTap: () {
                              debugPrint(
                                'CustomarServiceDetailsScreen: From field tapped',
                              );
                              controller.selectTime(
                                context,
                                controller.endTimeController.value,
                              );
                            },
                            hintText:
                                controller.endTimeController.value.text.isEmpty
                                    ? "hh:mm"
                                    : controller.endTimeController.value.text,
                            prefixIcon: const Icon(
                              Icons.access_time,
                              color: AppColors.black_08,
                            ),
                            controller: controller.endTimeController.value,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: 'Charge /Hour \$${controller.hourlyRate}',
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    bottom: 8,
                  ),
                  Obx(() {
                    final total = controller.calculateTotalPayableAmount();
                    final hours = controller.durations.value;
                    return CustomText(
                      text: "Total:  USD $total ($hours Hours)",
                      fontSize: 18.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      bottom: 50,
                    );
                  }),
                  CustomButton(
                    onTap: () {
                       if (!controller.isNotEmptyField()) {
            return;}
          // Navigate or perform booking creation
          Get.toNamed(
            AppRoutes.customarServiceContractorDetailsScreen,
            arguments: {
              'contractorId': contractorId,
                          'subcategoryId': subcategoryId,
                          'controller': controller,
                          'contractorName': contractorName,
                          'categoryName': categoryName,
                          'subCategoryName': subCategoryName,
                        },
                      );
                    },
                    title: "Continue".tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
