import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/helper/time_converter/time_converter.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomServiceCard extends StatelessWidget {
  final String title;
  final String status;
  final DateTime updateDate;
  final String hourlyRate;
  final String rating;
  final String? image;

  const CustomServiceCard({
    super.key,
    required this.title,
    required this.updateDate,
    required this.hourlyRate,
    required this.rating,
    required this.status,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: image != null && image!.isNotEmpty ? 0 : 15.w,
        ),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: AppColors.cardClr,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (image != null && image!.isEmpty)
              CustomNetworkImage(
                imageUrl: image!,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
                height: 110.h,
                width: 150.w,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 1,
                            title,
                            style: TextStyle(
                              fontSize: 14.w,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          maxLines: 1,
                          status,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: timeAgo(updateDate),
                      fontSize: 11.w,
                      fontWeight: FontWeight.w300,
                      color: AppColors.black_07,
                      bottom: 3.h,
                    ),

                    const SizedBox(height: 4.0),

                    CustomText(
                      text: "\$ $hourlyRate/hour",
                      fontSize: 12.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_04,
                      bottom: 3.h,
                    ),
                    Row(
                      children: [
                        CustomImage(imageSrc: AppIcons.filled),
                        CustomText(
                          text: rating,
                          fontSize: 12.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
