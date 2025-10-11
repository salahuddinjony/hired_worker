import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';

import '../../../../../core/app_routes/app_routes.dart';
import 'widget/custom_ongoing_card.dart';

class OnGoingScreen extends StatelessWidget {
  const OnGoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContractorHomeController controller =
        Get.find<ContractorHomeController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "On Going".tr),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (controller.status.value.isError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.status.value.errorMessage!),
                ElevatedButton(
                  onPressed: () {
                    controller.getAllBookings();
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: List.generate(
                    controller.onGoingBookingList.value.data!.length,
                    (value) {
                      return CustomOngoingCard(index: value);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
