import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import 'widget/select_materials_row.dart';

class CustomarMaterialsScreen extends StatefulWidget {
  const CustomarMaterialsScreen({super.key});

  @override
  State<CustomarMaterialsScreen> createState() => _CustomarMaterialsScreenState();
}

class _CustomarMaterialsScreenState extends State<CustomarMaterialsScreen> {
  bool showMaterials = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Materials".tr),
      body: Stack(
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
                    Switch(
                      value: showMaterials,
                      onChanged: (value) {
                        setState(() {
                          showMaterials = value;
                        });
                      },
                    ),
                  ],
                ),
                if (showMaterials)
                  Column(
                    children: List.generate(
                      5,
                          (index) => SelectMaterialsRow(name: "Powerpoint"),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 20, left: 20,),
        child: CustomButton(onTap: (){
          Get.toNamed(AppRoutes.customarServiceDetailsScreen);
        },title: "Continue".tr,),
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