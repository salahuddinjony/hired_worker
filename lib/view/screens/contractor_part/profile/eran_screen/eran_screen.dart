import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../controller/profile_controller.dart';
import 'widget/custom_earn_container.dart';

class EranScreen extends StatefulWidget {
  const EranScreen({super.key});

  @override
  State<EranScreen> createState() => _EranScreenState();
}

class _EranScreenState extends State<EranScreen> {
  final profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.r),
                bottomRight: Radius.circular(25.r),
              ),
            ),
            child: Column(
              children: [
                CustomRoyelAppbar(
                  leftIcon: true,
                  titleName: "My Balance".tr,
                  color: AppColors.white,
                  backgroundClr: Colors.transparent,
                ),
                CustomText(
                  text: "\$12,00",
                  fontSize: 20.w,
                  fontWeight: FontWeight.w500,
                  bottom: 10.h,
                ),
                CustomText(
                  text: "Available Balance".tr,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white.withValues(alpha: .5),
                  bottom: 20.h,
                ),
                CustomButton(
                  width: 120.w,
                  height: 36.h,
                  onTap: () {},
                  title: "Withdraw".tr,
                  textColor: AppColors.primary,
                  fillColor: AppColors.white,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          CustomText(
            top: 10.h,
            left: 16.w,
            text: "Activity".tr,
            fontSize: 20.w,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            bottom: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: CustomTabBar(
              tabs: profileController.nameList,
              selectedIndex: profileController.currentIndex.value,
              onTabSelected: (value) {
                profileController.currentIndex.value = value;
                setState(() {});
                profileController.update();
              },
              selectedColor: AppColors.primary,
              unselectedColor: AppColors.black_04,
            ),
          ),
          SizedBox(height: 10.h),
          if (profileController.currentIndex.value == 0)
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(3, (value) {
                  return const CustomEarnContainer();
                }),
              ),
            ),
          if (profileController.currentIndex.value == 1)
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(2, (value) {
                  return CustomEarnContainer(statusText: "Pending".tr);
                }),
              ),
            ),
          if (profileController.currentIndex.value == 2)
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: List.generate(1, (value) {
                  return CustomEarnContainer(statusText: "Rejected".tr);
                }),
              ),
            ),
        ],
      ),
    );
  }
}
