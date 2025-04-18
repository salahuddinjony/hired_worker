import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomPopularServicesCard extends StatelessWidget {
  final Function()? onTap;
  const CustomPopularServicesCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 100.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.electrician,
                height: 50,
                width: 50,
              ),
              CustomText(
                top: 10,
                text: "Plumbing",
                fontSize: 12.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
