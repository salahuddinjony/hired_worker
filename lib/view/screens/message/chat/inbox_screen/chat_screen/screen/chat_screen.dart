import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/screens/message/chat/controllers/chat_controller.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/chat_screen/widgets/chat_header.dart';
import '../widgets/chat_body.dart';
import '../widgets/typing_indicator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final String receiverName = args['receiverName'];
    final String receiverImage = args['receiverImage'];
    final String conversationId = args['conversationId'];
    final String userId = args['userId'];
    final String receiverId = args['receiverId'];
    final String userRole = args['userRole'];
    final bool isCustomer = args['isCustomer'];

    final controller =
        Get.isRegistered<ChatController>(tag: conversationId)
            ? Get.find<ChatController>(tag: conversationId)
            : Get.put(
              ChatController(
                conversationId: conversationId,
                userRole: userRole,
                userId: userId,
                receiverId: receiverId,
              ),
              tag: conversationId,
            );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ChatHeader(
        id: userId,
        receiverName: receiverName,
        receiverImage: receiverImage,
        isCustomer: isCustomer,
        onBack: () => Get.back(),
        onMore: () {},
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, AppColors.primary.withValues(alpha: .03)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const Divider(height: 1),
              Expanded(
                child: ChatBody(
                  controller: controller,
                  receiverImage: receiverImage,
                ),
              ),
              // Obx(() => TypingIndicator(visible: controller.isTyping.value)),
            ],
          ),
        ),
      ),
    );
  }
}
