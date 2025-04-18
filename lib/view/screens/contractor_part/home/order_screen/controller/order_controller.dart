import 'package:get/get.dart';
import '../../../../../../utils/app_strings/app_strings.dart';

class OrderController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt requestTypeindex = 0.obs;
  RxList<String> nameList = [
    AppStrings.serviceReuest,
    AppStrings.deliveredService,
  ].obs;
}