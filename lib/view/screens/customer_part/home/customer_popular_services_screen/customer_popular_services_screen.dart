import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import '../customer_home_screen/widget/custom_popular_services_card.dart';

class CustomerPopularServicesScreen extends StatelessWidget {
  const CustomerPopularServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Popular Services"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Maintenance",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Cleaning",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Home improvement",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Security",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Car Maintenance",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Handyman Services",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Painting Services",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
              CustomText(
                top: 10,
                text: "Other services",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
