// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:servana/utils/app_colors/app_colors.dart';
// import 'package:servana/view/components/custom_text/custom_text.dart';
// class ChatBubble extends StatelessWidget {
//   final String text;
//   final bool isSent;
//
//   const ChatBubble({super.key, required this.text, required this.isSent});
//
//   @override
//   Widget build(BuildContext context) {
//     final alignment = isSent ? Alignment.centerRight : Alignment.centerLeft;
//     final backgroundColor =
//         isSent ? AppColors.primary : const Color(0xFFE6E6E6);
//     final textColor = isSent ? Colors.white : Colors.black;
//
//     return Align(
//       alignment: alignment,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 4.h),
//         padding: EdgeInsets.all(12.r),
//         constraints: BoxConstraints(maxWidth: 250.w),
//         decoration: BoxDecoration(
//           color: backgroundColor,
//           borderRadius: BorderRadius.circular(12.r),
//         ),
//         child: CustomText(
//           text: text,
//           color: textColor,
//           fontSize: 14,
//           maxLines: 4,
//           textAlign: TextAlign.start,
//         ),
//       ),
//     );
//   }
// }
