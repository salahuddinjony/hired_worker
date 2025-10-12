import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomGetCard extends StatelessWidget {
  final Color? bkColor;
  const CustomGetCard({super.key, this.bkColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.sizeOf(context).width / 1.8,
        decoration: BoxDecoration(
          color:bkColor?? const Color(0xffFFBC99),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: "Offer AC Service",
                  fontSize: 13.w,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black_09,
                  right: 6,
                ),
                const Icon(
                  Icons.info_rounded,
                  color: AppColors.black_09,
                  size: 17,
                ),
              ],
            ),
            CustomText(
              text: "Get 25%",
              fontSize: 48.w,
              fontWeight: FontWeight.w600,
              color: AppColors.black_09,
            ),
            Container(
              width: 108,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Row(
                children: [
                  CustomText(
                    text: "Grab Offer",
                    fontSize: 14.w,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff6A9B7E),
                    right: 4,
                  ),
                  const Icon(Icons.arrow_forward_ios_outlined,size: 14,color: Color(0xff6A9B7E),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
