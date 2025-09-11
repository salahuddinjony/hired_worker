import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/charge_controller.dart';

import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class ChargeScreen extends StatelessWidget {
  const ChargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChargeController controller = Get.find<ChargeController>();

    final TextEditingController textEditingController = TextEditingController();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Charge"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set up your personal information",
              style: TextStyle(fontSize: 14.sp),
            ),
            Text(
              "You can always change it later.",
              style: TextStyle(fontSize: 14.sp),
            ),

            SizedBox(height: 24.h),

            Text(
              "Amount \$/Hour",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),

            SizedBox(height: 6.h),

            TextField(
              controller: textEditingController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                hintText: "Enter here amount",
                hintStyle: TextStyle(fontSize: 15.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),

            SizedBox(height: 48.h),

            // Loader or Button
            Obx(() {
              return controller.status.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                      controller.updateContractorData(
                        textEditingController.text,
                      );
                    },
                    title: "Continue".tr,
                  );
            }),
          ],
        ),
      ),
    );
  }
}
