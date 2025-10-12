import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/screens/message/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'loader_overlay.dart';

class ChatBody extends StatelessWidget {
  final ChatController controller;
  final String receiverImage;

  const ChatBody({
    super.key,
    required this.controller,
    required this.receiverImage,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final messages = controller.messages.toList().reversed.toList();
      final user = (controller.user is Rx)
          ? (controller.user as Rx).value
          : controller.user;

      return Stack(
        children: [
          Chat( 
            messages: messages,
            onSendPressed: controller.handleSendPressed,
                // onAttachmentPressed: null, // Disabled to prevent asset loading errors
                showUserAvatars: true,
                showUserNames: true,
                user: user,
                usePreviewData: false,
            theme: const DefaultChatTheme(
              // subtle messenger-like colors
              inputBackgroundColor: AppColors.primary,
              inputTextColor: Colors.white,
              primaryColor: AppColors.primary,
              secondaryColor: Colors.purpleAccent,
              sendButtonIcon: Icon(Icons.send, color: Colors.white),
              // you can tune more fields here if your package version supports them
            ),
          ),
          Positioned.fill(
            bottom: 88,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onLongPress: () {},
            ),
          ),
          if (controller.isLoading.value) const LoaderOverlay(),
        ],
      );
    });
  }
}
