import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/customer_home_screen/widget/sub_category_item.dart';
import 'package:servana/view/screens/customer_part/profile/controller/customer_profile_controller.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_nav_bar/customer_navbar.dart';
import 'widget/custom_popular_services_card.dart';
import 'widget/custom_service_contractor_card.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final CustomerProfileController customerProfileController =
        Get.find<CustomerProfileController>();
    return Scaffold(
      extendBody: true,
      body: Obx(() {
        final categorys = homeController.categoryModel.value.data ?? [];
        final customerData = customerProfileController.customerModel.value;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 0,
              top: 60.0,
              bottom: 50,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Obx(() {
                      final data =
                          customerProfileController.customerModel.value.data;
                      // Check if an image is selected, if not use the default profile image

                      return (data?.img != null)
                          ? GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.editCustomerProfileScreen);
                            },
                            child: CustomNetworkImage(
                              imageUrl: ImageHandler.imagesHandle(data?.img),
                              height: 55.h,
                              width: 55.w,
                              boxShape: BoxShape.circle,
                            ),
                          )
                          : CustomNetworkImage(
                            imageUrl: AppConstants.profileImage,
                            height: 55.h,
                            width: 55.w,
                            boxShape: BoxShape.circle,
                          );
                    }),

                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "Welcome!".tr,
                          fontSize: 20.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text: customerData.data?.fullName ?? "",
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xff8891AA),
                              size: 20,
                            ),
                            CustomText(
                              text: "38 Chestnut StreetStaunton",
                              fontSize: 14.w,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff8891AA),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CustomNetworkImage(
                    imageUrl: AppConstants.electrician,
                    height: 135,
                    width: MediaQuery.sizeOf(context).width,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.customerSearchResultScreen);
                    },
                    child: Container(
                      height: 55.h,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CustomImage(imageSrc: AppIcons.search),
                                CustomText(
                                  left: 10.w,
                                  text: "Search here.....".tr,
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_04,
                                ),
                              ],
                            ),
                            const CustomImage(imageSrc: AppIcons.filter),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Category Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Category".tr,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black_08,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.customerCategoryScreen);
                      },
                      child: CustomText(
                        text: "View all".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  padding: EdgeInsets.only(right: 10.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 8,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: min(3, categorys.length),
                  itemBuilder: (BuildContext context, int index) {
                    return CustomPopularServicesCard(
                      image: categorys[index].img ?? AppConstants.electrician,
                      name: categorys[index].name,
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.customerParSubCategoryItem,
                          arguments: {
                            'name': categorys[index].name,
                            'id': categorys[index].id,
                          },
                        );
                      },
                    );
                  },
                ),

                // Sub Category Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Sub Category".tr,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black_08,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.customerSubCategoryScreen);
                      },
                      child: CustomText(
                        text: "View all".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),

                const SubCategoryPreviewSection(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Service Contractor".tr,
                      fontSize: 18.w,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black_08,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.customerServicesContractorScreen);
                      },
                      child: CustomText(
                        text: "View all".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  padding: EdgeInsets.only(right: 10.h),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .75,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 8,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: min(4, homeController.getAllContactorList.length),
                  itemBuilder: (BuildContext context, int index) {
                    final data = homeController.getAllContactorList[index];
                    return CustomServiceContractorCard(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.customerContractorProfileViewScreen,
                          arguments: {
                            'id': data.userId.id,
                            'contractorDetails': data,
                          },
                        );
                      },
                      image: ImageHandler.imagesHandle(data.userId.img),
                      name: data.userId.fullName,
                      title: data.skillsCategory,
                      rating: data.ratings.toString(),
                    ); // You can pass `serviceList[index]` if needed
                  },
                ),

                SizedBox(height: 16.h),
                const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Center(child: CustomImage(imageSrc: AppImages.banner)),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: const CustomerNavbar(currentIndex: 0),
    );
  }
}
