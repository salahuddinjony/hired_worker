import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import 'package:servana/view/components/extension/extension.dart';

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

    // Extract booking schedule data for updates
    final String bookingType = args['bookingType']?.toString() ?? 'oneTime';
    final String duration = args['duration']?.toString() ?? '1';
    final String startTime = args['startTime']?.toString() ?? '';
    final String endTime = args['endTime']?.toString() ?? '';
    final List<String> selectedDates =
        (args['selectedDates'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];
    final int hourlyRate =
        (args['hourlyRate'] is int)
            ? args['hourlyRate']
            : int.tryParse(args['hourlyRate']?.toString() ?? '0') ?? 0;
    final bool isUpdate = args['isUpdate'] ?? false;
    final int totalAmount =
        args['totalAmount'] is int
            ? args['totalAmount']
            : int.tryParse(args['totalAmount']?.toString() ?? '0') ?? 0;
    final int paymentedTotalAmount =
        args['PaymentedTotalAmount'] is int
            ? args['PaymentedTotalAmount']
            : int.tryParse(args['PaymentedTotalAmount']?.toString() ?? '0') ??
                0;
    final String bookingId =
        args['bookingId']?.toString() ??
        ''; // Extract booking ID with proper conversion
    final String updateBookingId = args['updateBookingId']?.toString() ?? '';
    final String contractorIdForTimeSlot =
        args['contractorIdForTimeSlot']?.toString() ?? '';
    final String subCategoryImage = args['subCategoryImage']?.toString() ?? '';

    // Initialize controller with existing booking data if this is an update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isUpdate) {
        // Set booking type
        controller.bookingType.value = bookingType;

        // Set duration
        controller.durations.value = duration;

        // Set hourly rate
        controller.hourlyRate = hourlyRate;

        // Set start and end times
        controller.startTimeController.value.text = startTime;
        controller.endTimeController.value.text = endTime;

        // Set selected dates
        controller.selectedDates.clear();
        controller.selectedDates.addAll(selectedDates);

        // Set day controller text based on booking type
        if (bookingType == 'oneTime' && selectedDates.isNotEmpty) {
          controller.dayController.value.text = selectedDates.first;
        } else if (bookingType == 'weekly' && selectedDates.isNotEmpty) {
          controller.dayController.value.text =
              '${selectedDates.length} dates selected';
        }

        debugPrint('Initialized controller with existing booking data:');
        debugPrint('BookingType: $bookingType');
        debugPrint('Duration: $duration');
        debugPrint('StartTime: $startTime');
        debugPrint('EndTime: $endTime');
        debugPrint('SelectedDates: $selectedDates');
        debugPrint('HourlyRate: $hourlyRate');
      }
    });

    return Scaffold(
      appBar: const CustomRoyelAppbar(
        leftIcon: true,
        // titleName: isUpdate
        //     ? "Update Booking - $contractorName".tr
        //     : "Book Service - $contractorName".tr,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          
          child: Column(
            children: [
              // Stack(
              //   clipBehavior: Clip.none,
              //   children: [
              //     CustomNetworkImage(
              //       imageUrl: subCategoryImage,
              //       height: MediaQuery.sizeOf(context).height / 3.5,
              //       width: MediaQuery.sizeOf(context).width,
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(20.r),
              //         bottomRight: Radius.circular(20.r),
              //       ),
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           const CustomRoyelAppbar(leftIcon: true),
              //           Container(
              //             margin: EdgeInsets.only(left: 20.w, top: 8.h),
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 12.w,
              //               vertical: 6.h,
              //             ),
              //             decoration: BoxDecoration(
              //               color: AppColors.blue.withValues(alpha: .2),
              //               borderRadius: BorderRadius.circular(8.r),
              //             ),
              //             child: CustomText(
              //               text: subCategoryName,
              //               fontSize: 20.w,
              //               fontWeight: FontWeight.w700,
              //               color: AppColors.primary,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     Positioned(
              //       bottom: -35.h,
              //       left: 20,
              //       right: 20,
              //       child:
              //     ),
              //   ],
              // ),
               Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Obx(() {
                            final isOneTime =
                                controller.bookingType.value == 'oneTime';
                            return Opacity(
                              opacity: isUpdate ? 0.6 : 1.0,
                              child: MouseRegion(
                                cursor:
                                    isUpdate
                                        ? SystemMouseCursors.forbidden
                                        : SystemMouseCursors.click,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AbsorbPointer(
                                      absorbing: isUpdate,
                                      child: GestureDetector(
                                        onTap: () {
                                          debugPrint(
                                            'CustomarServiceDetailsScreen: One Time selected',
                                          );
                                          controller.selectedDates.length > 1
                                              ? controller.dayController.value
                                                  .clear()
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
                                    ),
                                    AbsorbPointer(
                                      absorbing: isUpdate,
                                      child: GestureDetector(
                                        onTap:
                                            () =>
                                                controller.bookingType.value =
                                                    'weekly',
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
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
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
                          int minDuration = 1;
                          // If update mode, set minDuration to original value
                          if (isUpdate) {
                            // Try to get original duration from arguments
                            minDuration = int.tryParse(duration) ?? 1;
                          }
                          return Row(
                            children: List.generate(5, (index) {
                              final hourValue = index + 1;
                              final isSelected = selected == hourValue;
                              final canSelect =
                                  !isUpdate || hourValue >= minDuration;
                              final disabledBg = Colors.grey.shade300;
                              final disabledText = Colors.grey.shade600;
                              return GestureDetector(
                                onTap:
                                    canSelect
                                        ? () {
                                          controller.durations.value =
                                              '$hourValue';
                                        }
                                        : null,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                  ),
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:
                                        canSelect
                                            ? (isSelected
                                                ? AppColors.primary
                                                : AppColors.white)
                                            : disabledBg,
                                    child: CustomText(
                                      text: "$hourValue",
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          canSelect
                                              ? (isSelected
                                                  ? AppColors.white
                                                  : AppColors.black)
                                              : disabledText,
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
                      () => AbsorbPointer(
                        absorbing: isUpdate,
                        child: Opacity(
                          opacity: isUpdate ? 0.6 : 1.0,
                          child: CustomFormCard(
                            readOnly: true,
                            onTap: () async {
                              if (!isUpdate) {
                                await controller.selectDate(
                                  context,
                                  controller.bookingType.value == 'oneTime',
                                );
                                // Call API after selecting date(s)
                                if (controller.selectedDates.isNotEmpty) {
                                  await controller.lookupAvailableSlots(
                                    contractorIdForTimeSlot:
                                        contractorIdForTimeSlot,
                                  );
                                }
                              }
                            },
                            title:
                                controller.bookingType.value == 'oneTime'
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
                      ),
                    ),
                    // Show available slots/message above start/end time fields
                    Obx(() {
                      if (controller.availableSlots.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Available Slots:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.w,
                                  color: AppColors.primary,
                                ),
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children:
                                    controller.availableSlots
                                        .map<Widget>(
                                          (slot) => Chip(
                                            label: Text(slot),
                                            backgroundColor: Colors.green.shade50,
                                            labelStyle: const TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => CustomFormCard(
                              readOnly: false,
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
                              readOnly: false,
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
                      text: 'Charge /Hour AUD ${controller.hourlyRate}',
                      fontSize: 18.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                      bottom: 8,
                    ),
                    Obx(() {
                      final total = controller.calculateTotalPayableAmount();
                      final hours = controller.durations.value;
                      return CustomText(
                        text: "Total: AUD $total ($hours Hours)",
                        fontSize: 18.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                        bottom: 50,
                      );
                    }),
                    CustomButton(
                      onTap: () async {
                        if (!controller.isNotEmptyField()) {
                          return;
                        }
                        bool shouldCheckSlots = false;
                        if (isUpdate) {
                          // Compare original and current values
                          final originalDay =
                              (selectedDates.isNotEmpty)
                                  ? selectedDates.join(',')
                                  : '';
                          final currentDay =
                              (controller.selectedDates.isNotEmpty)
                                  ? controller.selectedDates.join(',')
                                  : '';
                          final originalStart = startTime;
                          final currentStart =
                              controller.startTimeController.value.text;
                          final originalEnd = endTime;
                          final currentEnd =
                              controller.endTimeController.value.text;
                          if (originalDay != currentDay ||
                              originalStart != currentStart ||
                              originalEnd != currentEnd) {
                            shouldCheckSlots = true;
                          }
                        }
                        if (isUpdate && shouldCheckSlots) {
                          await controller.lookupAvailableSlots(
                            contractorIdForTimeSlot: contractorIdForTimeSlot,
                          );
                        }
          
                        if ((!isUpdate && !controller.isSlotAvailable()) ||
                            (isUpdate &&
                                shouldCheckSlots &&
                                !controller.isSlotAvailable())) {
                          final unavailableDays =
                              controller.apiResponse['unavailableDays'] ?? [];
          
                          final message =
                              controller.apiResponse['message'] ??
                              'Some requested slots are unavailable.';
          
                          return showDialog(
                            context: context,
                            builder:
                                (ctx) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  title: const Row(
                                    children: [
                                      Icon(
                                        Icons.warning_amber_rounded,
                                        color: Colors.redAccent,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Unavailable Slots',
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Text(
                                          message,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      if (unavailableDays is List &&
                                          unavailableDays.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child: Column(
                                            children: [
                                              const Text(
                                                'Unavailable Dates:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Wrap(
                                                spacing: 6,
                                                children:
                                                    unavailableDays
                                                        .map<Widget>(
                                                          (d) => Chip(
                                                            label: Text(
                                                              d,
                                                              style:
                                                                  const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                            backgroundColor:
                                                                Colors
                                                                    .red
                                                                    .shade50,
                                                            labelStyle:
                                                                const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .redAccent,
                                                                ),
                                                          ),
                                                        )
                                                        .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Chip(
                                              label: Text(
                                                controller
                                                    .startTimeController
                                                    .value
                                                    .text,
                                              ),
                                              backgroundColor:
                                                  Colors.blue.shade50,
                                              labelStyle: const TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              'to'.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Chip(
                                              label: Text(
                                                controller
                                                    .endTimeController
                                                    .value
                                                    .text,
                                              ),
                                              backgroundColor:
                                                  Colors.blue.shade50,
                                              labelStyle: const TextStyle(
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "At " +
                                            controller.selectedDates
                                                .map((d) {
                                                  final dt = DateTime.tryParse(d);
                                                  return dt != null
                                                      ? dt.formatDate()
                                                      : d;
                                                })
                                                .join(', '),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Please choose different times or dates.',
                                        style: TextStyle(color: Colors.black54),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () => Navigator.of(ctx).pop(),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                          );
                        }
          
                        // If available, proceed
                        Get.toNamed(
                          AppRoutes.customarServiceContractorDetailsScreen,
                          arguments: {
                            'isUpdate': isUpdate,
                            'bookingId': bookingId,
                            'contractorId': contractorId,
                            'contractorIdForTimeSlot': contractorIdForTimeSlot,
                            'subcategoryId': subcategoryId,
                            'controller': controller,
                            'contractorName': contractorName,
                            'categoryName': categoryName,
                            'subCategoryName': subCategoryName,
                            'PaymentedTotalAmount': paymentedTotalAmount,
                            'updateBookingId': updateBookingId,
                          },
                        );
                      },
                      title: isUpdate ? "Update Booking".tr : "Continue".tr,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:servana/core/app_routes/app_routes.dart';
// import 'package:servana/utils/app_colors/app_colors.dart';
// import 'package:servana/utils/app_const/app_const.dart';
// import 'package:servana/view/components/custom_button/custom_button.dart';
// import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
// import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
// import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
// import 'package:servana/view/components/custom_text/custom_text.dart';
// import '../customar_qa_screen/booking_controller/contractor_booking_controller.dart';
// import 'package:servana/view/components/extension/extension.dart';

// class CustomarServiceDetailsScreen extends StatelessWidget {
//   const CustomarServiceDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Map<String, dynamic> args = Get.arguments ?? {};
//     final ContractorBookingController controller = args['controller'];
//     final String contractorId = args['contractorId']?.toString() ?? '';
//     final String subcategoryId = args['subcategoryId']?.toString() ?? '';
//     final String contractorName = args['contractorName'] ?? '';
//     final String categoryName = args['categoryName'] ?? '';
//     final String subCategoryName = args['subCategoryName'] ?? '';

//     // Extract booking schedule data for updates
//     final String bookingType = args['bookingType']?.toString() ?? 'oneTime';
//     final String duration = args['duration']?.toString() ?? '1';
//     final String startTime = args['startTime']?.toString() ?? '';
//     final String endTime = args['endTime']?.toString() ?? '';
//     final List<String> selectedDates =
//         (args['selectedDates'] as List<dynamic>?)
//             ?.map((e) => e.toString())
//             .toList() ??
//         [];
//     final int hourlyRate =
//         (args['hourlyRate'] is int)
//             ? args['hourlyRate']
//             : int.tryParse(args['hourlyRate']?.toString() ?? '0') ?? 0;
//     final bool isUpdate = args['isUpdate'] ?? false;
//     final int totalAmount =
//         args['totalAmount'] is int
//             ? args['totalAmount']
//             : int.tryParse(args['totalAmount']?.toString() ?? '0') ?? 0;
//     final int paymentedTotalAmount =
//         args['PaymentedTotalAmount'] is int
//             ? args['PaymentedTotalAmount']
//             : int.tryParse(args['PaymentedTotalAmount']?.toString() ?? '0') ??
//                 0;
//     final String bookingId =
//         args['bookingId']?.toString() ??
//         ''; // Extract booking ID with proper conversion
//     final String updateBookingId = args['updateBookingId']?.toString() ?? '';
//     final String contractorIdForTimeSlot =
//         args['contractorIdForTimeSlot']?.toString() ?? '';
//     final String subCategoryImage = args['subCategoryImage']?.toString() ?? '';

//     // Initialize controller with existing booking data if this is an update
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (isUpdate) {
//         // Set booking type
//         controller.bookingType.value = bookingType;

//         // Set duration
//         controller.durations.value = duration;

//         // Set hourly rate
//         controller.hourlyRate = hourlyRate;

//         // Set start and end times
//         controller.startTimeController.value.text = startTime;
//         controller.endTimeController.value.text = endTime;

//         // Set selected dates
//         controller.selectedDates.clear();
//         controller.selectedDates.addAll(selectedDates);

//         // Set day controller text based on booking type
//         if (bookingType == 'oneTime' && selectedDates.isNotEmpty) {
//           controller.dayController.value.text = selectedDates.first;
//         } else if (bookingType == 'weekly' && selectedDates.isNotEmpty) {
//           controller.dayController.value.text =
//               '${selectedDates.length} dates selected';
//         }

//         debugPrint('Initialized controller with existing booking data:');
//         debugPrint('BookingType: $bookingType');
//         debugPrint('Duration: $duration');
//         debugPrint('StartTime: $startTime');
//         debugPrint('EndTime: $endTime');
//         debugPrint('SelectedDates: $selectedDates');
//         debugPrint('HourlyRate: $hourlyRate');
//       }
//     });

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 CustomNetworkImage(
//                   imageUrl: subCategoryImage,
//                   height: MediaQuery.sizeOf(context).height / 3.5,
//                   width: MediaQuery.sizeOf(context).width,
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(20.r),
//                     bottomRight: Radius.circular(20.r),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const CustomRoyelAppbar(leftIcon: true),
//                       Container(
//                         margin: EdgeInsets.only(left: 20.w, top: 8.h),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 12.w,
//                           vertical: 6.h,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.blue.withValues(alpha: .2),
//                           borderRadius: BorderRadius.circular(8.r),
//                         ),
//                         child: CustomText(
//                           text: subCategoryName,
//                           fontSize: 20.w,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: -35.h,
//                   left: 20,
//                   right: 20,
//                   child: Card(
//                     elevation: 4,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Obx(() {
//                         final isOneTime =
//                             controller.bookingType.value == 'oneTime';
//                         return Opacity(
//                           opacity: isUpdate ? 0.6 : 1.0,
//                           child: MouseRegion(
//                             cursor:
//                                 isUpdate
//                                     ? SystemMouseCursors.forbidden
//                                     : SystemMouseCursors.click,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 AbsorbPointer(
//                                   absorbing: isUpdate,
//                                   child: GestureDetector(
//                                     onTap: () {
//                                       debugPrint(
//                                         'CustomarServiceDetailsScreen: One Time selected',
//                                       );
//                                       controller.selectedDates.length > 1
//                                           ? controller.dayController.value
//                                               .clear()
//                                           : null;
//                                       controller.bookingType.value = 'oneTime';
//                                     },
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 20,
//                                         vertical: 10,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             isOneTime
//                                                 ? AppColors.primary
//                                                 : AppColors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.timer,
//                                             color:
//                                                 isOneTime
//                                                     ? AppColors.white
//                                                     : AppColors.black,
//                                           ),
//                                           CustomText(
//                                             left: 8.w,
//                                             text: "One Time".tr,
//                                             fontSize: 16.w,
//                                             fontWeight: FontWeight.w500,
//                                             color:
//                                                 isOneTime
//                                                     ? AppColors.white
//                                                     : AppColors.black,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 AbsorbPointer(
//                                   absorbing: isUpdate,
//                                   child: GestureDetector(
//                                     onTap:
//                                         () =>
//                                             controller.bookingType.value =
//                                                 'weekly',
//                                     child: Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 20,
//                                         vertical: 10,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color:
//                                             !isOneTime
//                                                 ? AppColors.primary
//                                                 : AppColors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                       ),
//                                       child: Row(
//                                         children: [
//                                           Icon(
//                                             Icons.calendar_month,
//                                             color:
//                                                 !isOneTime
//                                                     ? AppColors.white
//                                                     : AppColors.black,
//                                           ),
//                                           CustomText(
//                                             left: 8.w,
//                                             text: "Weekly".tr,
//                                             fontSize: 16.w,
//                                             fontWeight: FontWeight.w500,
//                                             color:
//                                                 !isOneTime
//                                                     ? AppColors.white
//                                                     : AppColors.black,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 50.h),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomText(
//                         text: "Hours -".tr,
//                         fontSize: 16.w,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.black,
//                       ),
//                       SizedBox(width: 8.w),
//                       Obx(() {
//                         final selected =
//                             int.tryParse(controller.durations.value) ?? 1;
//                         int minDuration = 1;
//                         // If update mode, set minDuration to original value
//                         if (isUpdate) {
//                           // Try to get original duration from arguments
//                           minDuration = int.tryParse(duration) ?? 1;
//                         }
//                         return Row(
//                           children: List.generate(5, (index) {
//                             final hourValue = index + 1;
//                             final isSelected = selected == hourValue;
//                             final canSelect =
//                                 !isUpdate || hourValue >= minDuration;
//                             final disabledBg = Colors.grey.shade300;
//                             final disabledText = Colors.grey.shade600;
//                             return GestureDetector(
//                               onTap:
//                                   canSelect
//                                       ? () {
//                                         controller.durations.value =
//                                             '$hourValue';
//                                       }
//                                       : null,
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 6,
//                                 ),
//                                 child: CircleAvatar(
//                                   radius: 15,
//                                   backgroundColor:
//                                       canSelect
//                                           ? (isSelected
//                                               ? AppColors.primary
//                                               : AppColors.white)
//                                           : disabledBg,
//                                   child: CustomText(
//                                     text: "$hourValue",
//                                     fontSize: 16.w,
//                                     fontWeight: FontWeight.w500,
//                                     color:
//                                         canSelect
//                                             ? (isSelected
//                                                 ? AppColors.white
//                                                 : AppColors.black)
//                                             : disabledText,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         );
//                       }),
//                     ],
//                   ),
//                   SizedBox(height: 30.h),
//                   Obx(
//                     () => AbsorbPointer(
//                       absorbing: isUpdate,
//                       child: Opacity(
//                         opacity: isUpdate ? 0.6 : 1.0,
//                         child: CustomFormCard(
//                           readOnly: true,
//                           onTap: () async {
//                             if (!isUpdate) {
//                               await controller.selectDate(
//                                 context,
//                                 controller.bookingType.value == 'oneTime',
//                               );
//                               // Call API after selecting date(s)
//                               if (controller.selectedDates.isNotEmpty) {
//                                 await controller.lookupAvailableSlots(
//                                   contractorIdForTimeSlot:
//                                       contractorIdForTimeSlot,
//                                 );
//                               }
//                             }
//                           },
//                           title:
//                               controller.bookingType.value == 'oneTime'
//                                   ? "Select Date".tr
//                                   : "Select Multiple Dates ".tr,
//                           hintText:
//                               controller.dayController.value.text.isEmpty
//                                   ? "mm/dd/yyyy"
//                                   : controller.dayController.value.text,
//                           prefixIcon: const Icon(
//                             Icons.calendar_month,
//                             color: AppColors.black_08,
//                           ),
//                           suffixIcon: const Icon(
//                             Icons.keyboard_arrow_down,
//                             color: AppColors.black_08,
//                           ),
//                           controller: controller.dayController.value,
//                         ),
//                       ),
//                     ),
//                   ),
//                   // Show available slots/message above start/end time fields
//                   Obx(() {
//                     if (controller.availableSlots.isNotEmpty) {
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 12.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Available Slots:',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16.w,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                             Wrap(
//                               spacing: 8,
//                               runSpacing: 8,
//                               children:
//                                   controller.availableSlots
//                                       .map<Widget>(
//                                         (slot) => Chip(
//                                           label: Text(slot),
//                                           backgroundColor: Colors.green.shade50,
//                                           labelStyle: const TextStyle(
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       )
//                                       .toList(),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   }),
//                   SizedBox(height: 12.h),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Obx(
//                           () => CustomFormCard(
//                             readOnly: false,
//                             title: "Start time".tr,
//                             onTap: () {
//                               debugPrint(
//                                 'CustomarServiceDetailsScreen: From field tapped',
//                               );
//                               controller.selectTime(
//                                 context,
//                                 controller.startTimeController.value,
//                               );
//                             },
//                             hintText:
//                                 controller
//                                         .startTimeController
//                                         .value
//                                         .text
//                                         .isEmpty
//                                     ? "hh:mm"
//                                     : controller.startTimeController.value.text,
//                             prefixIcon: const Icon(
//                               Icons.access_time,
//                               color: AppColors.black_08,
//                             ),
//                             controller: controller.startTimeController.value,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10.w),
//                       Expanded(
//                         child: Obx(
//                           () => CustomFormCard(
//                             readOnly: false,
//                             title: "End time".tr,
//                             onTap: () {
//                               debugPrint(
//                                 'CustomarServiceDetailsScreen: From field tapped',
//                               );
//                               controller.selectTime(
//                                 context,
//                                 controller.endTimeController.value,
//                               );
//                             },
//                             hintText:
//                                 controller.endTimeController.value.text.isEmpty
//                                     ? "hh:mm"
//                                     : controller.endTimeController.value.text,
//                             prefixIcon: const Icon(
//                               Icons.access_time,
//                               color: AppColors.black_08,
//                             ),
//                             controller: controller.endTimeController.value,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 20.h),
//                   CustomText(
//                     text: 'Charge /Hour AUD ${controller.hourlyRate}',
//                     fontSize: 18.w,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.black,
//                     bottom: 8,
//                   ),
//                   Obx(() {
//                     final total = controller.calculateTotalPayableAmount();
//                     final hours = controller.durations.value;
//                     return CustomText(
//                       text: "Total: AUD $total ($hours Hours)",
//                       fontSize: 18.w,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.black,
//                       bottom: 50,
//                     );
//                   }),
//                   CustomButton(
//                     onTap: () async {
//                       if (!controller.isNotEmptyField()) {
//                         return;
//                       }
//                       bool shouldCheckSlots = false;
//                       if (isUpdate) {
//                         // Compare original and current values
//                         final originalDay =
//                             (selectedDates.isNotEmpty)
//                                 ? selectedDates.join(',')
//                                 : '';
//                         final currentDay =
//                             (controller.selectedDates.isNotEmpty)
//                                 ? controller.selectedDates.join(',')
//                                 : '';
//                         final originalStart = startTime;
//                         final currentStart =
//                             controller.startTimeController.value.text;
//                         final originalEnd = endTime;
//                         final currentEnd =
//                             controller.endTimeController.value.text;
//                         if (originalDay != currentDay ||
//                             originalStart != currentStart ||
//                             originalEnd != currentEnd) {
//                           shouldCheckSlots = true;
//                         }
//                       }
//                       if (isUpdate && shouldCheckSlots) {
//                         await controller.lookupAvailableSlots(
//                           contractorIdForTimeSlot: contractorIdForTimeSlot,
//                         );
//                       }

//                       if ((!isUpdate && !controller.isSlotAvailable()) ||
//                           (isUpdate &&
//                               shouldCheckSlots &&
//                               !controller.isSlotAvailable())) {
//                         final unavailableDays =
//                             controller.apiResponse['unavailableDays'] ?? [];

//                         final message =
//                             controller.apiResponse['message'] ??
//                             'Some requested slots are unavailable.';

//                         return showDialog(
//                           context: context,
//                           builder:
//                               (ctx) => AlertDialog(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(16),
//                                 ),
//                                 title: const Row(
//                                   children: [
//                                     Icon(
//                                       Icons.warning_amber_rounded,
//                                       color: Colors.redAccent,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Unavailable Slots',
//                                       style: TextStyle(
//                                         color: Colors.redAccent,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 8.0,
//                                       ),
//                                       child: Text(
//                                         message,
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           color: Colors.black87,
//                                         ),
//                                         textAlign: TextAlign.center,
//                                       ),
//                                     ),
//                                     if (unavailableDays is List &&
//                                         unavailableDays.isNotEmpty)
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                           vertical: 8.0,
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             const Text(
//                                               'Unavailable Dates:',
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 color: Colors.black54,
//                                               ),
//                                             ),
//                                             Wrap(
//                                               spacing: 6,
//                                               children:
//                                                   unavailableDays
//                                                       .map<Widget>(
//                                                         (d) => Chip(
//                                                           label: Text(
//                                                             d,
//                                                             style:
//                                                                 const TextStyle(
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w500,
//                                                                 ),
//                                                           ),
//                                                           backgroundColor:
//                                                               Colors
//                                                                   .red
//                                                                   .shade50,
//                                                           labelStyle:
//                                                               const TextStyle(
//                                                                 color:
//                                                                     Colors
//                                                                         .redAccent,
//                                                               ),
//                                                         ),
//                                                       )
//                                                       .toList(),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                         vertical: 8.0,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Chip(
//                                             label: Text(
//                                               controller
//                                                   .startTimeController
//                                                   .value
//                                                   .text,
//                                             ),
//                                             backgroundColor:
//                                                 Colors.blue.shade50,
//                                             labelStyle: const TextStyle(
//                                               color: Colors.blue,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             'to'.tr,
//                                             style: const TextStyle(
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Chip(
//                                             label: Text(
//                                               controller
//                                                   .endTimeController
//                                                   .value
//                                                   .text,
//                                             ),
//                                             backgroundColor:
//                                                 Colors.blue.shade50,
//                                             labelStyle: const TextStyle(
//                                               color: Colors.blue,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Text(
//                                       "At " +
//                                           controller.selectedDates
//                                               .map((d) {
//                                                 final dt = DateTime.tryParse(d);
//                                                 return dt != null
//                                                     ? dt.formatDate()
//                                                     : d;
//                                               })
//                                               .join(', '),
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 8),
//                                     const Text(
//                                       'Please choose different times or dates.',
//                                       style: TextStyle(color: Colors.black54),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ],
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     style: TextButton.styleFrom(
//                                       foregroundColor: Colors.white,
//                                       backgroundColor: AppColors.primary,
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     onPressed: () => Navigator.of(ctx).pop(),
//                                     child: const Text('OK'),
//                                   ),
//                                 ],
//                               ),
//                         );
//                       }

//                       // If available, proceed
//                       Get.toNamed(
//                         AppRoutes.customarServiceContractorDetailsScreen,
//                         arguments: {
//                           'isUpdate': isUpdate,
//                           'bookingId': bookingId,
//                           'contractorId': contractorId,
//                           'contractorIdForTimeSlot': contractorIdForTimeSlot,
//                           'subcategoryId': subcategoryId,
//                           'controller': controller,
//                           'contractorName': contractorName,
//                           'categoryName': categoryName,
//                           'subCategoryName': subCategoryName,
//                           'PaymentedTotalAmount': paymentedTotalAmount,
//                           'updateBookingId': updateBookingId,
//                         },
//                       );
//                     },
//                     title: isUpdate ? "Update Booking".tr : "Continue".tr,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
