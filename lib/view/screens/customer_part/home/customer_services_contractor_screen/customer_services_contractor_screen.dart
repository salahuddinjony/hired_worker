import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/view/components/commot_not_found/not_found.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/model/all_contactor_model.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../customer_home_screen/widget/custom_service_contractor_card.dart';

class CustomerServicesContractorScreen extends StatelessWidget {
  const CustomerServicesContractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Services Contractor".tr,
      ),
      body: Obx(() {
        final categories = homeController.categoryModel.value.data ?? [];
        final contractors = homeController.getAllContactorList;

        if (homeController.getCategoryStatus.value.isLoading ||
            homeController.getAllServicesContractorStatus.value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Padding(
            
            padding: const EdgeInsets.only(left: 16, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Show contractors for each category
                ...categories.map((category) {
                  final categoryWiseContractors =
                      contractors.where((contractor) {
                        if (category.id != contractor.category?.id) {
                          return false;
                        }
                        return true;
                      }).toList();

                  return buildCategorySection(
                    context,
                    "${category.name} Providers",
                    categoryWiseContractors,
                    category.id ?? '',
                    category.name ?? '',
                  );
                }).toList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildCategorySection(
    BuildContext context,
    String title,
    List<allContractor> categoryWiseContractors,
    String categoryId,
    String categoryName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 16.w,
              fontWeight: FontWeight.w600,
              color: AppColors.black_08,
            ),
            if (categoryWiseContractors.isNotEmpty)
              TextButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.customerContractorBasedCategoryListScreen,
                    arguments: {
                      'id': categoryId,
                      'name': categoryName,
                      'contractors': categoryWiseContractors,
                    },
                  );
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
        if (categoryWiseContractors.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: NotFound(
              message: "No contractors available in $title.".tr,
              icon: Icons.search_off,
            ),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  categoryWiseContractors.take(4).map((contractor) {
                    return CustomServiceContractorCard(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.customerContractorProfileViewScreen,
                          arguments: {
                            'id': contractor.userId.id,
                            'contractorDetails': contractor,
                          },
                        );
                      },
                      hourlyPrice: contractor.rateHourly.toString(),
                      image: ImageHandler.imagesHandle(contractor.userId.img),
                      name: contractor.userId.fullName,
                      title: contractor.skillsCategory,
                      rating: contractor.ratings.toString(),
                    );
                  }).toList(),
            ),
          ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
