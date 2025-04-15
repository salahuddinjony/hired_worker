import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/contractor_part/home/home_screen/widget/custom_service_card.dart';
import '../../../../components/custom_nav_bar/navbar.dart';
import 'widget/custom_home_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 70.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.menu, color: AppColors.black),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Welcome!",
                          fontSize: 20.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black_02,
                          bottom: 2,
                        ),
                        CustomText(
                          text: "Mehedi Bin Ab. Salam (Electrician)",
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ],
                ),
                CustomNetworkImage(
                  imageUrl: AppConstants.profileImage,
                  height: 45,
                  width: 45,
                  boxShape: BoxShape.circle,
                ),
              ],
            ),
            SizedBox(height: 20.h),
           Expanded(child: ListView(
             padding: EdgeInsets.zero,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomHomeCard(),
                   CustomHomeCard(text: "90",title: "Total Service",imageSrc: AppIcons.iconTwo,),
                 ],
               ),
               SizedBox(height: 10.h),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomHomeCard(text: "9",title: "Upcoming Services",imageSrc: AppIcons.iconTwo,),
                   CustomHomeCard(text: "3",title: "Total Service",imageSrc: AppIcons.iconTwo,),
                 ],
               ),
               SizedBox(height: 10.h),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomHomeCard(text: "15",title: "Recent Services",imageSrc: AppIcons.iconTwo,),
                   CustomHomeCard(text: "\$50/hr",title: "Current billing price",imageSrc: AppIcons.iconThree,),
                 ],
               ),
               SizedBox(height: 10.h),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomHomeCard(text: "9",title: "Experience",imageSrc: AppIcons.iconTwo,),
                   CustomHomeCard(text: "03",title: "On Going",imageSrc: AppIcons.iconTwo,),
                 ],
               ),
               SizedBox(height: 10.h,),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomText(text: "Recent Service", fontSize: 14.w,fontWeight: FontWeight.w600,color: AppColors.black,),
                   CustomText(text: "See all", fontSize: 14.w,fontWeight: FontWeight.w600,color: AppColors.primary,),
                 ],
               ),
               SizedBox(height: 10.h,),
               Column(
                 children: List.generate(4, (value){
                   return CustomServiceCard();
                 }),
               )
             ],
           ))
          ],
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 0),
    );
  }
}
