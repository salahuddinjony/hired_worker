import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final messages = controller.messages.toList().reversed.toList();
      final user = (controller.user is Rx)
          ? (controller.user as Rx).value
          : controller.user;

      return Expanded(
        child: Stack(
          children: [
            Flexible(
              child: Chat(
            messages: messages,
            onSendPressed: controller.handleSendPressed,
            customMessageBuilder: (message, {required int messageWidth}) {
              // Render image messages with our CustomNetworkImage which already
              // provides a shimmer placeholder and error widget.
              if (message is types.ImageMessage) {
                final types.ImageMessage img = message as types.ImageMessage;
                // choose a reasonable display size based on available width
                final double imgWidth = (messageWidth * 0.7).clamp(120.0, 320.0);
                final double imgHeight = imgWidth * 0.66;

                return Container(
                  constraints: BoxConstraints(
                    maxWidth: imgWidth,
                    maxHeight: imgHeight,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CustomNetworkImage(
                      imageUrl: img.uri,
                      height: imgHeight,
                      width: imgWidth,
                      boxShape: BoxShape.rectangle,
                    ),
                  ),
                );
              }

              return const SizedBox.shrink(); // fallback to default renderer for non-image messages
            },
            // onAttachmentPressed: null, // Disabled to prevent asset loading errors
            showUserAvatars: true,
            showUserNames: true,
            user: user,
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
        ),
      );
    });
  }
}
