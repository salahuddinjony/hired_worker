import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/contractor_part/message/controller/message_controller.dart';
import 'package:servana/view/screens/contractor_part/message/message_list_screen/widget/chat_bubble.dart';
import 'package:servana/view/screens/contractor_part/message/message_list_screen/widget/chat_input.dart';
import 'package:servana/view/screens/contractor_part/message/message_list_screen/widget/message_appbar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageController messageController = Get.find<MessageController>();
   String roomId =Get.arguments[0];
   String receiverId = Get.arguments[1];
  String? currentUserId;

  @override
  void initState() {
    super.initState();
   
    _initialize();
  }

  Future<void> _initialize() async {
    currentUserId = await SharePrefsHelper.getString(AppConstants.userId);
    messageController.getAllMessageList(roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MessageAppBar(),
      backgroundColor: const Color(0xFFF3EAF4),
      body: Obx(() {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Card(
              color: AppColors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    Center(
                      child: CustomText(
                        text: "Today",
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Expanded(
                      child: ListView.builder(
                        controller: messageController.scrollController,
                        itemCount: messageController.conversationModel.value.data?.length ?? 0,
                        padding: EdgeInsets.only(bottom: 12.h),
                        itemBuilder: (context, index) {
                          final msg = messageController.conversationModel.value.data?[index];
                          final isSent = msg?.sender == currentUserId;
                          return ChatBubble(
                            text: msg?.message ?? '',
                            isSent: isSent,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: ChatInputField(
                        controller: messageController.messageController,
                        onSend: () {
                          messageController.sendMessage(
                            receiverId: receiverId,
                            chatRoomId: roomId,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
