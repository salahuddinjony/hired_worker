import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomHomeCard extends StatelessWidget {
  final String? text;
  final String? title;
  final String? imageSrc;
  final Function()? onTap;
  const CustomHomeCard({super.key, this.text, this.title, this.imageSrc, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        width: MediaQuery.sizeOf(context).width / 2.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: Colors.transparent,
          border: Border.all(color: AppColors.black_07, width: .7),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: text??  "\$250",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                CustomImage(imageSrc: imageSrc?? AppIcons.iconOone),
              ],
            ),
            CustomText(
              top: 10.h,
              text: title??"Total Earning this month",
              fontSize: 12.w,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
          ],
        ),
      ),
    );
  }
}
