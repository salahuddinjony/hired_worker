import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../customer_home_screen/widget/custom_popular_services_card.dart';
class CustomerParSubCategoryItem extends StatelessWidget {
  const CustomerParSubCategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Electronics",),
      body: Column(
        children: [
          GridView.builder(
            padding: EdgeInsets.only(right: 10.h,left: 20.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 8,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return CustomPopularServicesCard(
                image: AppConstants.electrician,
                name: "Electronics",
                onTap: (){
                  Get.toNamed(AppRoutes.customerAllContractorViewScreen);
                },
              ); // You can pass `serviceList[index]` if needed
            },
          ),
        ],
      ),
    );
  }
}
