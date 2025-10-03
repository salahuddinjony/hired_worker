import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/commot_not_found/not_found.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';

import 'widget/custom_review_list.dart';
import 'widget/custom_skills_container.dart';

class CustomerContractorProfileViewScreen extends StatelessWidget {
  const CustomerContractorProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    Map<String, dynamic> args = Get.arguments ?? {};
    String userId = args['id']?.toString() ?? '';

    if (userId.isNotEmpty) {
      homeController.getContractorDetails(userId: userId);
    }

    return Scaffold(
      body: Obx(() {
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

        if (homeController.getContractorDetailsStatus.value.isLoading) {
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

        final data = homeController.contactorDetailsModel.value.data;

        // Handle null data case
        if (data == null) {
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
              const Expanded(
                child: Center(
                  child: NotFound(
                    message: "No contractor Profile available",
                    icon: Icons.person,
                  ),
                ),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomNetworkImage(
              imageUrl:
                  data.user?.img != null && data.user!.img!.isNotEmpty
                      ? ImageHandler.imagesHandle(data.user!.img!)
                      : AppConstants.girlsPhoto,
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: data.user?.fullName ?? "No Name",
                            fontSize: 24.w,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          CustomText(
                            text: data.user?.role ?? "No Role",
                            fontSize: 18.w,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
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
                                text:
                                    data.user?.contractor?.ratings != null
                                        ? data.user!.contractor!.ratings!
                                            .toString()
                                        : "No ratings",
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
                                text: data.totalCompletedOrder.toString(),
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
                                    (data
                                                .user
                                                ?.contractor
                                                ?.experience
                                                ?.isNotEmpty ==
                                            true)
                                        ? data.user!.contractor!.experience!
                                        : "N/A",
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
                          (data.user?.contractor?.skills?.isNotEmpty == true)
                              ? data.user!.contractor!.skills!
                                  .map(
                                    (e) => CustomSkillsContainer(text: e.name),
                                  )
                                  .toList()
                              : [
                                CustomSkillsContainer(text: "No skills listed"),
                              ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.customarQaScreen);
                    },
                    title: "Book".tr,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      top: 20,
                      text: "Available".tr,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      bottom: 8.h,
                    ),
                  ),
                  // Display actual schedule data or fallback message
                  if (data
                          .user
                          ?.contractor
                          ?.myScheduleId
                          ?.schedules
                          ?.isNotEmpty ==
                      true)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          data.user!.contractor!.myScheduleId!.schedules!.map((
                            schedule,
                          ) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                children: [
                                  CustomSkillsContainer(
                                    text: schedule.days ?? "",
                                  ),
                                  SizedBox(width: 8.w),
                                  CustomText(
                                    text: ":",
                                    fontSize: 14.w,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black_08,
                                  ),
                                  SizedBox(width: 8.w),
                                  ...schedule.timeSlots
                                          ?.map(
                                            (timeSlot) => Padding(
                                              padding: EdgeInsets.only(
                                                right: 8.w,
                                              ),
                                              child: CustomSkillsContainer(
                                                text: timeSlot,
                                              ),
                                            ),
                                          )
                                          .toList() ??
                                      [],
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
                      text:
                          (data.user?.contractor?.bio?.isNotEmpty == true)
                              ? data.user!.contractor!.bio!
                              : "No bio available",
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
                    child: CustomText(
                      text: "Review".tr,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                      bottom: 8.h,
                    ),
                  ),
                  Column(
                    children: List.generate(
                      data.reviews?.length == 0 ? 1 : data.reviews!.length,
                      (value) {
                        return CustomReviewList(
                          reviewData:
                              data.reviews != null && data.reviews!.isNotEmpty
                                  ? data.reviews![value]
                                  : null,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
