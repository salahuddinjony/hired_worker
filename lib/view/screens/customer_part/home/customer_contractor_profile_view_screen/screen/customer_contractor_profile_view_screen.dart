import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
// import 'package:servana/helper/image_handelar/image_handelar.dart'; // unused
import 'package:servana/utils/app_colors/app_colors.dart';
// import 'package:servana/utils/app_const/app_const.dart'; // unused
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
// import 'package:servana/view/components/commot_not_found/not_found.dart'; // unused
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/model/all_contactor_model.dart';

import '../widget/custom_review_list.dart';
import '../widget/custom_skills_container.dart';

class CustomerContractorProfileViewScreen extends StatelessWidget {
  const CustomerContractorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
  Map<String, dynamic> args = Get.arguments ?? {};
  // Attempt to read provided contractor details; it may be null when only id is passed
  final dynamic maybeContractor = args['contractorDetails'];
  allContractor? contractorData =
    maybeContractor is allContractor ? maybeContractor : null;
  String userId = args['id']?.toString() ?? contractorData?.userId.id ?? '';
    debugPrint(
      "Received userId: $userId",
    );

    if (userId.isNotEmpty) {
      // If we don't have full contractor data, try to find it in controller cached list
      if (contractorData == null) {
        try {
          final found = homeController.getAllContactorList
              .firstWhere((c) => c.userId.id == userId);
          contractorData = found;
        } catch (_) {
          // not found in cached list
        }
      }

      // Fetch reviews regardless; controller handles loading state
      homeController.getContractorReviews(userId: userId);
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          // Handle case where userId is empty
          if (userId.isEmpty) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 3,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: CustomRoyelAppbar(leftIcon: true),
                ),
                Expanded(
                  child: Center(
                    child: CustomText(
                      text: "Invalid contractor ID",
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            );
          }
          final bool reviewsLoading =
              homeController.getContractorReviewsStatus.value ==
              RxStatus.loading();
          final dynamic reviewUserRaw =
              homeController.reviewsData.isNotEmpty
                  ? homeController.reviewsData[0].user
                  : null;
          final Map<String, dynamic>? reviewUser =
              reviewUserRaw is Map<String, dynamic>
                  ? reviewUserRaw
                  : (reviewUserRaw != null
                      ? Map<String, dynamic>.from(reviewUserRaw)
                      : null);

          // If we don't have contractorData yet and reviews are still loading, show loader
          if (contractorData == null && reviewsLoading && reviewUser == null) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height / 3,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: CustomRoyelAppbar(leftIcon: true),
                ),
                const Expanded(child: Center(child: CustomLoader())),
              ],
            );
          }

      // Build a set of safe local values used across the widget. Prefer contractorData
      // but fall back to values inside the `reviewUser` map when available.
      final String imgUrl = contractorData?.userId.img ??
        (reviewUser != null ? (reviewUser['img'] ?? '') : '');
      final String fullName = contractorData?.userId.fullName ??
        (reviewUser != null ? (reviewUser['fullName'] ?? '') : '');
      final String role = contractorData?.userId.role ??
        (reviewUser != null ? (reviewUser['role'] ?? '') : '');
      final String location = contractorData?.location ?? '';
      final String ratingsStr = contractorData != null
          ? contractorData.ratings.toString()
          : (homeController.reviewsData.isNotEmpty
              ? homeController.reviewsData[0].averageRating
              : '0.0');
      final String experience = contractorData?.experience ?? '';
      final String dob = contractorData?.dob ?? '';
      final String gender = contractorData?.gender ?? '';
      final String city = contractorData?.city ?? '';
      final String language = contractorData?.language ?? '';
      final String rateHourlyStr =
        contractorData?.rateHourly.toString() ?? '';
      final List<String> skills = contractorData?.skills ?? <String>[];
      final itemsMaterials = contractorData?.materials ?? [];
      final scheduleModel = contractorData?.myScheduleId;
      final String bio = contractorData?.bio ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl: imgUrl,
                height: MediaQuery.sizeOf(context).height / 3,
                width: MediaQuery.sizeOf(context).width,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
                child: CustomRoyelAppbar(leftIcon: true),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 20.h,
                  ),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: fullName,
                              fontSize: 24.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            CustomText(
                              text: role,
                              fontSize: 18.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16.w,
                                  color: AppColors.black_08,
                                ),
                                SizedBox(width: 6.w),
                                CustomText(
                                  text:
                                      (location.isNotEmpty
                                          ? location
                                              .split(",")
                                              .reversed
                                              .take(3)
                                              .toList()
                                              .reversed
                                              .join(", ")
                                              .trim()
                                          : "No address"),
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_08,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomImage(imageSrc: AppIcons.callCircle),
                            SizedBox(width: 12.w),
                            CustomImage(imageSrc: AppIcons.heartMajor),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Card(
                      color: AppColors.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomImage(imageSrc: AppImages.likeImage),
                                CustomText(
                                  text: ratingsStr,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                CustomText(
                                  text: "Rating".tr,
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomImage(imageSrc: AppImages.clickImage),
                                CustomText(
                                  // totalCompletedOrder might not be present on allContractor
                                  text: '0',
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                CustomText(
                                  text: "Completed ".tr,
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomImage(imageSrc: AppImages.manPower),
                                CustomText(
                                  text:
                                      (experience.isNotEmpty
                                          ? experience
                                          : "N/A"),
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                CustomText(
                                  text: "Experience".tr,
                                  fontSize: 10.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Personal Information Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: "Personal Information".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        bottom: 8.h,
                      ),
                    ),
                    Card(
                      color: AppColors.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 15,
                        ),
                        child: Column(
                          children: [
                            // Date of Birth
                            Row(
                              children: [
                                Icon(
                                  Icons.cake,
                                  size: 20.w,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Date of Birth".tr,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_08,
                                    ),
                                    CustomText(
                                      text: (dob.isNotEmpty ? dob : "N/A"),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Divider(
                                color: AppColors.black_08.withValues(alpha: .3),
                                height: 1,
                              ),
                            ),

                            // Gender
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  size: 20.w,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Gender".tr,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_08,
                                    ),
                                    CustomText(
                                      text:
                                          (gender.isNotEmpty ? gender : "N/A"),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Divider(
                                color: AppColors.black_08.withValues(alpha: .3),
                                height: 1,
                              ),
                            ),

                            // City
                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  size: 20.w,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "City".tr,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_08,
                                    ),
                                    CustomText(
                                      text:
                                          (city.isNotEmpty
                                              ? city
                                              : "No city specified"),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              child: Divider(
                                color: AppColors.black_08.withValues(alpha: .3),
                                height: 1,
                              ),
                            ),

                            // Language
                            Row(
                              children: [
                                Icon(
                                  Icons.language,
                                  size: 20.w,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Language".tr,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_08,
                                    ),
                                    CustomText(
                                      text:
                                          (language.isNotEmpty
                                              ? language
                                              : "No language specified"),
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: "Pricing & Rates".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        bottom: 8.h,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: .05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with icon
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: .1,
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(
                                    Icons.monetization_on,
                                    size: 20.w,
                                    color: AppColors.primary,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                CustomText(
                                  text: "Hourly Rate".tr,
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black_08,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),

                            // Main rate display
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        CustomText(
                                          text: "\$",
                                          fontSize: 20.w,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                        ),
                                        CustomText(
                                          text: rateHourlyStr,
                                          fontSize: 32.w,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                        ),
                                        CustomText(
                                          text: "/hr",
                                          fontSize: 16.w,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black_08,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    CustomText(
                                      text: "Professional Rate".tr,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_08,
                                    ),
                                  ],
                                ),

                                // Rate status badge
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 6.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: Colors.green.withValues(
                                        alpha: 0.3,
                                      ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.verified,
                                        size: 14.w,
                                        color: Colors.green,
                                      ),
                                      SizedBox(width: 4.w),
                                      CustomText(
                                        text: "Competitive".tr,
                                        fontSize: 11.w,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.green,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 16.h),

                            // Additional rate info
                            Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.05,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 16.w,
                                    color: AppColors.primary,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: CustomText(
                                      text:
                                          "Rate includes all basic tools and materials"
                                              .tr,
                                      fontSize: 12.w,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black_08,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Skills Category
                    Card(
                      color: AppColors.white,
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 12,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.category,
                              size: 20.w,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Skills Category".tr,
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_08,
                                ),
                                CustomText(
                                  text: (contractorData != null && contractorData.skillsCategory.isNotEmpty)
                                      ? contractorData.skillsCategory
                                      : "Home Repair & Maintenance",
                                  fontSize: 14.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    // Individual Skills
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: "Skills".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        bottom: 8.h,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            (skills.isNotEmpty
                                ? skills
                                    .map((e) => CustomSkillsContainer(text: e))
                                    .toList()
                                : [
                                  CustomSkillsContainer(
                                    text: "No skills listed",
                                  ),
                                ]),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      onTap: () async{
                        String subCategoryId = contractorData?.subCategory.id ?? '';
                        if (subCategoryId.isEmpty) {
                          showCustomSnackBar(
                            "Subcategory not available for booking.",
                            isError: true,
                          );
                          return;
                        }
                        bool isSuccess = await homeController.getContractorQuestions(
                          subCategoryId: subCategoryId,
                        );
                        debugPrint(
                          "Call getContractorQuestions with ID: $subCategoryId",
                        );
                        debugPrint("Subcategory ID: $subCategoryId");

                        if (isSuccess) {
                          // Convert contractor `materials` (which use a different
                          // MaterialModel type) into simple Maps so the QA/material
                          // screens (and booking controller) can consume them
                          // without runtime type conflicts between libraries.
                          final materialMaps = itemsMaterials.map((m) {
                            // If `m` is already a Map (raw JSON), read expected keys
                            if (m is Map<String, dynamic>) {
                              final map = m as Map<String, dynamic>;
                              return {
                                'name': (map['name'] ?? '').toString(),
                                'unit': (map['unit'] ?? '').toString(),
                                'price': (map['price'] ?? 0),
                                '_id': (map['_id'] ?? map['id'] ?? '').toString(),
                              };
                            }

                            // If `m` is an instance of MaterialModel from contractor model
                            try {
                              final name = (m as dynamic).name?.toString() ?? '';
                              final unit = (m as dynamic).unit?.toString() ?? '';
                              final price = (m as dynamic).price ?? 0;
                              final id = (m as dynamic)._id ?? (m as dynamic).id ?? '';
                              return {
                                'name': name,
                                'unit': unit,
                                'price': price,
                                '_id': id?.toString() ?? '',
                              };
                            } catch (_) {
                              // Fallback: stringify the object
                              return {
                                'name': m.toString(),
                                'unit': '0',
                                'price': 0,
                                '_id': '',
                              };
                            }
                          }).toList();

                          Get.toNamed(
                            AppRoutes.customarQaScreen,
                            arguments: {
                              'contractorId': userId,
                              'subcategoryId': subCategoryId,
                              'materials': materialMaps,
                              'questions': homeController.contractorQuestions,
                              'hourlyRate': rateHourlyStr,
                            },
                          );
                        
                        } else {
                          showCustomSnackBar(
                            "Failed to load questions. Please try again.",
                            isError: true,
                          );
                        }
                      },
                      title: "Book".tr,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        top: 20,
                        text: "Available Slots".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        bottom: 8.h,
                      ),
                    ),
                    // Display actual schedule data or fallback message
                    if (scheduleModel != null &&
                        scheduleModel.schedules.isNotEmpty == true)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            scheduleModel.schedules.map((schedule) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  children: [
                                    CustomSkillsContainer(text: schedule.days),
                                    SizedBox(width: 8.w),
                                    CustomText(
                                      text: ":",
                                      fontSize: 14.w,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black_08,
                                    ),
                                    SizedBox(width: 8.w),
                                    ...schedule.timeSlots
                                        .map(
                                          (timeSlot) => Padding(
                                            padding: EdgeInsets.only(
                                              right: 8.w,
                                            ),
                                            child: CustomSkillsContainer(
                                              text: timeSlot,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              );
                            }).toList(),
                      )
                    else
                      Row(
                        children: [
                          CustomSkillsContainer(text: "No schedule"),
                          CustomText(
                            text: "available",
                            fontSize: 14.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black_08,
                            left: 6,
                          ),
                        ],
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        top: 20,
                        text: "Bio".tr,
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        bottom: 8.h,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: (bio.isNotEmpty ? bio : "No bio available"),
                        fontSize: 14.w,
                        fontWeight: FontWeight.w400,
                        maxLines: 10,
                        textAlign: TextAlign.start,
                        color: AppColors.black,
                        bottom: 10.h,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Obx(() {
                        final reviewsCount =
                            homeController.reviewsData.isNotEmpty
                                ? homeController.reviewsData[0].reviews.length
                                : 0;
            final avgRating = homeController.reviewsData.isNotEmpty
              ? homeController.reviewsData[0].averageRating
              : '0.0';
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amber.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.amber.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "Rating($reviewsCount) ".tr,
                                    style: TextStyle(
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber[800] ?? Colors.amber,
                                    size: 18.w,
                                  ),
                                  SizedBox(width: 6.w),
                                  CustomText(
                                    text: avgRating.toString(),
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.amber[800] ?? Colors.amber,
                                  ),
                                  SizedBox(width: 6.w),
                                  CustomText(
                                    text: "Avg Rating".tr,
                                    fontSize: 13.w,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.amber[800] ?? Colors.amber,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.w),
                          ],
                        );
                      }),
                    ),
                    SizedBox(height: 12.h),
                    // Only the review list depends on an observable; wrap it in Obx
                    Obx(() {
                      final reviewsWrapper = homeController.reviewsData;
                      // show loader while loading
                      if (homeController
                          .getContractorReviewsStatus
                          .value
                          .isLoading) {
                        return const Center(child: CustomLoader());
                      }

                      // No wrapper data at all
                      if (reviewsWrapper.isEmpty) {
                        return Center(
                          child: Text(
                            "No reviews available".tr,
                            style: TextStyle(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_08,
                            ),
                          ),
                        );
                      }

                      // The API stores the actual review list inside the first ReviewData.reviews
                      final outer = reviewsWrapper.first;
                      final innerReviews = outer.reviews;

                      if (innerReviews.isEmpty) {
                        return Center(
                          child: Text(
                            "No reviews available".tr,
                            style: TextStyle(
                              fontSize: 16.w,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black_08,
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: List.generate(
                          innerReviews.length,
                          (index) =>
                              CustomReviewList(reviewData: innerReviews[index]),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
