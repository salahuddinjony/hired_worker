import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/widgets/custom_avatar/custom_avatar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class MessageCard extends StatelessWidget {
  final String imageUrl;
  final String senderName;
  final String message;
  final VoidCallback onTap;
  final String? lastMessageTime;

  const MessageCard({
    super.key,
    required this.imageUrl,
    required this.senderName,
    required this.message,
    required this.onTap,
    this.lastMessageTime,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1), // Shadow color
              spreadRadius: 2, // Spread the shadow
              blurRadius: 5, // Blur radius
              offset: const Offset(0, 2), // Shadow offset
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAvatar(
              imageUrl: imageUrl,
              name: senderName,
              size: 40,
              fontSize: 16,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: senderName,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                Row(
                  children: [
                    CustomText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text:
                          message.length > 20
                              ? message.substring(0, 17) + "..."
                              : message,

                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    if (lastMessageTime != null) ...[
                      SizedBox(width: 8.w),
                      CustomText(
                        text: "• " + lastMessageTime!,

                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
