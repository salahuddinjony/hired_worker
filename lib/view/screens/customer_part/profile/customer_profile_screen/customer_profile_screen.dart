import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/choose_language/controller/language_controller.dart';
import 'package:servana/view/screens/customer_part/profile/controller/customer_profile_controller.dart';
import '../../../../components/custom_nav_bar/customer_navbar.dart';
import '../../../contractor_part/profile/profile_screen/widget/custom_profile_menu_list.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerProfileController customerProfileController =
        Get.find<CustomerProfileController>();


    final LanguageController languageController =
        Get.find<LanguageController>();


    return Scaffold(
      extendBody: true,

      appBar: CustomRoyelAppbar(
        leftIcon: false,
        titleName: "Profile".tr,
        showRightIcon: true,
        rightIcon: AppIcons.editIcon,
        rightOnTap: () {
          Get.toNamed(AppRoutes.editCustomerProfileScreen);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() {
                    final data =
                        customerProfileController.customerModel.value.data;
                    // Check if an image is selected, if not use the default profile image

                    return customerProfileController.selectedImage.value == null
                        ? (data?.img != null)
                            ? CustomNetworkImage(
                              imageUrl: ImageHandler.imagesHandle(data?.img),
                              height: 55.h,
                              width: 55.w,
                              boxShape: BoxShape.circle,
                            )
                            : CustomNetworkImage(
                              imageUrl: AppConstants.profileImage,
                              height: 55.h,
                              width: 55.w,
                              boxShape: BoxShape.circle,
                            )
                        : Container(
                          height: 55.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                customerProfileController.selectedImage.value!,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                  }),
                  SizedBox(width: 10.w),
                  Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text:
                              customerProfileController
                                  .customerModel
                                  .value
                                  .data
                                  ?.fullName ??
                              "",
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text:
                              customerProfileController
                                  .customerModel
                                  .value
                                  .data
                                  ?.email ??
                              "",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_04,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50.h),
              const CustomProfileMenuList(),
              CustomProfileMenuList(
                image: AppIcons.history,
                name: "History".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.customerRequestHistoryScreen);
                },
              ),
              CustomProfileMenuList(
                onTap: () async{
                
                  Get.toNamed(
                    AppRoutes.customerNotificationScreen,
                    arguments: {
                      'controller': customerProfileController,
                    },
                    );
                  await customerProfileController.getNotifications();
                },
                image: AppIcons.notifaction,
                name: "Notification".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.customerReferFriendScreen);
                },
                image: AppIcons.peopoles,
                name: "Refer a Friend".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.customerHelpSupportScreen);
                },
                image: AppIcons.call,
                name: "Support".tr,
              ),
              CustomProfileMenuList(
                iconData: Icons.info,
                name: "About Us".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.aboutUsScreen);
                },
              ),
              CustomProfileMenuList(
                image: AppIcons.settingIcon,
                name: "Privacy Policy".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.privacyPolicyScreen);
                },
              ),
              CustomProfileMenuList(
                iconData: Icons.article,
                name: "Terms & Conditions".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.termsConditionsScreen);
                },
              ),
              CustomProfileMenuList(
                iconData: Icons.lock,
                name: "Change Password".tr,
                onTap: () {
                  Get.toNamed(AppRoutes.customerChangePasswordScreen);
                },
              ),
              CustomProfileMenuList(
                image: AppIcons.language,
                name:
                    languageController.isChinese.value
                        ? "启用英文"
                        : "Enable Chinese",
                showSwitch: true,
                switchValue: languageController.isChinese.value,
                onSwitchChanged: languageController.toggleLanguage,
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () async {
                  await SharePrefsHelper.logOut();
                  debugPrint("Logged out successfully");
                  Get.offAllNamed(AppRoutes.loginScreen);
                },
                child: CustomText(
                  text: "Log Out".tr,
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
      bottomNavigationBar: const CustomerNavbar(currentIndex: 3),
    );
  }
}
