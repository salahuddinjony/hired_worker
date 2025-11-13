import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/widgets/custom_avatar/custom_avatar.dart';
import 'package:servana/view/screens/message/chat/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'loader_overlay.dart';

class ChatBody extends StatelessWidget {
  final ChatController controller;
  final String receiverImage;

  const ChatBody({
    super.key,
    required this.controller,
    required this.receiverImage,
  });

  Widget buildCustomAvatar(types.User author) {
    final String? imageUrl = author.imageUrl;
    final String name = author.firstName ?? 'U';

    return CustomAvatar(
      imageUrl: imageUrl,
      name: name,
      size: 32,
      fontSize: 14,
      padding: const EdgeInsets.only(
        right: 5,
      ), // 5px gap to the right of avatar
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final messages = controller.messages.toList().reversed.toList();
      final user =
          (controller.user is Rx)
              ? (controller.user as Rx).value
              : controller.user;

      return Stack(
        children: [
          Chat(
            messages: messages,
            onSendPressed: controller.handleSendPressed,
            // onAttachmentPressed: null, // Disabled to prevent asset loading errors
            showUserAvatars: true,
            showUserNames: false,
            user: user,
            usePreviewData: false,
            avatarBuilder: (author) => buildCustomAvatar(author),
            theme: const DefaultChatTheme(
              inputBackgroundColor: AppColors.primary,
              inputTextColor: Colors.white,
              primaryColor: AppColors.primary,
              secondaryColor: Colors.purpleAccent,
              sendButtonIcon: Icon(Icons.send, color: Colors.white),
              // Reduce message text sizes
              receivedMessageBodyTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 12, // Decreased from default 16
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              sentMessageBodyTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 12, // Decreased from default 16
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
              // Reduce user name text size
              receivedMessageCaptionTextStyle: TextStyle(
                color: Colors.grey,
                fontSize: 11, // Decreased from default 12
                fontWeight: FontWeight.w500,
              ),
              sentMessageCaptionTextStyle: TextStyle(
                color: Colors.grey,
                fontSize: 11, // Decreased from default 12
                fontWeight: FontWeight.w500,
              ),
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
