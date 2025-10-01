import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../customer_home_screen/widget/custom_popular_services_card.dart';

class CustomerParSubCategoryItem extends StatelessWidget {
  const CustomerParSubCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    String name = Get.arguments['name'];
    String id = Get.arguments['id'];
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
          return const Center(
            child: Text("No Sub Categories Found"),
          );
        }
        return Column(
          children: [
            GridView.builder(
              padding: EdgeInsets.only(right: 10.h, left: 20.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomPopularServicesCard(
                  image: data[index].img ?? '',
                  name: data[index].name ?? '',
                  onTap: () {
                      homeController.getAllContactor(
                       
                      );
                    Get.toNamed(AppRoutes.customerAllContractorViewScreen,
                        arguments: {
                          'id': data[index].id.toString(),
                          'name': data[index].name.toString()
                        }
                    
                    );
                  },
                );
              },
            ),
          ],
        );
      }),
    );
  }
}
