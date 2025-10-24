import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/order/widgets/bottom_loader_for_more_data.dart';
import '../controller/customer_order_controller.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import '../model/customer_order_model.dart';
import 'package:servana/view/screens/customer_part/order/widgets/booking_card.dart';

class CustomerRequestHistoryScreen extends StatelessWidget {
  const CustomerRequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customerOrderController = Get.find<CustomerOrderController>();

    return Scaffold(
      extendBody: true,
      appBar: CustomRoyelAppbar(
        leftIcon: false,
        titleName: "Booking Status".tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h),
          TabBar(
            // padding: EdgeInsets.zero,
            // indicatorSize: TabBarIndicatorSize.label,
            // isScrollable: true,
            controller: customerOrderController.tabController,
            dividerColor: Colors.grey,
            labelColor: AppColors.black,
            indicatorColor: AppColors.primary,
            unselectedLabelColor: Color(0xff6F767E),
            labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
            tabs: [
              Tab(text: 'Pending'.tr),
              // Tab(text: 'Accepted'.tr),
              Tab(text: 'On-Going'.tr),
              Tab(text: 'History'.tr),
            ],
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Obx(() {
                if (customerOrderController
                    .getBookingReportStatus
                    .value
                    .isLoading)
                  return const Center(child: CircularProgressIndicator());

                return TabBarView(
                  controller: customerOrderController.tabController,
                  children: [
                    // Pending Tab
                    buildTabContent(customerOrderController, 0),
                    // Accepted Tab
                    // buildTabContent(customerOrderController, 1),
                    // On-Going Tab
                    buildTabContent(customerOrderController, 1),
                    // History Tab (cancelled or confirmed)
                    buildTabContent(customerOrderController, 2),
                  ],
                );
              }),
            ),
          ),
          SizedBox(height: 80.h),
        ],
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 1),
    );
  }

  Widget buildTabContent(CustomerOrderController controller, int tabIndex) {
    return RefreshIndicator(
      onRefresh: () {
        String status;
        switch (tabIndex) {
          case 0:
            status = 'pending';
            break;
          case 1:
            status = 'ongoing';
            break;
          case 2:
            status = ''; // History tab: load these statuses
            break;
          default:
            status = '';
        }
        if (status.isEmpty) {
          return controller.loadAllBookings();
        } else {
          return controller.loadBookingsByStatus(status);
        }
      },
      child: Obx(() {
        List<BookingResult> displayList;

        if (tabIndex == 2) {
          // History tab - show completed, rejected, and history bookings
          displayList =
              controller.bookingReportList.where((booking) {
                final status = (booking.status ?? '').toLowerCase();
                return status == 'completed' ||
                    status == 'rejected' ||
                    status == 'history';
              }).toList();
        } else {
          // For other tabs, show all data from API call (already filtered by status)
          displayList = controller.bookingReportList.toList();
        }

        if (displayList.isEmpty &&
            !controller.getBookingReportStatus.value.isLoading) {
          return ListView(
            children: [
              const SizedBox(height: 40),
              Center(child: Text('No data available'.tr)),
            ],
          );
        }

        return ListView.separated(
          controller: controller.scrollController,
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          itemBuilder: (context, index) {
            // Show loading indicator or no more data message at the bottom
            if (index == displayList.length) {
              return buildBottomWidget(controller);
            }

            final booking = displayList[index];

            return BookingCard(
              booking: booking,
              controller: controller,
              onTap:
                  () => Get.toNamed(
                    AppRoutes.requestHistoryServiceDetailsPage,
                    arguments: booking,
                  ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(height: 8),
          itemCount:
              displayList.length +
              (controller.isPaginating.value || !controller.hasMoreData.value
                  ? 1
                  : 0),
        );
      }),
    );
  }
}
