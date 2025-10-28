import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/model/booking_model.dart';
import 'package:servana/view/screens/contractor_part/home/order_screen/controller/order_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/helper_methods/helper_methods.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import 'widget/custom_delivered_service_card.dart';
import 'widget/custom_service_request_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderController controller = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: CustomRoyelAppbar(leftIcon: false, titleName: "Request".tr),
      body: Obx(() {
        if (controller.commonStatus.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              await controller.callAllMethods();
            },
            child: Column(
              children: [
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
                  Obx(() {
                    return Expanded(
                      child: ListView.builder(
                        controller: controller.pendingScrollController,
                        itemCount:
                            controller.pendingBookingList.length +
                            (controller.statusForPending.value.isLoadingMore
                                ? 1
                                : 0),
                        itemBuilder: (context, index) {
                          if (index < controller.pendingBookingList.length) {
                            final data = controller.pendingBookingList[index];
                            return CustomServiceRequestCard(
                              title: getSubCategoryName(data),
                              rating:
                                  data.contractorId?.contractor?.ratings
                                      ?.toString() ??
                                  ' - ',
                              dateTime: data.updatedAt!,
                              id: data.id!,
                              image: data.subCategoryId?.img,
                              status: data.status,
                              index: index,
                              location: data.location,
                              hourlyRate: data.totalAmount,
                              customerName: data.customerId?.fullName,
                              customerImage: data.customerId?.img,
                              subcategoryName: data.subCategoryId?.name,
                            );
                          } else {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  }),

                if (controller.currentIndex.value == 1)
                  Expanded(
                    child: ListView.builder(
                      controller: controller.completedScrollController,
                      itemCount: controller.completedBookingList.length +
                          (controller.statusForComplete.value.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < controller.completedBookingList.length) {
                          final BookingModelData data = controller.completedBookingList[index];

                          return CustomDeliveredServiceCard(
                            title: getSubCategoryName(data),
                            rating: data.contractorId?.contractor?.ratings?.toString() ?? ' - ',
                            dateTime: data.updatedAt!,
                            price: data.totalAmount.toString(),
                            image: data.subCategoryId?.img,
                            index: index,
                            location: data.location,
                            customerName: data.customerId?.fullName,
                            customerImage: data.customerId?.img,
                            subcategoryName: data.subCategoryId?.name,
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: const Navbar(currentIndex: 1),
    );
  }
}
