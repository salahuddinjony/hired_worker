import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
// ...existing imports...

// ...existing imports...
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
                unselectedLabelColor: Color(0xff6F767E),
                tabs: [
                  Tab(text: 'Request History'.tr),
                  Tab(text: 'Completed History'.tr),
                ],
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: Obx(() {
                  final all = customerOrderController.bookingReportList;
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
                          requests.isEmpty ? dummyRequests() : requests,
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: () async {
                          await customerOrderController.getBookingReport();
                        },
                        child: buildBookingList(
                          completed.isEmpty ? dummyCompleted() : completed,
                        ),
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

  // Dummy data generators
  List<BookingResult> dummyRequests() {
    return List.generate(
      3,
      (i) => BookingResult(
        id: 'R-100${i + 1}',
        customerId: 'C-123',
        contractorId: null,
        subCategoryId: SubCategory(id: 'sc${i + 1}', name: 'House Cleaning'),
        bookingType: 'One Time',
        status: i == 0 ? 'pending' : 'in_progress',
        paymentStatus: 'unpaid',
        questions: [],
        material: [],
        bookingDate: '09 Dec',
        day: 'Tue',
        startTime: '8:00 AM',
        endTime: '9:00 AM',
        duration: 60,
        timeSlots: ['8:00-9:00'],
        price: 50,
        rateHourly: 50,
        files: [],
        isDeleted: false,
        createdAt: '',
        updatedAt: '',
      ),
    );
  }

  List<BookingResult> dummyCompleted() {
    return List.generate(
      2,
      (i) => BookingResult(
        id: 'C-200${i + 1}',
        customerId: 'C-123',
        contractorId: 'Thomas',
        subCategoryId: SubCategory(id: 'scc${i + 1}', name: 'Electrician'),
        bookingType: 'One Time',
        status: 'completed',
        paymentStatus: 'paid',
        questions: [],
        material: [],
        bookingDate: '05 Dec',
        day: 'Fri',
        startTime: '10:00 AM',
        endTime: '12:00 PM',
        duration: 120,
        timeSlots: ['10:00-12:00'],
        price: 120,
        rateHourly: 60,
        files: [],
        isDeleted: false,
        createdAt: '',
        updatedAt: '',
      ),
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
