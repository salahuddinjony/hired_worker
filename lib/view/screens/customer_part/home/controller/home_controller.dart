import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/screens/customer_part/home/model/customer_category_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  Rx<RxStatus> getCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<CustomerCategoryModel> categoryModel = CustomerCategoryModel().obs;

  //======= get Category =======//
  Future<void> getCategory() async {
    getCategoryStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(ApiUrl.categories);

      categoryModel.value = CustomerCategoryModel.fromJson(response.body);

      getCategoryStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${categoryModel.value}');
        showCustomSnackBar(
          response.body['message'] ?? "Login successful",
          isError: false,
        );
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Login Failed",
          isError: false,
        );
      }
    } catch (e) {
      getCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }
}
