import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../customer_home_screen/widget/custom_service_contractor_card.dart';
class CustomerAllContractorViewScreen extends StatelessWidget {
  const CustomerAllContractorViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "All Contractors",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: .75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 14,
              ),
              padding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
               // var data = popularDoctorController.popularList[index];
                return CustomServiceContractorCard(
                  onTap: (){
                    Get.toNamed(AppRoutes.customerContractorProfileViewScreen);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
