import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';

class CustomerOrderController extends GetxController with GetSingleTickerProviderStateMixin {
  RxInt bookingReportIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = ["Request History", "Complete History"].obs;

  RxList<BookingResult> bookingReportList = <BookingResult>[].obs;
  Rx<RxStatus> getBookingReportStatus = RxStatus.success().obs;
  final RxInt rating = 0.obs;
  final TextEditingController reviewTextController = TextEditingController();

  // Pagination variables
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  RxBool hasMoreData = true.obs;
  RxBool isPaginating = false.obs;
  
  // Current tab status for API filtering
  RxString currentStatus = ''.obs;
  
  // TabController for managing tabs
  late TabController tabController;
  final List<String> tabStatuses = ['pending', 'accepted', 'ongoing', 'rejected']; // Last one for "History" tab (all statuses)

  @override
  void onInit() {
    super.onInit();
    
    // Initialize TabController
    tabController = TabController(length: 4, vsync: this);
    
    // Add tab change listener
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        final status = tabStatuses[tabController.index];
        
        if (status.isEmpty) {
          // For "History" tab, load all bookings and filter client-side
          loadAllBookings();
        } else {
          loadBookingsByStatus(status);
        }
      }
    });
    
    scrollController.addListener(_onScroll);
    
    // Load initial data for the first tab (pending)
    loadBookingsByStatus('pending');
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200 &&
        !isPaginating.value &&
        hasMoreData.value) {
      getMoreBookingReport();
    }
  }

  Future<void> getBookingReport({int page = 1, bool isRefresh = false, String? status}) async {
    try {
      if (isRefresh) {
        currentPage = 1;
        hasMoreData.value = true;
        isPaginating.value = false;
        bookingReportList.clear();
      }

      if (page == 1) {
        getBookingReportStatus.value = RxStatus.loading();
      }

      final Map<String, String> queryParams = {
        'page': page.toString(),
        'limit': '10',
      };
      
      // Add status filter if provided
      if (status != null && status.isNotEmpty) {
        queryParams['status'] = status;
      }

      final response = await ApiClient.getData(
        ApiUrl.getAllBookings,
        query: queryParams,
      );

      if (response.statusCode == 200) {
        final bookingReport = CustomerOrderModel.fromJson(response.body);
        final newBookings = bookingReport.data;
        
        if (newBookings.isEmpty) {
          hasMoreData.value = false;
        } else {
          bookingReportList.addAll(newBookings);
          currentPage = page;
        }
        
        getBookingReportStatus.value = RxStatus.success();
      } else {
        getBookingReportStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      getBookingReportStatus.value = RxStatus.error();
      print('Error in getBookingReport: $e');
    } finally {
      isPaginating.value = false;
    }
  }

  // Load more data when scrolling reaches the bottom
  Future<void> getMoreBookingReport() async {
    if (!hasMoreData.value || 
        isPaginating.value || 
        getBookingReportStatus.value.isLoading) {
      return;
    }

    isPaginating.value = true;
    await getBookingReport(page: currentPage + 1, status: currentStatus.value.isNotEmpty ? currentStatus.value : null);
  }

  // Refresh data from the beginning
  Future<void> refreshBookingReport() async {
    await getBookingReport(page: 1, isRefresh: true, status: currentStatus.value.isNotEmpty ? currentStatus.value : null);
  }
  
  // Load bookings by status
  Future<void> loadBookingsByStatus(String status) async {
    currentStatus.value = status;
    await getBookingReport(page: 1, isRefresh: true, status: status);
  }
  
  // Load all bookings (for history tab to show all statuses)
  Future<void> loadAllBookings() async {
    currentStatus.value = '';
    await getBookingReport(page: 1, isRefresh: true);
  }

  Future<bool> submitReview({
    String? contractorId,
    required int rating,
    String? review,
  }) async {
    try {
      final body = {
        // 'contractorId': "68e37eace27dfa0359e49b82",
        'contractorId': contractorId,
        'stars': rating,
        'description': review,
      };
      EasyLoading.show(status: 'Submitting review...');
      final response = await ApiClient.postData(
        ApiUrl.submitReview,
        jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        EasyLoading.showSuccess('Review submitted successfully');
        print('Review submitted successfully');
      } else {
        EasyLoading.showError('Failed to submit review: ${response.body}');
        print('Failed to submit review: ${response.body}');
        return false;
      }
      return true;
    } catch (e) {
      print('Error submitting review: $e');
      return false;
    }
  }

  // Helpers for the review UI
  void setRating(int value) {
    rating.value = value;
  }

  void clearReview() {
    rating.value = 0;
    reviewTextController.clear();
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    reviewTextController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
