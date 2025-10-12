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
        titleName: "History Status".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              TabBar(
                labelColor: AppColors.black,
                indicatorColor: AppColors.primary,
                unselectedLabelColor: const Color(0xff6F767E),
                tabs: [
                  Tab(text: 'Request History'.tr),
                  Tab(text: 'Completed History'.tr),
                ],
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  final all = customerOrderController.bookingReportList;
                  if(customerOrderController.getBookingReportStatus.value.isLoading)
                    return const Center(child: CircularProgressIndicator());
                  final completed =
                      all
                          .where(
                            (b) =>
                                (b.status ?? '').toLowerCase() == 'completed',
                          )
                          .toList();
                  final requests =
                      all
                          .where(
                            (b) =>
                                (b.status ?? '').toLowerCase() != 'completed',
                          )
                          .toList();

                  return TabBarView(
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(
                       requests,
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(
                          completed,
                        ),
                      ),
                    ],
                  );
                }),
              ),

                return TabBarView(
                  controller: customerOrderController.tabController,
                  children: [
                    // Pending Tab
                    buildTabContent(customerOrderController, 0),
                    // Accepted Tab  
                    buildTabContent(customerOrderController, 1),
                    // On-Going Tab
                    buildTabContent(customerOrderController, 2),
                    // History Tab (cancelled or confirmed)
                    buildTabContent(customerOrderController, 3),
                  ],
                );
              }),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
      bottomNavigationBar: const CustomerNavbar(currentIndex: 1),
    );
  }

  Widget buildTabContent(
    CustomerOrderController controller,
    int tabIndex,
  ) {
    return RefreshIndicator(
      onRefresh: () {
        String status;
        switch (tabIndex) {
          case 0:
            status = 'pending';
            break;
          case 1:
            status = 'accepted';
            break;
          case 2:
            status = 'on-going';
            break;
          case 3:
            status = ''; // For History tab, load all
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
        
        if (tabIndex == 3) {
          // History tab - show cancelled and confirmed bookings
          displayList = controller.bookingReportList.where((booking) {
            final status = (booking.status ?? '').toLowerCase();
            return status == 'rejected' || status == 'confirmed';
          }).toList();
        } else {
          // For other tabs, show all data from API call (already filtered by status)
          displayList = controller.bookingReportList.toList();
        }

        if (displayList.isEmpty &&
            !controller.getBookingReportStatus.value.isLoading) {
          return ListView(
            children: [
              SizedBox(height: 40),
              Center(child: Text('No data available'.tr)),
            ],
          );
        }

        return ListView.separated(
          controller: controller.scrollController,
          padding: EdgeInsets.only(top: 8, bottom: 16),
          itemBuilder: (context, index) {
            // Show loading indicator or no more data message at the bottom
            if (index == displayList.length) {
              return buildBottomWidget(controller);
            }

  Widget buildBookingList(List<BookingResult> list) {
    if (list.isEmpty)
      return ListView(
        children: [
          const SizedBox(height: 40),
          Center(child: Text('No data available'.tr)),
        ],
      );

    return ListView.separated(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemBuilder: (context, index) {
        final booking = list[index];
        return BookingCard(
          booking: booking,
          onTap:
              () => Get.toNamed(
                AppRoutes.requestHistoryServiceDetailsPage,
                arguments: booking,
              ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: list.length,
    );
  }
}
