import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../customer_home_screen/widget/custom_service_contractor_card.dart';
class CustomerServicesContractorScreen extends StatelessWidget {
  const CustomerServicesContractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Services Contractor",),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 30),
          child: Column(
            children: [
              ///Electrician Providers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Electrician Providers",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      //Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    },
                    child: CustomText(
                      text: "View all",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomServiceContractorCard();
                  }),
                ),
              ),
              ///Plumber Providers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Plumber Providers",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      //Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    },
                    child: CustomText(
                      text: "View all",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomServiceContractorCard();
                  }),
                ),
              ),
              ///Carpenter Providers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Carpenter Providers",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      //Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    },
                    child: CustomText(
                      text: "View all",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomServiceContractorCard();
                  }),
                ),
              ),
              ///Painter Providers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Painter Providers",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      //Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    },
                    child: CustomText(
                      text: "View all",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomServiceContractorCard();
                  }),
                ),
              ),
              ///Cleaner Providers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Cleaner Providers",
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black_08,
                  ),
                  TextButton(
                    onPressed: () {
                      //Get.toNamed(AppRoutes.customerServicesContractorScreen);
                    },
                    child: CustomText(
                      text: "View all",
                      fontSize: 16.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(5, (value) {
                    return CustomServiceContractorCard();
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
