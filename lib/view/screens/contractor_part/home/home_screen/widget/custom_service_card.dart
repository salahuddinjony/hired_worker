import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:servana/helper/time_converter/time_converter.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
import '../../../map/google_map_screen.dart';

class CustomServiceCard extends StatelessWidget {
  final String title;
  final String status;
  final DateTime updateDate;
  final String hourlyRate;
  final String rating;
  final String? image;
  final String? location;
  final String? customerImage;
  final String? customerName;
  final String? subcategoryName;

  const CustomServiceCard({
    super.key,
    required this.title,
    required this.updateDate,
    required this.hourlyRate,
    required this.rating,
    required this.status,
    required this.image, this.location, this.customerImage, this.customerName, this.subcategoryName,
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
            if (image != null && image!.isNotEmpty)
              CustomNetworkImage(
                imageUrl: image!,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
                height: 155.h,
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

                    const SizedBox(height: 6.0),
                    Row(
                      children: [
                        CustomNetworkImage(
                          imageUrl: customerImage ?? "",
                          height: 20,
                          width: 20,
                          boxShape: BoxShape.circle,
                        ),
                        CustomText(
                          left: 8,
                          text:  customerName ?? " - ",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),

                    const SizedBox(height: 6.0),

                    Row(
                      children: [
                        const Icon(Icons.home_repair_service, size: 20),
                        CustomText(
                          left: 8,
                          text: subcategoryName ?? " - ",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),


                    CustomText(
                      text: "\$ $hourlyRate",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black_04,
                      bottom: 3.h,
                    ),
                    // Row(
                    //   children: [
                    //     const CustomImage(imageSrc: AppIcons.filled),
                    //     CustomText(
                    //       text: rating,
                    //       fontSize: 12.w,
                    //       fontWeight: FontWeight.w500,
                    //       color: AppColors.black,
                    //     ),
                    //   ],
                    // ),


                    SizedBox(height: 6.h),

                    GestureDetector(
                      onTap: () {
                        Get.to(() => GoogleMapScreen(location: location ?? ""));
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            size: 14,
                            color: AppColors.blue,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: CustomText(
                              text: location ?? " - ",
                              fontSize: 12.w,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blue,
                            ),
                          ),
                        ],
                      ),
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
