import 'package:get/get.dart';

class CustomerOrderController extends GetxController{
  RxInt bookingReportIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  RxList<String> nameList = [
    "Request History",
    "Complete History",
  ].obs;

}