import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../home_screen/home_screen.dart';
import 'controller/on_going_controller.dart';

class OnGoingFinishScreen extends StatelessWidget {
  const OnGoingFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int index = Get.arguments['id'];
    final String name =
        Get.find<OnGoingController>()
            .onGoingBookingList[index]
            .customerId
            ?.fullName ??
        " - ";
    final String image =
        Get.find<OnGoingController>()
            .onGoingBookingList[index]
            .customerId?.img ??
        "";
    final Object price = Get.find<OnGoingController>()
            .onGoingBookingList[index]
            .totalAmount ??
        " - ";

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Finish".tr),
      body: Column(
        children: [
          const Center(child: CustomImage(imageSrc: AppIcons.group)),
          CustomText(
            top: 8,
            text: "Finished".tr,
            fontSize: 20.w,
            fontWeight: FontWeight.w400,
            color: AppColors.textCLr,
            bottom: 8,
          ),
          CustomNetworkImage(
            imageUrl: image,
            height: 300.h,
            width: 300.w,
            borderRadius: BorderRadius.circular(10),
          ),
          CustomText(
            top: 10.h,
            text: "You worked for $name",
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            color: AppColors.black_04,
            maxLines: 3,
          ),
          CustomText(
            top: 10.h,
            text: "Your total earning is ",
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            color: AppColors.textCLr,
          ),
          CustomText(
            text: "€$price",
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          CustomText(
            top: 10.h,
            text: "Give $name a rating",
            fontSize: 16.w,
            fontWeight: FontWeight.w400,
            color: AppColors.textCLr,
            bottom: 10,
          ),
          CustomButton(
            width: 180.w,
            height: 40.h,
            isBorder: true,
            onTap: () {
              Get.offAll(() => const HomeScreen());
            },
            title: "Back to Home".tr,
          ),
        ],
      ),
    );
  }
}
