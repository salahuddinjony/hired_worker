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
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "All Categories".tr),
      body: Obx(() {
        final categorys = homeController.categoryModel.value.data ?? [];

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
              itemCount: categorys.length,
              itemBuilder: (BuildContext context, int index) {
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
              },
            ),
          ],
        );
      }),
    );
  }
}
