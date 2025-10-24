import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/model/all_contactor_model.dart';

import '../widgets/profile_header.dart';
import '../widgets/personal_info_card.dart';
import '../widgets/pricing_card.dart';
import '../widgets/skills_list.dart';
import '../widgets/schedule_widget.dart';
import '../widgets/reviews_list.dart';

class CustomerContractorProfileViewScreen extends StatelessWidget {
  const CustomerContractorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final Map<String, dynamic> args = Get.arguments ?? {};

    final dynamic contractor = args['contractorDetails'];
    allContractor? contractorData =
        contractor is allContractor ? contractor : null;
    final String userId = args['id']?.toString() ?? contractorData?.userId.id ?? '';
    debugPrint("Received userId: $userId");

    if (userId.isNotEmpty) {
      if (contractorData == null) {
        try {
          final found = homeController.getAllContactorList.firstWhere(
            (c) => c.userId.id == userId,
          );
          contractorData = found;
        } catch (_) {}
      }

      if (contractorData != null) {
        homeController.getContractorReviews(userId: contractorData.userId.id);
      }
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
                  child: const CustomRoyelAppbar(leftIcon: true),
                ),
                const Expanded(
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

          final String imgUrl =
              contractorData?.userId.img ??
              (reviewUser != null ? (reviewUser['img'] ?? '') : '');
          debugPrint("Image URL for contractor: '$imgUrl'");
          debugPrint("Contractor data exists: ${contractorData != null}");
          debugPrint("Contractor userId.img: '${contractorData?.userId.img}'");
          
          final String fullName =
              contractorData?.userId.fullName ??
              (reviewUser != null ? (reviewUser['fullName'] ?? '') : '');
          final String role =
              contractorData?.userId.role ??
              (reviewUser != null ? (reviewUser['role'] ?? '') : '');
          final String location = contractorData?.location ?? '';
          final String ratingsStr =
              contractorData != null
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
          final scheduleModel = contractorData?.myScheduleId;
          final String bio = contractorData?.bio ?? '';

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(
                imageUrl: imgUrl,
                name: fullName,
                role: role,
                location: location,
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
                            const CustomImage(imageSrc: AppIcons.callCircle),
                            SizedBox(width: 12.w),
                            const CustomImage(imageSrc: AppIcons.heartMajor),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // summary card (rating / completed / experience)
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
                                const CustomImage(imageSrc: AppImages.likeImage),
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
                                const CustomImage(imageSrc: AppImages.clickImage),
                                CustomText(
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
                                const CustomImage(imageSrc: AppImages.manPower),
                                CustomText(
                                  text:
                                      (experience.isNotEmpty
                                          ? (() {
                                            final match = RegExp(
                                              r'\d+',
                                            ).firstMatch(experience);
                                            final years =
                                                match != null
                                                    ? int.tryParse(
                                                          match.group(0) ?? '',
                                                        ) ??
                                                        0
                                                    : 0;
                                            final suffix =
                                                years == 1 ? " yr" : " yrs";
                                            return (years > 0
                                                    ? years.toString()
                                                    : experience) +
                                                suffix;
                                          })()
                                          : "N/A"),
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                  overflow: TextOverflow.clip,
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
                    PersonalInfoCard(
                      dob: dob,
                      gender: gender,
                      city:
                          city
                              .split(',')
                              .reversed
                              .take(2)
                              .toList()
                              .reversed
                              .join(', ')
                              .trim(),
                      language: language,
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
                    PricingCard(hourlyRate: rateHourlyStr),
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
                                  text:
                                      (contractorData != null &&
                                              contractorData
                                                  .skillsCategory
                                                  .isNotEmpty)
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
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: CustomText(
                    //     text: "Skills".tr,
                    //     fontSize: 16.w,
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.black,
                    //     bottom: 8.h,
                    //   ),
                    // ),
                    SkillsList(skills: skills),
                    SizedBox(height: 20.h),

                    CustomButton(
                      onTap: () async {
                        final String subCategoryId =
                            contractorData?.subCategory.id ?? '';
                        if (subCategoryId.isEmpty) {
                          showCustomSnackBar(
                            "Subcategory not available for booking.",
                            isError: true,
                          );
                          return;
                        }
                        final bool isSuccess = await homeController
                            .getContractorQuestions(
                              subCategoryId: subCategoryId,
                            );
                        debugPrint(
                          "Call getContractorQuestions with ID: $subCategoryId",
                        );
                        debugPrint("Subcategory ID: $subCategoryId");

                        if (isSuccess) {
                          final List<MaterialsModel> itemsMaterials =
                              contractorData?.materials ?? [];
                          Get.toNamed(
                            AppRoutes.customarQaScreen,
                            arguments: {
                              'contractorId': contractorData?.userId.id,
                              'contractorIdForTimeSlot': contractorData?.userId.contractor,
                              'subcategoryId': subCategoryId,
                              'materials': itemsMaterials,
                              'questions': homeController.contractorQuestions,
                              'hourlyRate': rateHourlyStr,
                              'contractorName': fullName,
                              'categoryName':
                                  contractorData?.skillsCategory ?? "N/A",
                              'subCategoryName':
                                  contractorData?.subCategory.name ?? 'N/A',
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
                    ScheduleWidget(scheduleModel: scheduleModel),
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
                        final avgRating =
                            homeController.reviewsData.isNotEmpty
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
                                color: Colors.amber.withValues(alpha: .15),
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  color: Colors.amber.withValues(alpha: .3),
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
                    // Only the review list depends on an observable; use ReviewsList wrapper
                    Obx(() {
                      if (homeController
                          .getContractorReviewsStatus
                          .value
                          .isLoading) {
                        return const Center(child: CustomLoader());
                      }
                      return ReviewsList(
                        reviewItems: homeController.reviewsData,
                        isLoading:
                            homeController
                                .getContractorReviewsStatus
                                .value
                                .isLoading,
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
