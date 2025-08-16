import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomPopularServicesCard extends StatelessWidget {
  final Function()? onTap;
  final String? image;
  final String? name;
  const CustomPopularServicesCard({
    super.key,
    this.onTap,
    this.image,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Container(
          height: 120.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNetworkImage(
                imageUrl: ImageHandler.imagesHandle(image),
                height: 50,
                width: 50,
              ),
              CustomText(
                top: 10,
                text: name ?? "Plumbing",
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
