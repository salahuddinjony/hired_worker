import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_const/app_const.dart';
import '../../../../../components/custom_button/custom_button.dart';
import '../../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomOngoingCard extends StatelessWidget {
  final void Function()? rightOnTap;
  const CustomOngoingCard({super.key, this.rightOnTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: AppConstants.electrician,
                height: 170.h,
                width: 126.w,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Right now",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    bottom: 10.h,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 20),
                      CustomText(
                        text: "38 Chestnut Street Staunton",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: AppConstants.profileImage,
                        height: 20,
                        width: 20,
                        boxShape: BoxShape.circle,
                      ),
                      CustomText(
                        left: 8,
                        text: "Minnie",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.home_repair_service, size: 20),
                      CustomText(
                        left: 8,
                        text: "Switchboard Install",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.price_check, size: 20),
                      CustomText(
                        left: 8,
                        text: "150 \$ ",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 20),
                      CustomText(
                        left: 8,
                        text: "03 : 00 PM - 05 : 00 PM",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Flexible(
                child: CustomButton(
                  height: 35,
                  onTap: () {},
                  title: "Cancel",
                  isBorder: true,
                  fillColor: Colors.transparent,
                  borderWidth: 1,
                  textColor: AppColors.red,
                ),
              ),
              SizedBox(width: 10.w,),
              Flexible(
                child: CustomButton(
                  height: 35,
                  onTap: rightOnTap ?? () =>(),
                  title: "Finish",
                  fillColor: AppColors.primary,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Divider(thickness: .5,color: AppColors.primary.withValues(alpha: .5),)
        ],
      ),
    );
  }
}
