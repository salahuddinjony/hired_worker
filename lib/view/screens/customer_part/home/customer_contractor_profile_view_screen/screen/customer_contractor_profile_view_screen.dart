import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
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
    debugPrint("Received contractorDetails: ${contractor.toString()}");
    allContractor? contractorData =
        contractor is allContractor ? contractor : null;
    final String userId =
        args['id']?.toString() ?? contractorData?.userId.id ?? '';
    debugPrint("Received userId: $userId");

    final String receivedSubCategoryId = args['subCategoryId'] ?? '';
    debugPrint("Received subCategoryId: $receivedSubCategoryId");

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
          final String location = contractorData?.location?.address ?? '';
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
          final List<SubCategoryModel> subCategories =
              receivedSubCategoryId.isNotEmpty
                  ? contractorData?.subCategory
                          .where((sub) => sub.id == receivedSubCategoryId)
                          .toList() ??
                      <SubCategoryModel>[]
                  : contractorData?.subCategory ?? <SubCategoryModel>[];
          final scheduleModel = contractorData?.myScheduleId.first;
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
                                              .take(2)
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
                        // Row(
                        //   children: [
                        //     const CustomImage(imageSrc: AppIcons.callCircle),
                        //     SizedBox(width: 12.w),
                        //     const CustomImage(imageSrc: AppIcons.heartMajor),
                        //   ],
                        // ),
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
                                const CustomImage(
                                  imageSrc: AppImages.likeImage,
                                ),
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
                                const CustomImage(
                                  imageSrc: AppImages.clickImage,
                                ),
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
                                  text: "Skills Service".tr,
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.black_08,
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          contractorData?.category?.img ?? '',
                                      imageBuilder:
                                          (context, imageProvider) => Container(
                                            width: 25.w,
                                            height: 25.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                      placeholder:
                                          (context, url) =>
                                              const CircularProgressIndicator(),
                                      errorWidget:
                                          (context, url, error) => Icon(
                                            Icons.category,
                                            size: 16.w,
                                            color: AppColors.black_08,
                                          ),
                                    ),
                                    SizedBox(width: 6.w),
                                    CustomText(
                                      text:
                                          (contractorData
                                                      ?.category
                                                      ?.name
                                                      .isNotEmpty ==
                                                  true)
                                              ? contractorData!.category!.name
                                              : "N/A",
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: const BoxDecoration(
                                  color: AppColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.task_alt,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Select a task".tr,
                                      fontSize: 16.w,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(width: 8.w),
                              // InkWell(
                              //   onTap: () {
                              //     Get.snackbar(
                              //       "How to select".tr,
                              //       "Tap a task card below. Selected task will be highlighted and used for booking."
                              //           .tr,
                              //       snackPosition: SnackPosition.BOTTOM,
                              //       backgroundColor: Colors.black.withValues(
                              //         alpha: .8,
                              //       ),
                              //       colorText: Colors.white,
                              //     );
                              //   },
                              //   borderRadius: BorderRadius.circular(20.r),
                              //   child: Container(
                              //     padding: EdgeInsets.symmetric(
                              //       horizontal: 10.w,
                              //       vertical: 6.h,
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: AppColors.primary.withValues(alpha: .1),
                              //       borderRadius: BorderRadius.circular(20.r),
                              //     ),
                              //     child: Row(
                              //       children: [
                              //         Icon(
                              //           Icons.info_outline,
                              //           color: AppColors.primary,
                              //           size: 16.w,
                              //         ),
                              //         SizedBox(width: 6.w),
                              //         CustomText(
                              //           text: "How".tr,
                              //           fontSize: 12.w,
                              //           fontWeight: FontWeight.w600,
                              //           color: AppColors.primary,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Subcategories List
                    subCategories.isEmpty
                        ? CustomText(
                          text: "No tasks available".tr,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_08,
                          bottom: 10.h,
                        )
                        : SizedBox(
                          height: 125.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: subCategories.length,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            separatorBuilder: (_, __) => SizedBox(width: 12.w),
                            itemBuilder: (context, index) {
                              final sub = subCategories[index];
                              return GestureDetector(
                                onTap: () {
                                  if (!receivedSubCategoryId.isNotEmpty) {
                                    homeController.selectedCategoryId.value =
                                        sub.id;
                                  }
                                },
                                child:
                                    receivedSubCategoryId.isNotEmpty
                                        ? SizedBox(
                                          width: 100.w,
                                          child: Card(
                                            color:
                                                receivedSubCategoryId ==
                                                            sub.id ||
                                                        homeController
                                                                .selectedCategoryId
                                                                .value ==
                                                            sub.id
                                                    ? AppColors.primary
                                                    : AppColors.white,
                                            elevation: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 10.0,
                                                    vertical: 12,
                                                  ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  if (receivedSubCategoryId ==
                                                      sub.id)
                                                    Align(
                                                      alignment:
                                                          Alignment.topRight,
                                                      child: Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        size: 14.w,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  Container(
                                                    width: 40.w,
                                                    height: 40.w,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color:
                                                            receivedSubCategoryId ==
                                                                        sub.id ||
                                                                    homeController
                                                                            .selectedCategoryId
                                                                            .value ==
                                                                        sub.id
                                                                ? AppColors
                                                                    .white
                                                                : AppColors
                                                                    .primary,
                                                        width: 2.w,
                                                      ),
                                                    ),
                                                    child: CircleAvatar(
                                                      radius: 20.w,
                                                      backgroundColor:
                                                          AppColors.black_08,
                                                      backgroundImage:
                                                          sub.img.isNotEmpty
                                                              ? CachedNetworkImageProvider(
                                                                sub.img,
                                                              )
                                                              : null,
                                                      child:
                                                          sub.img.isEmpty
                                                              ? Icon(
                                                                Icons.person,
                                                                size: 24.w,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              )
                                                              : null,
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  CustomText(
                                                    text: sub.name,
                                                    fontSize: 12.w,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        receivedSubCategoryId ==
                                                                    sub.id ||
                                                                homeController
                                                                        .selectedCategoryId
                                                                        .value ==
                                                                    sub.id
                                                            ? AppColors.white
                                                            : AppColors
                                                                .black_08,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        : Obx(
                                          () => SizedBox(
                                            width: 100.w,
                                            child: Card(
                                              color:
                                                  receivedSubCategoryId ==
                                                              sub.id ||
                                                          homeController
                                                                  .selectedCategoryId
                                                                  .value ==
                                                              sub.id
                                                      ? AppColors.primary
                                                      : AppColors.white,
                                              elevation: 1,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 10.0,
                                                      vertical: 12,
                                                    ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    if (receivedSubCategoryId ==
                                                            sub.id ||
                                                        homeController
                                                                .selectedCategoryId
                                                                .value ==
                                                            sub.id)
                                                      Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Icon(
                                                          Icons
                                                              .check_circle_rounded,
                                                          size: 14.w,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    Container(
                                                      width: 40.w,
                                                      height: 40.w,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              receivedSubCategoryId ==
                                                                          sub.id ||
                                                                      homeController
                                                                              .selectedCategoryId
                                                                              .value ==
                                                                          sub.id
                                                                  ? AppColors
                                                                      .white
                                                                  : AppColors
                                                                      .primary,
                                                          width: 2.w,
                                                        ),
                                                      ),
                                                      child: CircleAvatar(
                                                        radius: 20.w,
                                                        backgroundColor:
                                                            AppColors.black_08,
                                                        backgroundImage:
                                                            sub.img.isNotEmpty
                                                                ? CachedNetworkImageProvider(
                                                                  sub.img,
                                                                )
                                                                : null,
                                                        child:
                                                            sub.img.isEmpty
                                                                ? Icon(
                                                                  Icons.person,
                                                                  size: 24.w,
                                                                  color:
                                                                      Colors
                                                                          .white,
                                                                )
                                                                : null,
                                                      ),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    CustomText(
                                                      text: sub.name,
                                                      fontSize: 12.w,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          receivedSubCategoryId ==
                                                                      sub.id ||
                                                                  homeController
                                                                          .selectedCategoryId
                                                                          .value ==
                                                                      sub.id
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .black_08,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                              );
                            },
                          ),
                        ),
                    SizedBox(height: 20.h),

                    CustomButton(
                      onTap: () async {
                        final String subCategoryId =
                            receivedSubCategoryId.isNotEmpty
                                ? receivedSubCategoryId
                                : homeController.selectedCategoryId.value;
                        if (subCategoryId.isEmpty) {
                          EasyLoading.showInfo(
                            "Please select a task to proceed.".tr,
                          );
                          return;
                        }
                        final bool isSuccess = await homeController
                            .getContractorQuestions(
                              subCategoryId: subCategoryId,
                            );
                        debugPrint("Is success: $isSuccess");
                        debugPrint(
                          "Call getContractorQuestions with ID: $subCategoryId",
                        );
                        debugPrint("Subcategory ID: $subCategoryId");

                        if (isSuccess) {
                          debugPrint(
                            "Questions loaded: ${homeController.contractorQuestions.length}",
                          );
                          final List<MaterialsModel> itemsMaterials =
                              contractorData?.materials ?? [];
                          Get.toNamed(
                            AppRoutes.customarQaScreen,
                            arguments: {
                              'contractorId': contractorData?.userId.id,
                              'contractorIdForTimeSlot':
                                  contractorData?.userId.contractor,
                              'subcategoryId': subCategoryId,
                              'materials': itemsMaterials,
                              'questions':
                                  homeController.contractorQuestions.isNotEmpty
                                      ? homeController
                                          .contractorQuestions
                                          .first
                                          .question
                                          .toList()
                                      : [],
                              'hourlyRate': rateHourlyStr,
                              'contractorName': fullName,
                              'categoryName':
                                  contractorData?.skillsCategory ?? "N/A",
                              'subCategoryName':
                                  contractorData?.subCategory.first.name ??
                                  'N/A',
                              'subCategoryImage':
                                  contractorData?.subCategory.first.img ?? '',
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
