import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/choose_language/controller/language_controller.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import '../../home/home_screen/widget/custom_home_card.dart';
import 'widget/custom_profile_menu_list.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final ContractorHomeController homeController =
        Get.find<ContractorHomeController>();
    final LanguageController languageController =
        Get.find<LanguageController>();

    return Scaffold(
      extendBody: true,

      appBar: CustomRoyelAppbar(
        leftIcon: false,
        showRightIcon: true,
        titleName: "Profile".tr,
        rightIcon: AppIcons.editIcon,
        rightOnTap: () {
          Get.toNamed(AppRoutes.editProfileScreen);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Obx(() {
                    final data = profileController.contractorModel.value.data;
                    // Check if an image is selected, if not use the default profile image

                    return profileController.selectedImage.value == null
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
                                profileController.selectedImage.value!,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                  }),

                  SizedBox(width: 10.w),

                  Obx(() {
                    final contractorData =
                        profileController.contractorModel.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: contractorData.data?.fullName ?? " - ",
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text: contractorData.data?.email ?? " - ",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_04,
                        ),
                      ],
                    );
                  }),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHomeCard(
                      text:
                          (profileController
                                  .contractorModel
                                  .value
                                  .data
                                  ?.contractor
                                  ?.balance
                                  .toString() ??
                              " - ") +
                          '\$',
                      title: "Total Earning this month".tr,
                    ),
                    CustomHomeCard(
                      text:
                          homeController.bookingModel.value.meta?.total
                              .toString() ??
                          " - ",
                      title: "Total Service".tr,
                      imageSrc: AppIcons.iconTwo,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.recentAllServiceScreen,
                          arguments: {"showTotalService": true},
                        );
                      },
                    ),
                  ],
                );
              }),
              SizedBox(height: 10.h),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHomeCard(
                      text:
                          homeController.bookingModel.value.data?.length
                              .toString() ??
                          " - ",
                      title: "Recent Services".tr,
                      imageSrc: AppIcons.iconFour,
                      onTap: () {
                        Get.toNamed(AppRoutes.recentAllServiceScreen);
                      },
                    ),
                    CustomHomeCard(
                      text:
                          "\$${profileController.contractorModel.value.data?.contractor?.rateHourly ?? ' - '}/hr",
                      title: "Current billing price".tr,
                      imageSrc: AppIcons.iconThree,
                      onTap:
                          () => Get.toNamed(
                            AppRoutes.chargeScreen,
                            arguments: {
                              'rate': profileController.contractorModel.value.data?.contractor?.rateHourly
                            },
                          ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 20.h),
              // CustomProfileMenuList(),
              GestureDetector(
                onTap: () {
                  profileController.showAddressBottomSheet();
                },
                child: CustomProfileMenuList(
                  image: AppIcons.map,
                  name: "Address".tr,
                ),
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.notificationScreen);
                },
                image: AppIcons.notifaction,
                name: "Notification".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.materialsScreen);
                },
                image: AppIcons.mdiMaterial,
                name: "Materials".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.scheduleScreen);
                },
                image: AppIcons.schedule,
                name: "Schedule".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.subCategoryEditScreen,
                    arguments: {
                      'id':
                          profileController
                              .contractorModel
                              .value
                              .data!
                              .contractor!
                              .category,
                      'service':
                          profileController
                              .contractorModel
                              .value
                              .data!
                              .contractor!
                              .subCategory,
                    },
                  );
                },
                image: AppIcons.totalService,
                name: "Sub Category".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(
                    AppRoutes.skillsEditScreen,
                    arguments: {
                      'skill':
                          profileController
                              .contractorModel
                              .value
                              .data!
                              .contractor!
                              .skills,
                    },
                  );
                },
                image: AppIcons.sklils,
                name: "Skill".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.eranScreen);
                },
                image: AppIcons.eran,
                name: "Eran".tr,
              ),
              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.recentAllServiceScreen);
                },
                image: AppIcons.mdiRecent,
                name: "Recent Services".tr,
              ),

              CustomProfileMenuList(
                onTap: () {
                  Get.toNamed(AppRoutes.helpSupportScreen);
                },
                image: AppIcons.call,
                name: "Support".tr,
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
                        : "Enable Mandarin",
                showSwitch: true,
                switchValue: languageController.isChinese.value,
                onSwitchChanged: languageController.toggleLanguage,
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () async {
                  await SharePrefsHelper.logOut();
                  debugPrint("Logged out successfully");
                  SharePrefsHelper.remove(AppConstants.isLoggedIn);
                  Get.offAllNamed(AppRoutes.loginScreen);
                },
                child: CustomText(
                  text: "Log Out".tr,
                  fontSize: 20.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Navbar(currentIndex: 3),
    );
  }
}
