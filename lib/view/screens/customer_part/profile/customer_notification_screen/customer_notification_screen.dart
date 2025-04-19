import 'package:flutter/material.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../contractor_part/profile/notification_screen/widget/custom_notification_list.dart';
class CustomerNotificationScreen extends StatelessWidget {
  const CustomerNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Notification",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
            children: List.generate(5, (value){
              return CustomNotificationList();
            })
        ),
      ),
    );
  }
}
