// Importing necessary packages and files
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // For responsive design
import 'package:get/get.dart'; // For state management and navigation
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/utils/app_colors/app_colors.dart'; // App color constants
import 'package:servana/utils/app_const/app_const.dart'; // App constants
import 'package:servana/utils/app_icons/app_icons.dart'; // App icons
import 'package:servana/utils/extensions/widget_extension.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/contractor_part/home/controller/contractor_home_controller.dart';
import 'package:servana/view/screens/contractor_part/home/home_screen/widget/custom_service_card.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import '../../../../../core/app_routes/app_routes.dart'; // App navigation routes
import '../../../../../utils/helper_methods/helper_methods.dart';
import '../../../../components/custom_nav_bar/navbar.dart'; // Custom bottom navigation bar
import 'widget/custom_home_card.dart'; // Custom card widget for home screen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the ProfileController instance using GetX
    final ProfileController profileController = Get.find<ProfileController>();
    profileController.getMe();

    final ContractorHomeController controller = Get.find<ContractorHomeController>();

    return Scaffold(
      extendBody: true, // Ensures the body extends behind the navigation bar
      body: Obx(() {
        // Using Obx to reactively update the UI when contractorData changes
        if (controller.status.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (controller.status.value.isError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(controller.status.value.errorMessage!),
                ElevatedButton(
                  onPressed: () {
                    controller.getAllBookings();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.getAllBookings();
              await profileController.getMe();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 70.h),
              child: Column(
                children: [
                  // Header row with welcome message and profile picture
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Welcome text
                              CustomText(
                                text: "Welcome!".tr,
                                // .tr for translation
                                fontSize: 18.w,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black_02,
                                bottom: 2,
                              ),
                              // Contractor's name
                              CustomText(
                                text:
                                    profileController
                                        .contractorModel
                                        .value
                                        .data
                                        ?.fullName ??
                                    " - ",
                                // Fallback to " - " if null
                                fontSize: 15.w,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),

                              // role
                              CustomText(
                                text:
                                    profileController
                                        .contractorModel
                                        .value
                                        .data
                                        ?.role ??
                                    " - ",
                                // Fallback to " - " if null
                                fontSize: 14.w,
                                fontWeight: FontWeight.w400,
                                color: AppColors.black.withValues(alpha: 0.9),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Profile picture - reacts to changes with Obx
                      Obx(() {
                        final data = profileController.contractorModel.value.data;

                        return (data?.img != null)
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
                            );
                      }),
                    ],
                  ),
                  SizedBox(height: 20.h), // Spacer
                  // Main content area with scrollable list
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        // First row of stats cards
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomHomeCard(
                              text:
                                  profileController
                                      .contractorModel
                                      .value
                                      .data
                                      ?.contractor
                                      ?.balance
                                      .toString() ??
                                  " - ",
                              title: "Total Earning this month".tr,
                            ),
                            CustomHomeCard(
                              text:
                                  controller.bookingModel.value.meta?.total
                                      .toString() ??
                                  " - ",
                              title: "Total Service".tr,
                              imageSrc: AppIcons.iconTwo,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // second row of stats cards
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomHomeCard(
                              text: controller.requestedServices.value.toString(),
                              title: "Request Services".tr,
                              imageSrc: AppIcons.iconTwo,
                            ),
                            CustomHomeCard(
                              text:
                                  controller
                                      .bookingModel
                                      .value
                                      .data
                                      ?.length
                                      .toString() ??
                                  " - ",
                              title: "Recent Services".tr,
                              imageSrc: AppIcons.iconTwo,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),

                        // third row of stats cards
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomHomeCard(
                              onTap: () => Get.toNamed(AppRoutes.onGoingScreen),
                              // Navigate to ongoing screen
                              text: controller.onGoingServices.value.toString(),
                              title: "On Going".tr,
                              imageSrc: AppIcons.iconTwo,
                            ),
                          ],
                        ),

                        SizedBox(height: 15.h),

                        // Recent Services section header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: "Recent Service".tr,
                              fontSize: 14.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                            // "See all" link
                            CustomText(
                              text: "See all".tr,
                              fontSize: 14.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ).onTap(() {
                              Get.toNamed(AppRoutes.recentAllServiceScreen);
                            }),
                          ],
                        ),

                        if ((controller.bookingModel.value.data?.length ??
                                0) ==
                            0)
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: const Center(child: Text('No data found')),
                          ),

                        ListView.builder(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 80.0),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              controller
                                  .bookingModel
                                  .value
                                  .data
                                  ?.length ??
                              0,
                          itemBuilder: (context, index) {
                            final BookingModelData data =
                                controller
                                    .bookingModel
                                    .value
                                    .data![index];

                            return CustomServiceCard(
                              title: getSubCategoryName(data),
                              updateDate: data.createdAt ?? DateTime.now(),
                              hourlyRate: data.rateHourly?.toString() ?? ' - ',
                              rating:
                                  data.contractorId?.contractor?.ratings
                                      ?.toString() ??
                                  ' - ',
                              status: data.status ?? 'Unknown',
                              image: data.contractorId?.img,
                            );
                          },
                        ),
                        SizedBox(height: 10.h), // Bottom spacer
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
      // Bottom navigation bar with current index set to 0 (Home)
      bottomNavigationBar: const Navbar(currentIndex: 0),
    );
  }
}
