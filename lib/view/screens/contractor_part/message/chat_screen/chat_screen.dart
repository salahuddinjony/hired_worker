import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/components/custom_text_field/custom_text_field.dart';

// Message AppBar
class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessageAppBar({super.key, this.imageUrl, this.name});

  final String? imageUrl;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                  CustomNetworkImage(
                    imageUrl: imageUrl ?? AppConstants.profileImage,
                    height: 55.h,
                    width: 55.w,
                    boxShape: BoxShape.circle,
                  ),
                  Expanded(
                    child: CustomText(
                      left: 10,
                      text: name ?? "Thomas",
                      color: Colors.black,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

// Chat Bubble (Reusable)
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSent;

  const ChatBubble({super.key, required this.text, required this.isSent});

  @override
  Widget build(BuildContext context) {
    final alignment = isSent ? Alignment.centerRight : Alignment.centerLeft;
    final backgroundColor =
        isSent ? AppColors.primary : const Color(0xFFE6E6E6);
    final textColor = isSent ? Colors.white : Colors.black;

    return Align(
      alignment: alignment,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.all(12.r),
        constraints: BoxConstraints(maxWidth: 250.w),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: CustomText(
          text: text,
          color: textColor,
          fontSize: 14,
          maxLines: 4,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

// Chat Input (Reusable)
class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            textEditingController: controller,
            hintText: "Type a message",
            fillColor: AppColors.white,
            isDens: true,
            hintStyle: TextStyle(color: AppColors.black_08),
            fieldBorderColor: AppColors.backgroundClr,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send, color: AppColors.primary),
          onPressed: onSend,
        ),
      ],
    );
  }
}

// Chat Screen
class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text':
          'Lorem ipsum dolor sit amet consectetur. Enim posuere aenean enim malesuada diam donec augue facilisi.',
      'isSent': false,
    },
    {'text': 'Hello', 'isSent': false},
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text':
          'Lorem ipsum dolor sit amet consectetur. Enim posuere aenean enim malesuada diam donec augue facilisi.',
      'isSent': false,
    },
    {'text': 'Hello', 'isSent': false},
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
    {
      'text': 'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
      'isSent': true,
    },
  ];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add({'text': text, 'isSent': true});
    });

    _controller.clear();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const MessageAppBar(),
      backgroundColor: const Color(0xFFF3EAF4),
      body: SafeArea(
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

                  /// Expanded ListView
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length,
                      padding: EdgeInsets.only(bottom: 12.h),
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return ChatBubble(
                          text: msg['text'],
                          isSent: msg['isSent'],
                        );
                      },
                    ),
                  ),

                  /// Chat Input Inside
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: ChatInputField(
                      controller: _controller,
                      onSend: _handleSend,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
