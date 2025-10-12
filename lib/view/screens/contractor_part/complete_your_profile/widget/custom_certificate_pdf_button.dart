import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../utils/app_images/app_images.dart';
import '../../../../components/custom_image/custom_image.dart';
class CustomCertificatePdfButton extends StatelessWidget {
  final String? label;
  final String? title;
  final Function()? onTap;
   const CustomCertificatePdfButton({super.key, this.label, this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: label?? "", fontSize: 14.w,fontWeight: FontWeight.w600,color: AppColors.black,),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 70,
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD8C6D7),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.transparent, width: 1),
              ),
              alignment: Alignment.center,
              child: const CustomImage(imageSrc: AppImages.pdfIcon),
            ),
          ),
          CustomText(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black_08,
            textAlign: TextAlign.center,
            text: title??"",

          ),
        ],
      ),
    );
  }
}
