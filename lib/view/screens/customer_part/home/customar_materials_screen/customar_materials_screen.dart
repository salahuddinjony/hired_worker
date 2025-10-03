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

/// CustomarMaterialsScreen - A stateless widget for selecting materials with quantities
/// 
/// This screen expects the following arguments when navigating:
/// - controller: ContractorBookingController instance
/// - materials: List<Map<String, String>> with the following structure:
///   [
///     {
///       'name': 'Material Name',
///       'unit': 'pcs' // or 'kg', 'liters', etc.
///     }
///   ]
/// - contractorId: String
/// - subcategoryId: String
/// 
/// Example usage:
/// Get.toNamed(AppRoutes.customarMaterialsScreen, arguments: {
///   'controller': contractorBookingController,
///   'materials': [
///     {'name': 'Power Point', 'unit': 'pcs'},
///     {'name': 'Smoke Alarm', 'unit': 'pcs'},
///     {'name': 'Circuit Breaker', 'unit': 'pcs'},
///   ],
///   'contractorId': 'contractor123',
///   'subcategoryId': 'subcat456',
/// });
class CustomarMaterialsScreen extends StatelessWidget {
  const CustomarMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContractorBookingController controller = Get.arguments['controller'];
    final List<dynamic> materials = Get.arguments['materials'] ?? [];
    final String contractorId = Get.arguments['contractorId'] ?? '';
    final String subcategoryId = Get.arguments['subcategoryId'] ?? '';
    
    // Initialize materials in controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (materials.isNotEmpty) {
        controller.initializeMaterials(materials);
      } else {
        // Fallback: initialize with some default materials if none provided
        controller.initializeMaterials([
          {'name': 'Power Point', 'unit': 'pcs'},
          {'name': 'Smoke Alarm', 'unit': 'pcs'},
          {'name': 'Circuit Breaker', 'unit': 'pcs'},
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
                        Obx(() => Switch(
                          value: controller.showMaterials.value,
                          onChanged: (value) {
                            controller.toggleShowMaterials();
                          },
                        )),
                      ],
                    ),
                    Obx(() {
                      if (controller.showMaterials.value) {
                        if (controller.materialsAndQuantity.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: CustomText(
                                text: "No materials available".tr,
                                fontSize: 16.w,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black_08,
                              ),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.builder(
                            itemCount: controller.materialsAndQuantity.length,
                            itemBuilder: (context, index) {
                              final material = controller.materialsAndQuantity[index];
                              return SelectMaterialsRow(
                                name: material['name'],
                                unit: material['unit'],
                                quantity: material['quantity'] ?? '0',
                                isSelected: controller.isMaterialSelected(index),
                                onIncrement: () => controller.incrementMaterial(index),
                                onDecrement: () => controller.decrementMaterial(index),
                              );
                            },
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
        child: CustomButton(
          onTap: () {
            debugPrint('Selected Materials: ${controller.materialsAndQuantity.where((m) => controller.isMaterialSelected(controller.materialsAndQuantity.indexOf(m))).toList()}');
            Get.toNamed(
              AppRoutes.customarServiceDetailsScreen,
              arguments: {
                'controller': controller,
                'contractorId': contractorId,
                'subcategoryId': subcategoryId,
              },
            );
          },
          title: "Continue".tr,
        ),
      ),
    );
  }
}


/*Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: MediaQuery.sizeOf(context).height / 3,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    CustomText(
                      text: "Taotal Amount Info",
                      fontSize: 20.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                    Divider(thickness: .3, color: AppColors.black_08),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Electrician",
                              fontSize: 18.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: "AC Repair",
                              fontSize: 12.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_08,
                            ),
                          ],
                        ),
                        CustomText(
                          text: "250.00\$",
                          fontSize: 18.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Total Materials",
                          fontSize: 18.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text: "250.00\$",
                          fontSize: 18.w,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    Divider(thickness: .3, color: AppColors.black_08),
                    SizedBox(height: 12.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Total Materials",
                          fontSize: 20.w,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text: "250.00\$",
                          fontSize: 20.w,
                          fontWeight: FontWeight.w800,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h,),
                    CustomButton(onTap: (){
                      Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    }, title: "Booking Confirm",)
                  ],
                ),
              ),
            ),
          ),*/