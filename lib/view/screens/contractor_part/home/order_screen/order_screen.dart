import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/helper_methods/helper_methods.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../controller/contractor_home_controller.dart';
import 'widget/custom_delivered_service_card.dart';
import 'widget/custom_service_request_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ContractorHomeController controller = Get.find<ContractorHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Request".tr),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (controller.status.value.isError) {
          return Center(child: Text(controller.status.value.errorMessage!));
        } else {
          return Column(
            children: [
              //========================================= TAB BAR ================================
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: CustomTabBar(
                  tabs: controller.nameList,
                  selectedIndex: controller.currentIndex.value,
                  onTabSelected: (value) {
                    controller.currentIndex.value = value;
                    setState(() {});
                    controller.update();
                  },
                  selectedColor: AppColors.primary,
                  unselectedColor: AppColors.black_04,
                ),
              ),
              SizedBox(height: 20.h),
              if (controller.currentIndex.value == 0)
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.pendingBookingList.value.data!.result!.length,
                    itemBuilder: (context, index) {
                      BookingModelData data =
                          controller.pendingBookingList.value.data!.result![index];
                      return CustomServiceRequestCard(
                        title: getSubCategoryName(data),
                        rating:
                            data.contractorId?.contractor?.ratings
                                ?.toString() ??
                            ' - ',
                        dateTime: data.updatedAt!,
                        id: data.id!,
                        image: data.contractorId?.img,
                      );
                    },
                  ),
                ),

              // if (controller.pendingBookingList.value.data!.result!.isEmpty && controller.currentIndex.value == 0)
              //   SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.8,
              //     child: Center(child: Text('No data found')),
              //   ),

              if (controller.currentIndex.value == 1)
                Expanded(
                  child: Expanded(
                    child: ListView.builder(
                      itemCount:
                          controller.completeBookingList.value.data!.result!.length,
                      itemBuilder: (context, index) {
                        BookingModelData data =
                            controller.completeBookingList.value.data!.result![index];

                        return CustomDeliveredServiceCard(
                          title: getSubCategoryName(data),
                          rating:
                              data.contractorId?.contractor?.ratings
                                  ?.toString() ??
                              ' - ',
                          dateTime: data.updatedAt!,
                          price: data.price.toString(),
                          image: data.contractorId?.img,
                        );
                      },
                    ),
                  ),
                ),

              // if (controller.pendingBookingList.value.data!.result!.isEmpty && controller.currentIndex.value == 1)
              //   SizedBox(
              //     height: MediaQuery.of(context).size.height * 0.8,
              //     child: Center(child: Text('No data found')),
              //   ),
            ],
          );
        }
      }),
      bottomNavigationBar: Navbar(currentIndex: 1),
    );
  }
}
