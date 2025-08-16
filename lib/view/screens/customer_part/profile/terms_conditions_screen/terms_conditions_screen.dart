import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/global/general_controller/general_controller.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GeneralController generalController = Get.find<GeneralController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Terms & Conditions".tr,
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomText(
                text: generalController.terms.value,
                fontSize: 18.w,
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                textAlign: TextAlign.justify,
                maxLines: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
