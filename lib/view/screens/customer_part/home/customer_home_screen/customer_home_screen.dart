import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../components/custom_nav_bar/customer_navbar.dart';
import 'widget/custom_popular_services_card.dart';
import 'widget/custom_service_contractor_card.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      body: SingleChildScrollView(
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
                        text: "Welcome!",
                        fontSize: 20.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                      CustomText(
                        text: "Mehedi Bin Ab. Salam",
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Color(0xff8891AA),
                            size: 20,
                          ),
                          CustomText(
                            text: "38 Chestnut StreetStaunton",
                            fontSize: 14.w,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8891AA),
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
                  borderRadius: BorderRadius.only(
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
                    decoration: BoxDecoration(
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
                              CustomImage(imageSrc: AppIcons.search),
                              CustomText(
                                left: 10.w,
                                text: "Search here.....",
                                fontSize: 14.w,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black_04,
                              ),
                            ],
                          ),
                          CustomImage(imageSrc: AppIcons.filter),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Category",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.customerCategoryScreen);
                    },
                    child: CustomText(
                      text: "View all",
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
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return CustomPopularServicesCard(
                    image: AppConstants.electrician,
                    name: "Electronic",
                    onTap: () {
                      Get.toNamed(AppRoutes.customerParSubCategoryItem);
                    },
                  ); // You can pass `serviceList[index]` if needed
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Sub Category",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.customerSubCategoryScreen);
                    },
                    child: CustomText(
                      text: "View all",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              CustomText(
                text: "Electronic",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard(
                      image: AppConstants.electrician,
                      name: "Electronic",
                      onTap: () {
                        Get.toNamed(AppRoutes.customerAllContractorViewScreen);
                      },
                    );
                  }),
                ),
              ),
              CustomText(
                top: 10.h,
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
                    return CustomPopularServicesCard(
                      image: AppConstants.electrician,
                      name: "Cleaning",
                      onTap: () {
                        Get.toNamed(AppRoutes.customerAllContractorViewScreen);
                      },
                    );
                  }),
                ),
              ),
              CustomText(
                top: 10.h,
                text: "Plumbing",
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black_08,
                bottom: 10.h,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomPopularServicesCard(
                      image: AppConstants.electrician,
                      name: "Cleaning",
                      onTap: () {
                        Get.toNamed(AppRoutes.customerAllContractorViewScreen);
                      },
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Service Contractor",
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    },
                    child: CustomText(
                      text: "View all",
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
                  childAspectRatio: .80,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 8,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return CustomServiceContractorCard(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.customerContractorProfileViewScreen,
                      );
                    },
                    image: AppConstants.profileImage,
                    name: "Mehedi",
                    title: "Electrician",
                  ); // You can pass `serviceList[index]` if needed
                },
              ),

              SizedBox(height: 16.h),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CustomImage(imageSrc: AppImages.banner),
              ),
              /* SingleChildScrollView(
               scrollDirection: Axis.horizontal,
               child: Row(
                 children: [
                   CustomGetCard(bkColor: Color(0xffEAF6EF),),
                   CustomGetCard(),
                 ],
               ),
             )*/
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 0),
    );
  }
}
