import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/commot_not_found/not_found.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/profile/model/notification_model.dart';
import 'package:servana/view/screens/customer_part/profile/controller/customer_profile_controller.dart';
import '../../../contractor_part/profile/notification_screen/widget/custom_notification_list.dart';

class CustomerNotificationScreen extends StatelessWidget {
  const CustomerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final CustomerProfileController controller = args['controller'];

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Notification".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Obx(() {
          final notifications = controller.notificationsList;
          if (controller.getNotificationStatus.value.isLoading) {
            return const Center(child: CustomLoader());
          } else if (notifications.isEmpty) {
            return const Center(
              child: NotFound(
                message: "No notifications Available",
                icon: Icons.notifications_off,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final CustomNotification notification = notifications[index];
                return CustomNotificationList(
                  title: notification.title ?? " - ",
                  message: notification.message ?? " - ",
                );
              },
            );
          }
        }),
      ),
    );
  }
}
