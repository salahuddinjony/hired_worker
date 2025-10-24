import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import 'widget/select_materials_row.dart';

class CustomarMaterialsScreen extends StatelessWidget {
  const CustomarMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final ContractorBookingController controller = args['controller'];
    final List<dynamic> materials = args['materials'] ?? [];
    final String contractorId = args['contractorId'] ?? '';
    final String subcategoryId = args['subcategoryId'] ?? '';
    final String contractorName = args['contractorName'] ?? '';
    final String categoryName = args['categoryName'] ?? '';
    final String subCategoryName = args['subCategoryName'] ?? '';

    // Extract booking schedule data
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
    final String bookingId = args['bookingId']?.toString() ?? '';
    final bool isUpdate = args['isUpdate'] ?? false;
    final PaymentedTotalAmount = args['PaymentedTotalAmount'] ?? 0;
    final String updateBookingId = args['updateBookingId']?.toString() ?? '';
    final String contractorIdForTimeSlot =
        args['contractorIdForTimeSlot']?.toString() ?? '';

    // Initialize materials in controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (materials.isNotEmpty) {
        controller.initializeMaterials(materials);
      } else {
        // Fallback: initialize with some default materials if none provided
        controller.initializeMaterials([
          {'name': 'Material A', 'unit': 'pcs', 'price': 10},
        ]);
      }
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Materials".tr),
      body: GetBuilder<ContractorBookingController>(
        builder: (controller) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 4),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Need Materials Select".tr,
                          fontSize: 18.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child:
                          controller.materialsAndQuantity.isEmpty
                              ? Center(
                                child: CustomText(
                                  text: "No materials available".tr,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_08,
                                ),
                              )
                              : ListView.builder(
                                itemCount:
                                    controller.materialsAndQuantity.length,
                                itemBuilder: (context, index) {
                                  final material =
                                      controller.materialsAndQuantity[index];
                                  int currentCount =
                                      int.tryParse(material['count'] ?? '0') ??
                                      0;
                                  int minCount = 0;
                                  if (isUpdate &&
                                      index <
                                          controller
                                              .originalMaterialCounts
                                              .length) {
                                    minCount =
                                        controller
                                            .originalMaterialCounts[index];
                                  }
                                  return SelectMaterialsRow(
                                    name: material['name'],
                                    unit: material['unit'] ?? 'pcs',
                                    price: material['price'] ?? '0',
                                    count: material['count'] ?? '0',
                                    isSelected: controller.isMaterialSelected(
                                      index,
                                    ),
                                    onIncrement:
                                        () =>
                                            controller.incrementMaterial(index),
                                    onDecrement:
                                        () =>
                                            controller.decrementMaterial(index),
                                    disableDecrement: currentCount <= minCount,
                                  );
                                },
                              ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 100, right: 20, left: 20),
        child: CustomButton(
          onTap: () {
            debugPrint(
              'Selected Materials: ${controller.materialsAndQuantity.where((m) => controller.isMaterialSelected(controller.materialsAndQuantity.indexOf(m))).toList()}',
            );
            Get.toNamed(
              AppRoutes.customarServiceDetailsScreen,
              arguments: {
                'controller': controller,
                'contractorId': contractorId,
                'contractorIdForTimeSlot': contractorIdForTimeSlot,
                'subcategoryId': subcategoryId,
                'contractorName': contractorName,
                'categoryName': categoryName,
                'subCategoryName': subCategoryName,
                'bookingType': bookingType,
                'duration': duration,
                'startTime': startTime,
                'endTime': endTime,
                'selectedDates': selectedDates,
                'hourlyRate': hourlyRate,
                'isUpdate': isUpdate,
                'updateBookingId': updateBookingId,
                'PaymentedTotalAmount': PaymentedTotalAmount,
                'bookingId': bookingId,
              },
            );
          },
          title: isUpdate ? "Update".tr : "Continue".tr,
        ),
      ),
    );
  }
}
