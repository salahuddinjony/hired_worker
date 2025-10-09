import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
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
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              TabBar(
                // isScrollable: true,
                // tabAlignment: TabAlignment.center,
                // labelPadding: EdgeInsets.only(left: 8.0, right: 16.0),
                dividerColor: Colors.grey,

                labelColor: AppColors.black,
                indicatorColor: AppColors.primary,
                unselectedLabelColor: Color(0xff6F767E),
                tabs: [
                  Tab(text: 'Pending'.tr),
                  Tab(text: 'Accepted'.tr),
                  Tab(text: 'On-Going'.tr),
                  Tab(text: 'History'.tr),
                ],
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  final all = customerOrderController.bookingReportList;
                  if (customerOrderController
                      .getBookingReportStatus
                      .value
                      .isLoading)
                    return Center(child: CircularProgressIndicator());
                  final pending =
                      all
                          .where(
                            (b) => (b.status ?? '').toLowerCase() == 'pending',
                          )
                          .toList();
                  final accepted =
                      all
                          .where(
                            (b) => (b.status ?? '').toLowerCase() == 'accepted',
                          )
                          .toList();
                  final onGoing =
                      all
                          .where(
                            (b) => (b.status ?? '').toLowerCase() == 'on-going',
                          )
                          .toList();
                  final history =
                      all
                          .where(
                            (b) =>
                                (b.status ?? '').toLowerCase() == 'cancelled' ||
                                (b.status ?? '').toLowerCase() == 'confirmed',
                          )
                          .toList();

                  return TabBarView(
                    children: [
                      // Pending Tab
                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(pending),
                      ),

                      // Accepted Tab
                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(accepted),
                      ),

                      // On-Going Tab 
                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(onGoing),
                      ),
                      // History Tab 

                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(history),
                      ),
                    ],
                  );
                }),
              ),

              SizedBox(height: 80.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 1),
    );
  }

  Widget buildBookingList(List<BookingResult> list) {
    if (list.isEmpty)
      return ListView(
        children: [
          SizedBox(height: 40),
          Center(child: Text('No data available'.tr)),
        ],
      );

    return ListView.separated(
      padding: EdgeInsets.only(top: 8, bottom: 16),
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
      separatorBuilder: (_, __) => SizedBox(height: 8),
      itemCount: list.length,
    );
  }
}
