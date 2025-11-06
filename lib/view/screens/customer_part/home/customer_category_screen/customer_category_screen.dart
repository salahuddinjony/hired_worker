import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';

import '../customer_home_screen/widget/custom_popular_services_card.dart';

class CustomerCategoryScreen extends StatelessWidget {
  const CustomerCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "All Services".tr,
        onLeftIconTap: () {
          homeController.resetCategoryScrollController();
          Get.back();
        },
      ),
      body: SafeArea(
        child: Obx(() {
          final categorys = homeController.categoryModel.value.data ?? [];
          final isInitialLoading = homeController.getCategoryStatus.value.isLoading && (categorys.isEmpty);
          if (isInitialLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Calculate how many empty cells are needed to center the loading indicator
          const int crossAxisCount = 3;
          final int remainder = categorys.length % crossAxisCount;
          int extraCells = 0;
          if (homeController.categoryHasMoreData.value) {
            if (remainder == 1) {
              extraCells = 2; // 1 item + 2 empty cells
            } else if (remainder == 2) {
              extraCells = 1; // 2 items + 1 empty cell
            } else if (remainder == 0) {
              extraCells = 3; // new row for loading indicator
            }
          }
          return GridView.builder(
            controller: homeController.scrollCategoryController,
            padding: EdgeInsets.only(right: 10.h, left: 20.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 8,
            ),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: categorys.length + (homeController.categoryHasMoreData.value ? extraCells : 0),
            itemBuilder: (BuildContext context, int index) {
              if (index < categorys.length) {
                return CustomPopularServicesCard(
                  image: categorys[index].img,
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
              }
              // Add empty cells before the loading indicator to center it
              final int loadingIndicatorIndex = categorys.length + (extraCells ~/ 2);
              if (index == loadingIndicatorIndex) {
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          );
        }),
      ),
    );
  }
}
