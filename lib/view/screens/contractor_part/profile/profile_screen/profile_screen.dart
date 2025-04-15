import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import '../../home/home_screen/widget/custom_home_card.dart';
import 'widget/custom_profile_menu_list.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Profile",rightIcon: AppIcons.editIcon, rightOnTap: (){
        Get.toNamed(AppRoutes.editProfileScreen);
      },),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  CustomNetworkImage(imageUrl: AppConstants.profileImage, height: 55, width: 55, boxShape: BoxShape.circle,),
                  SizedBox(width: 10.w,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: "Thomas", fontSize: 16.w,fontWeight: FontWeight.w500,color: AppColors.black,),
                      CustomText(text: "liamksayem@gmail.com", fontSize: 14.w,fontWeight: FontWeight.w400,color: AppColors.black_04,),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20.h),
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
                  CustomHomeCard(text: "15",title: "Recent Services",imageSrc: AppIcons.iconFour,),
                  CustomHomeCard(text: "\$50/hr",title: "Current billing price",imageSrc: AppIcons.iconThree,),
                ],
              ),
              SizedBox(height: 20.h,),
              CustomProfileMenuList(),
              CustomProfileMenuList(
                image: AppIcons.map,
                name: "Address",
              ),
              CustomProfileMenuList(
                image: AppIcons.notifaction,
                name: "Notification",
              ),
              CustomProfileMenuList(
                name: "Skills",
              ),
              CustomProfileMenuList(
                name: "Materials",
              ),
              CustomProfileMenuList(
                name: "Schedule",
              ),
              CustomProfileMenuList(
                name: "Total Service",
              ),
              CustomProfileMenuList(
                name: "Eran",
              ),
              CustomProfileMenuList(
                name: "Recent Service",
              ),
              CustomProfileMenuList(
                name: "Settings",
              ),
              CustomProfileMenuList(
                name: "Support",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(currentIndex: 3),
    );
  }
}
