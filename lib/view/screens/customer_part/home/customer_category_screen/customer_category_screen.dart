import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../customer_home_screen/widget/custom_popular_services_card.dart';
class CustomerCategoryScreen extends StatelessWidget {
  const CustomerCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Categories",),
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
              return CustomPopularServicesCard(); // You can pass `serviceList[index]` if needed
            },
          ),
        ],
      ),
    );
  }
}
