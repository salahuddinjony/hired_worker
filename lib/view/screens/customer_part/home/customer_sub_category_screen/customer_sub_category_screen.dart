import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/customer_home_screen/widget/sub_category_item.dart';

class CustomerSubCategoryScreen extends StatelessWidget {
  const CustomerSubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Sub Categories"),
      body: Obx(() {
        //================ subCategory list ============
        final data = homeController.subCategoryModel.value.data ?? [];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal:  20.w),
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (homeController.getSubCategoryStatus.value.isLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return SubCategoryItem(
                subCategoryName: data[index].name ?? '',
                categoryName: data[index].categoryId?.name ?? '',
              );
            },
          ),
        );
      }),
    );
  }
}
