import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/utils.dart';
import 'package:servana/view/screens/contractor_part/profile/model/withdraw_history_model.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomEarnContainer extends StatelessWidget {
  final WithdrawalData data;

  const CustomEarnContainer({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: data.payoutId ?? " - ",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: "+\$${data.amount ?? " - "}",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
            // CustomText(
            //   top: 6,
            //   text: "Fan Installation",
            //   fontSize: 18.w,
            //   fontWeight: FontWeight.w500,
            //   color: AppColors.black,
            //   bottom: 10.h,
            // ),
            CustomText(
              text: data.createdAt!.toIso8601String().substring(0, 10),
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomImage(imageSrc: AppIcons.stripe),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: (data.status ?? " - ").capitalizeFirst!,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
