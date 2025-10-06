import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/view/components/commot_not_found/not_found.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';

import '../customer_home_screen/widget/custom_service_contractor_card.dart';
class CustomerAllContractorBasedSubCategoryViewScreen extends StatelessWidget {
   CustomerAllContractorBasedSubCategoryViewScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = Get.arguments;
    String name = args?['name'] ?? 'All';
    String id = args?['id'] ?? '';
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "$name Contractors".tr,),
      body: SingleChildScrollView(
        child: Obx(
          () {
            // sub category id wise contractors
            final contractorsWithSubCategory = homeController.getAllContactorList.where((contractor) => contractor.subCategory.id == id).toList();

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
            if (contractorsWithSubCategory.isEmpty) {
                return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100.h), 
                  child: NotFound(message: "No Contractors Found of $name", icon: Icons.manage_accounts),
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
              itemCount: contractorsWithSubCategory.length,
              itemBuilder: (BuildContext context, int index) {
               // var data = popularDoctorController.popularList[index];
                return CustomServiceContractorCard(
                  image: ImageHandler.imagesHandle(contractorsWithSubCategory[index].userId.img),
                  name: contractorsWithSubCategory[index].userId.fullName,
                  title: contractorsWithSubCategory[index].skillsCategory.toString(),
                  rating: contractorsWithSubCategory[index].ratings.toString(),
                  onTap: (){
                    Get.toNamed(
                      AppRoutes.customerContractorProfileViewScreen,
                      arguments: {
                        'id': contractorsWithSubCategory[index].userId.id,
                        'contractorDetails': contractorsWithSubCategory[index],
                      }
                    );
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
