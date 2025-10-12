
import 'package:flutter/material.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text_field/custom_text_field.dart';
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
            hintStyle: const TextStyle(color: AppColors.black_08),
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
