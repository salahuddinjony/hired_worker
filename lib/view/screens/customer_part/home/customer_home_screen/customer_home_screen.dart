import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'widget/banner_carousel.dart';
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
        final banners = homeController.bannerList;

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(() {
                          final data =
                              customerProfileController
                                  .customerModel
                                  .value
                                  .data;
                          // Check if an image is selected, if not use the default profile image

                          return (data?.img != null)
                              ? GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.editCustomerProfileScreen,
                                  );
                                },
                                child: CustomNetworkImage(
                                  imageUrl: ImageHandler.imagesHandle(
                                    data?.img,
                                  ),
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
                                Obx(() {
                                  final savedAddresses =
                                      customerProfileController.savedAddresses;
                                  final selectedAddress =
                                      customerProfileController
                                          .getSelectedAddress();

                                  String displayed = "";
                                  if (selectedAddress != null) {
                                    var shortAddress = selectedAddress.address;
                                    if (shortAddress.isNotEmpty) {
                                      final parts =
                                          shortAddress
                                              .split(',')
                                              .map((s) => s.trim())
                                              .toList();
                                      final start =
                                          parts.length > 3
                                              ? parts.length - 3
                                              : 0;
                                      shortAddress =
                                          "${parts.sublist(start).join(', ')} • ${selectedAddress.title}";
                                    }
                                    displayed =
                                        shortAddress.isNotEmpty
                                            ? shortAddress
                                            : (selectedAddress.title.isNotEmpty
                                                ? selectedAddress.title
                                                : "Other");
                                  }

                                  return GestureDetector(
                                    onTap: () {
                                      // open draggable bottom sheet for selection
                                      Get.bottomSheet(
                                        DraggableScrollableSheet(
                                          expand: false,
                                          initialChildSize: 0.45,
                                          minChildSize: 0.25,
                                          maxChildSize: 0.9,
                                          builder: (context, scrollController) {
                                            return Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  // Drag handle
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          vertical: 14.0,
                                                        ),
                                                    child: Center(
                                                      child: Container(
                                                        height: 6.h,
                                                        width: 64.w,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[300],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                12,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16.0,
                                                        ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Select your address'
                                                              .tr,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child: Text(
                                                            'Close'.tr,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: ListView.separated(
                                                      controller:
                                                          scrollController,
                                                      separatorBuilder:
                                                          (_, __) => Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      16.0,
                                                                ),
                                                            child: Divider(
                                                              height: 1,
                                                              color:
                                                                  Colors
                                                                      .grey[300],
                                                            ),
                                                          ),
                                                      itemCount:
                                                          savedAddresses
                                                              .length +
                                                          1,
                                                      itemBuilder: (
                                                        context,
                                                        index,
                                                      ) {
                                                        if (index == 0) {
                                                          return InkWell(
                                                            onTap: () async {
                                                              Get.back();
                                                              await customerProfileController
                                                                  .showAddAddressDialog();
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        16.0,
                                                                    vertical:
                                                                        14.0,
                                                                  ),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                          8.0,
                                                                        ),
                                                                    decoration: BoxDecoration(
                                                                      color: AppColors
                                                                          .primary
                                                                          .withValues(
                                                                            alpha:
                                                                                .12,
                                                                          ),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                            10,
                                                                          ),
                                                                    ),
                                                                    child: const Icon(
                                                                      Icons
                                                                          .add_location_alt_outlined,
                                                                      color:
                                                                          AppColors
                                                                              .primary,
                                                                      size: 20,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 14.w,
                                                                  ),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'Add New Address'
                                                                          .tr,
                                                                      style: TextStyle(
                                                                        fontSize:
                                                                            16.sp,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                        color:
                                                                            AppColors.primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }

                                                        final addr =
                                                            savedAddresses[index -
                                                                1];
                                                        final isSelected =
                                                            addr.isSelected ==
                                                            true;

                                                        return InkWell(
                                                          onTap: () {
                                                            final idx =
                                                                savedAddresses
                                                                    .indexWhere(
                                                                      (a) =>
                                                                          a.id ==
                                                                          addr.id,
                                                                    );
                                                            if (idx != -1) {
                                                              // Select locally and close the sheet immediately
                                                              customerProfileController
                                                                  .selectAddress(
                                                                    idx,
                                                                  );
                                                              Get.back();

                                                              // Fire the network update in background (don't await)
                                                              customerProfileController
                                                                  .updateProfile();
                                                            }
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      16.0,
                                                                  vertical:
                                                                      14.0,
                                                                ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                // Radio outer circle with inner dot when selected
                                                                Container(
                                                                  width: 28,
                                                                  height: 28,
                                                                  decoration: BoxDecoration(
                                                                    shape:
                                                                        BoxShape
                                                                            .circle,
                                                                    border: Border.all(
                                                                      color:
                                                                          isSelected
                                                                              ? AppColors.primary
                                                                              : Colors.grey[350]!,
                                                                      width:
                                                                          2.2,
                                                                    ),
                                                                    color:
                                                                        isSelected
                                                                            ? AppColors.primary.withValues(
                                                                              alpha:
                                                                                  .08,
                                                                            )
                                                                            : Colors.transparent,
                                                                  ),
                                                                  child: Center(
                                                                    child:
                                                                        isSelected
                                                                            ? Container(
                                                                              width:
                                                                                  12,
                                                                              height:
                                                                                  12,
                                                                              decoration: const BoxDecoration(
                                                                                color:
                                                                                    AppColors.primary,
                                                                                shape:
                                                                                    BoxShape.circle,
                                                                              ),
                                                                            )
                                                                            : const SizedBox.shrink(),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 14.w,
                                                                ),
                                                                Expanded(
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        addr.title.isNotEmpty
                                                                            ? addr.title
                                                                            : 'Other',
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              16.sp,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              AppColors.black_08,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            6.h,
                                                                      ),
                                                                      Text(
                                                                        addr.address,
                                                                        style: TextStyle(
                                                                          fontSize:
                                                                              14.sp,
                                                                          color: const Color(
                                                                            0xff7D8796,
                                                                          ),
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                      if (addr
                                                                          .city
                                                                          .isNotEmpty) ...[
                                                                        SizedBox(
                                                                          height:
                                                                              6.h,
                                                                        ),
                                                                        Text(
                                                                          addr.city,
                                                                          style: TextStyle(
                                                                            fontSize:
                                                                                12.sp,
                                                                            color:
                                                                                Colors.grey[600],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                              0.6,
                                          child: Text(
                                            displayed.isNotEmpty
                                                ? displayed
                                                : 'Select Address'.tr,
                                            style: TextStyle(
                                              fontSize: 14.w,
                                              color: const Color(0xff8891AA),
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14,
                                          color: Color(0xff8891AA),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w),
                      child: Obx(() {
                        final notificationCount =
                            customerProfileController.notificationsList.length;
                        return GestureDetector(
                          onTap: () {
                            customerProfileController.getNotifications();
                            Get.toNamed(
                              AppRoutes.customerNotificationScreen,
                              arguments: {
                                'controller': customerProfileController,
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              Icon(
                                Icons.notifications_outlined,
                                size: 28.w,
                                color: AppColors.black,
                              ),
                              if (notificationCount > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          notificationCount > 99 ? 4.w : 5.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 18.w,
                                      minHeight: 18.h,
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text:
                                            notificationCount > 99
                                                ? '99+'
                                                : notificationCount.toString(),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                // Banner carousel for 'top' type banners
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: BannerCarousel(
                    controller: homeController,
                    banners:
                        banners
                            .where(
                              (banner) => banner.type.toLowerCase() == 'top',
                            )
                            .toList(),
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
                      text: "Services".tr,
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
      homeController.getCategoryStatus.value.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: 120.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 10.h),
                itemCount: categorys.length,
                separatorBuilder: (context, index) => SizedBox(width: 8.w),
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
            ),

                // Sub Category Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: "Tasks".tr,
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
                      hourlyPrice: data.rateHourly.toString(),
                      rating: data.ratings.toString(),
                    ); // You can pass `serviceList[index]` if needed
                  },
                ),

                SizedBox(height: 16.h),
                // Banner carousel for 'bottom' type banners
                Builder(
                  builder: (context) {
                    final bottomBanner =
                        banners
                            .where(
                              (banner) => banner.type.toLowerCase() == 'bottom',
                            )
                            .firstOrNull;
                    final String labelName =
                        bottomBanner?.category?.name ??
                        bottomBanner?.subCategory?.name ??
                        '';
                    return GestureDetector(
                      onTap: () {
                        if (bottomBanner != null) {
                          Get.toNamed(
                            AppRoutes.customerParSubCategoryItem,
                            arguments: {
                              'name':
                                  bottomBanner.category?.name ??
                                  bottomBanner.subCategory?.name ??
                                  '',
                              'id':
                                  bottomBanner.category?.id ??
                                  bottomBanner.subCategory?.id ??
                                  '',
                            },
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Center(
                          child:
                              bottomBanner == null
                                  ? const CustomImage(
                                    imageSrc: AppImages.banner,
                                  )
                                  : ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Stack(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: ImageHandler.imagesHandle(
                                            bottomBanner.image,
                                          ),
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                                    height: 135,
                                                    width:
                                                        MediaQuery.sizeOf(
                                                          context,
                                                        ).width,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                          placeholder:
                                              (context, url) => Container(
                                                height: 135,
                                                width:
                                                    MediaQuery.sizeOf(
                                                      context,
                                                    ).width,
                                                color: Colors.grey.withValues(
                                                  alpha: .2,
                                                ),
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                                  Container(
                                                    height: 135,
                                                    width:
                                                        MediaQuery.sizeOf(
                                                          context,
                                                        ).width,
                                                    color: Colors.grey
                                                        .withValues(alpha: .2),
                                                    child: const Icon(
                                                      Icons.error,
                                                    ),
                                                  ),
                                        ),
                                        // if (labelName.isNotEmpty)
                                        //   Positioned(
                                        //     left: 8,
                                        //     bottom: 8,
                                        //     child: Container(
                                        //       padding: EdgeInsets.symmetric(
                                        //         horizontal: 8.w,
                                        //         vertical: 4.h,
                                        //       ),
                                        //       decoration: BoxDecoration(
                                        //         color: Colors.black.withValues(
                                        //           alpha: 0.45,
                                        //         ),
                                        //         borderRadius:
                                        //             BorderRadius.circular(8),
                                        //       ),
                                        //       child: Text(
                                        //         labelName,
                                        //         style: TextStyle(
                                        //           color: Colors.white,
                                        //           fontSize: 12.sp,
                                        //           fontWeight: FontWeight.w600,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //   ),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                    );
                  },
                ),
                // const Padding(
                //   padding: EdgeInsets.only(right: 16.0),
                //   child: Center(child: CustomImage(imageSrc: AppImages.banner)),
                // ),

                // Banner carousel for 'bottom' type banners
                // Padding(
                //   padding: const EdgeInsets.only(right: 16.0),
                //   child: BannerCarousel(controller: homeController, banners: banners.where((banner) => banner.type.toLowerCase() == 'bottom').toList()),
                // ),
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
