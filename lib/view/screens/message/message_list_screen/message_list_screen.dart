import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/message/controller/message_controller.dart';
import 'widget/custom_message_list_card.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MessageController messageController = Get.find<MessageController>();
    return Scaffold(
      extendBody: true,

      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Messages".tr),
      body: Obx(() {
        final data = messageController.allMessageRoomModel.value.data ?? [];
        return Column(
          children: List.generate(data.length, (value) {
            return GestureDetector(
              onTap: () async {
                debugPrint(
                  "===========================>> Other UserId:${data[value].otherUserId}",
                );
                final userId = await SharePrefsHelper.getString(
                  AppConstants.userId,
                );
                debugPrint("===========================>> User Id:$userId");

                Get.toNamed(
                  AppRoutes.chatScreen,
                  arguments: [
                    data[value].id,
                    data[value].otherUserId,
                    data[value].otherUserName,
                    data[value].otherUserImage,
                  ],
                );
              },
              child: CustomMessageListCard(
                image: data[value].otherUserImage,
                lastMessage: data[value].lastMessage,
                name: data[value].otherUserName,
                lastTime:
                    data[value].lastMessageTime != null
                        ? data[value].lastMessageTime.toString()
                        : DateTime.now().toString(),
              ),
            );
          }),
        );
      }),
      bottomNavigationBar:
          messageController.role
              ? const Navbar(currentIndex: 2)
              : const CustomerNavbar(currentIndex: 2),
    );
  }
}
