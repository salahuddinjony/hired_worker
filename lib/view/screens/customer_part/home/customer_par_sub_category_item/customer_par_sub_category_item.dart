import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/commot_not_found/not_found.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../customer_home_screen/widget/custom_popular_services_card.dart';

class CustomerParSubCategoryItem extends StatelessWidget {
  const CustomerParSubCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    final String name = Get.arguments['name'];
    final String id = Get.arguments['id'];
    debugPrint("Sub Category ID: $id");
    debugPrint("Sub Category Name: $name");

    // Listen for scroll events to trigger pagination
    homeController.singleSubCategoryScrollController.addListener(() {
      if (homeController.singleSubCategoryScrollController.position.pixels >=
          homeController.singleSubCategoryScrollController.position.maxScrollExtent - 100 &&
          !homeController.singleSubCategoryIsPaginating.value &&
          homeController.singleSubCategoryHasMoreData.value) {
        homeController.getMoreSingleSubCategory(categoryId: id);
      }
    });

    homeController.getSingleSubCategory(categoryId: id);
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: name),
      body: Obx(() {
        final data = homeController.singleSubCategoryModel.value.data ?? [];
        if (homeController.getSingleSubCategoryStatus.value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (homeController.getSingleSubCategoryStatus.value.isError) {
          return Center(
            child: Text(homeController.getSingleSubCategoryStatus.value
                .toString()),
          );
        }
        if (data.isEmpty) {
          return const NotFound(message: "No Sub Categories Found", icon: Icons.category);
        }
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                controller: homeController.singleSubCategoryScrollController,
                padding: EdgeInsets.only(right: 10.h, left: 20.h),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 8,
                ),
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: data.length + (homeController.singleSubCategoryHasMoreData.value ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index >= data.length) {
                    // Show loading indicator at the end of the list
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomPopularServicesCard(
                    image: data[index].img ?? '',
                    name: data[index].name ?? '',
                    onTap: () {
                        homeController.getAllContactor();
                      Get.toNamed(AppRoutes.customerAllContractorBasedSubCategoryViewScreen,
                          arguments: {
                            'id': data[index].id.toString(), // subcategory id
                            'name': data[index].name.toString()
                          }
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
  }
