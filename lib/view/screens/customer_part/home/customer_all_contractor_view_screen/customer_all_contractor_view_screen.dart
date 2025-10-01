import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';

import '../customer_home_screen/widget/custom_service_contractor_card.dart';
class CustomerAllContractorViewScreen extends StatelessWidget {
   CustomerAllContractorViewScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    String name = args['name'];
    String id = args['id'];
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "$name Contractors".tr,),
      body: SingleChildScrollView(
        child: Obx(
          () {
            final contractors = homeController.getAllContactorModel.value.data != null
                ? homeController.getAllContactorModel.value.data!
                    .where((contractor) => contractor.subCategory == id)
                    .toList()
                : [];

            if (homeController.getAllServicesContractorStatus.value.isLoading) {
              return Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              );
            }
            if (homeController.getAllServicesContractorStatus.value.isError) {
              return Container(
                margin: EdgeInsets.only(top: 50.h),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(homeController.getAllServicesContractorStatus.value
                        .toString()),
                  ),
                ),
              );
            }
            if (contractors.isEmpty) {
                return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100.h),
                  child: Text("No Contractors Found of $name"),
                ),
                );
            }
            return  GridView.builder(
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
              itemCount: contractors.length,
              itemBuilder: (BuildContext context, int index) {
               // var data = popularDoctorController.popularList[index];
                return CustomServiceContractorCard(
                  image: contractors[index].userId?.img ?? '',
                  name: contractors[index].userId?.fullName ?? '',
                  title: contractors[index].userId?.role ?? '',
                  rating: contractors[index].ratings.toString(),
                  onTap: (){
                    Get.toNamed(AppRoutes.customerContractorProfileViewScreen);
                  },
                );
              },
            );
          }
        )
       
      ),
    );
  }
}
