import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/on_going_controller.dart';

import 'widget/custom_ongoing_card.dart';

class OnGoingScreen extends StatelessWidget {
  const OnGoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnGoingController controller = Get.find<OnGoingController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "On Going".tr),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return const Center(
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
                    controller.getOnGoingBookings();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            controller: controller.scrollController,
            itemCount:
                controller.onGoingBookingList.length +
                (controller.status.value.isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.onGoingBookingList.length) {
                return CustomOngoingCard(index: index);
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              }
            },
          );
        }
      }),
    );
  }
}
