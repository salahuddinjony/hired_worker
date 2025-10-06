import 'package:get/get.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/view/screens/customer_part/order/model/customer_order_model.dart';

class CustomerOrderController extends GetxController{
  RxInt bookingReportIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    "Request History",
    "Complete History",
  ].obs;

RxList<BookingResult> bookingReportList = <BookingResult>[].obs;
Rx<RxStatus> getBookingReportStatus = RxStatus.success().obs;

  @override
  void onInit() {
    super.onInit();
    // automatically fetch bookings when controller is initialized
    getBookingReport();
  }

Future<void> getBookingReport() async {
  try {
    getBookingReportStatus.value = RxStatus.loading();
    final response = await ApiClient.getData(ApiUrl.getAllBookings);
    if (response.statusCode == 200) {

      final bookingReport = CustomerOrderModel.fromJson(response.body);
      // bookingReport.data is BookingData which contains result: List<BookingResult>
      bookingReportList.value = bookingReport.data?.result ?? [];
      getBookingReportStatus.value = RxStatus.success();

    } else {
      getBookingReportStatus.value = RxStatus.error();
      ApiChecker.checkApi(response);
    }


  // no-op: status already set above
  } catch (e) {
    getBookingReportStatus.value = RxStatus.error();
    print('Error in getBookingReport: $e');
  }finally {
    // getBookingReportStatus.value = RxStatus.success();
  }
}



}