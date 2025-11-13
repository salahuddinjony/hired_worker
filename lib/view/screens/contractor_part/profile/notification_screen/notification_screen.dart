import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/model/notification_model.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import 'widget/custom_notification_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.find<ProfileController>();

    controller.getNotification();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Notification".tr),
      body: Obx(() {
        if (controller.notificationStatus.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (controller.notificationStatus.value.isEmpty) {
          return const Center(
            child: Text('There are no notifications available for you.'),
          );
        } else if (controller.notificationStatus.value.isError) {
          return Center(
            child: Text(controller.notificationStatus.value.errorMessage!),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: controller.notificationModel.value.data!.length,
              itemBuilder: (context, index) {
                final CustomNotification notification =
                    controller.notificationModel.value.data![index];

                return CustomNotificationList(
                  title: notification.title ?? " - ",
                  message: notification.message ?? " - ",
                );
              },
            ),
          );
        }
      }),
    );
  }
}
