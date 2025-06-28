import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/screens/customer_part/home/model/customer_category_model.dart';
import 'package:servana/view/screens/customer_part/home/model/single_sub_category_model.dart';
import 'package:servana/view/screens/customer_part/home/model/sub_category_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getCategory();
    getSubCategory();
    super.onInit();
  }

  //======= get Category =======//
  Rx<RxStatus> getCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<CustomerCategoryModel> categoryModel = CustomerCategoryModel().obs;

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

  //======= get Sub Category =======//
  Rx<RxStatus> getSubCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<SubCategorysModel> subCategoryModel = SubCategorysModel().obs;

  Future<void> getSubCategory() async {
    getSubCategoryStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(ApiUrl.subCategories);

      subCategoryModel.value = SubCategorysModel.fromJson(response.body);

      getSubCategoryStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${subCategoryModel.value}');
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
      getSubCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }
  //======= get Sub Category =======//
  Rx<RxStatus> getSingleSubCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<SingleSubCategorysModel> singleSubCategoryModel = SingleSubCategorysModel().obs;
  Future<void> getSingleSubCategory({required String categoryId}) async {
    getSingleSubCategoryStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(ApiUrl.singleSubCategory(categoryId: categoryId));

      singleSubCategoryModel.value = SingleSubCategorysModel.fromJson(response.body);

      getSingleSubCategoryStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${singleSubCategoryModel.value}');
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
      getSingleSubCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }


}
