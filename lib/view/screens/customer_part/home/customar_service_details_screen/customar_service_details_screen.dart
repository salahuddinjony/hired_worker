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

class CustomarServiceDetailsScreen extends StatefulWidget {
  const CustomarServiceDetailsScreen({super.key});

  @override
  State<CustomarServiceDetailsScreen> createState() =>
      _CustomarServiceDetailsScreenState();
}

class _CustomarServiceDetailsScreenState
    extends State<CustomarServiceDetailsScreen> {
  int selectedIndex = -1; //
  @override
  Widget build(BuildContext context) {
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
                      CustomRoyelAppbar(leftIcon: true),
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
                    //color: AppColors.red,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.timer, color: AppColors.black),
                                CustomText(
                                  left: 8.w,
                                  text: "One Time",
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_month,
                                  color: AppColors.black,
                                ),
                                CustomText(
                                  left: 8.w,
                                  text: "Weekly",
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                        text: "Hours -",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      Row(
                        children: List.generate(5, (index) {
                          final isSelected = selectedIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 6),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  CustomFormCard(
                    title: "Time",
                    hintText: "mm/dd/yyyy",
                    prefixIcon: Icon(
                      Icons.calendar_month,
                      color: AppColors.black_08,
                    ),
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.black_08,
                    ),
                    controller: TextEditingController(),
                  ),
                  CustomFormCard(
                    title: "Category",
                    hintText: "Select Category",
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.black_08,
                    ),
                    controller: TextEditingController(),
                  ),
                  CustomFormCard(
                    title: "Sub Category",
                    hintText: "Select Category",
                    suffixIcon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.black_08,
                    ),
                    controller: TextEditingController(),
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "Charge /Hour 50\$",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    bottom: 8,
                  ),
                  CustomText(
                    text: "Total:  USD 250.00 (5 Hours)",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                    bottom: 50,
                  ),
                  CustomButton(onTap: (){
                    Get.toNamed(AppRoutes.customarServiceContractorDetailsScreen);
                  }, title: "Continue",)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
