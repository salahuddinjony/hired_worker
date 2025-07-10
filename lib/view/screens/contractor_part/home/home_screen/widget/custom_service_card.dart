import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomServiceCard extends StatelessWidget {
  const CustomServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(13),
        ),child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomNetworkImage(
              imageUrl: AppConstants.electrician,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13),
                bottomLeft: Radius.circular(13),
              ),
              height: 110.h,
              width: 150.w),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Switchboard Install", fontSize: 14.w,fontWeight: FontWeight.w700,color: AppColors.primary,),
                    SizedBox(width: 10.w,),
                    CustomText(text: "Completed".tr, fontSize: 14.w,fontWeight: FontWeight.w700,color: AppColors.green,),
                  ],
                ),
                CustomText(text: "40 min ago", fontSize: 10.w,fontWeight: FontWeight.w400,color: AppColors.black_07,bottom: 3.h,),
                CustomText(text: "\$ 10/hour", fontSize: 12.w,fontWeight: FontWeight.w500,color: AppColors.black_04,bottom: 3.h,),
                Row(
                  children: [
                    CustomImage(imageSrc: AppIcons.filled),
                    CustomText(text: "4.5", fontSize: 12.w,fontWeight: FontWeight.w500,color: AppColors.black,),
                    CustomText(text: "(87)", fontSize: 12.w,fontWeight: FontWeight.w500,color: AppColors.black_07,),
                  ],
                ),
                SizedBox(height: 4.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "View Post (120)", fontSize: 10.w,fontWeight: FontWeight.w400,color: AppColors.black_04,right: 10.w,),
                    CustomText(text: "Service Request".tr, fontSize: 10.w,fontWeight: FontWeight.w400,color: AppColors.black,right: 10.w,),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.more_horiz,size: 16,))
                  ],
                )
              ],
            ),
          )
        ],
      ),
      ),
    );
  }
}
