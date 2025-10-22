import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomServiceContractorCard extends StatelessWidget {
  final Function()? onTap;
  final String? image;
  final String? name;
  final String? title;
  final String? rating;
  final String? hourlyPrice;
  const CustomServiceContractorCard({super.key, this.onTap, this.image, this.name, this.title, this.rating, required this.hourlyPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.sizeOf(context).width / 2.3,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: image ?? AppConstants.profileImage,
                height: 160.h,
                width: MediaQuery.sizeOf(context).width,
                borderRadius: BorderRadius.circular(8),
              ),
              CustomText(
                top: 8,
                text: name ?? "Maskot Kota",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
              ),
              CustomText(
                text: title ?? "Electrician",
                fontSize: 12.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black_08,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, size: 10, color: AppColors.blue),
                      CustomText(
                        text: rating ?? "4.8",
                        fontSize: 12.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue,
                      ),
                      SizedBox(width: 8.w),
                      // Hourly rate badge
                      if ((hourlyPrice ?? '').isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: .08),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.primary.withValues(alpha: .2)),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 5.w),
                              CustomText(
                                text: (() {
                                  final dp = (hourlyPrice ?? '').trim();
                                  if (dp.isEmpty) return '';
                                  return 'AUD $dp';
                                })(),
                                fontSize: 12.w,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomText(
                          text: "Details",
                          fontSize: 10.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
