import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../components/custom_nav_bar/customer_navbar.dart';
import '../../../contractor_part/profile/profile_screen/widget/custom_profile_menu_list.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Profile",
        rightIcon: AppIcons.editIcon,
        rightOnTap: () {
          Get.toNamed(AppRoutes.editCustomerProfileScreen);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  CustomNetworkImage(
                    imageUrl: AppConstants.profileImage,
                    height: 55,
                    width: 55,
                    boxShape: BoxShape.circle,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Thomas",
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      CustomText(
                        text: "liamksayem@gmail.com",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black_04,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomProfileMenuList(),
              CustomProfileMenuList(image: AppIcons.map, name: "Address"),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.customerNotificationScreen);
                },
                image: AppIcons.notifaction,
                name: "Notification",
              ),
              CustomProfileMenuList(
                  image: AppIcons.settingIcon,
                  name: "Setting"),
              CustomProfileMenuList(
                  onTap: () {
                    Get.toNamed(AppRoutes.customerReferFriendScreen);
                  },
                  image: AppIcons.peopoles,
                  name: "Refer a Friend"),
              CustomProfileMenuList(
                  onTap: () {
                    Get.toNamed(AppRoutes.customerHelpSupportScreen);
                  },
                  image: AppIcons.call,
                  name: "Support"),

              SizedBox(height: 10.h),
              TextButton(
                onPressed: () {},
                child: CustomText(
                  text: "Log Out",
                  fontSize: 20.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 3),
    );
  }
}
