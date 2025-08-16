import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomNotificationList extends StatelessWidget {
  const CustomNotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .1,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 20,
              child: Icon(Icons.notifications_none, color: AppColors.white),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "Password Update Successfully",
                  fontSize: 15.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  bottom: 4,
                ),
                CustomText(
                  text: "Your Password Update Successfully",
                  fontSize: 11.w,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textCLr,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
