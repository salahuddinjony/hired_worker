import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/screens/customer_part/home/model/all_contactor_model.dart';
import 'package:servana/view/screens/customer_part/home/model/contactor_details_model.dart';
import 'package:servana/view/screens/customer_part/home/model/customer_category_model.dart';
import 'package:servana/view/screens/customer_part/home/model/single_sub_category_model.dart';
import 'package:servana/view/screens/customer_part/home/model/sub_category_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getCategory();
    getSubCategory();
    getAllContactor();
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
        // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
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
        // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      }
    } catch (e) {
      getSubCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  //======= get single Sub Category =======//
  Rx<RxStatus> getSingleSubCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<SingleSubCategorysModel> singleSubCategoryModel =
      SingleSubCategorysModel().obs;
  Future<void> getSingleSubCategory({required String categoryId}) async {
    getSingleSubCategoryStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(
        ApiUrl.singleSubCategory(categoryId: categoryId),
      );

      singleSubCategoryModel.value = SingleSubCategorysModel.fromJson(
        response.body,
      );

      getSingleSubCategoryStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${singleSubCategoryModel.value}');
        // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      }
    } catch (e) {
      getSingleSubCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  //======= get All services contractor or[ SubCategory wise Contractors] =======//
  Rx<RxStatus> getAllServicesContractorStatus = Rx<RxStatus>(
    RxStatus.loading(),
  );
  Rx<GetAllContactorModel> getAllContactorModel = GetAllContactorModel().obs;

  Future<void> getAllContactor({String? subCategoryId}) async {

    
    getAllServicesContractorStatus.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(
        ApiUrl.getAllContractors,
        query: {if (subCategoryId != null) 'subCategory': subCategoryId},
      );

      getAllContactorModel.value = GetAllContactorModel.fromJson(response.body);

      getAllServicesContractorStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${getAllContactorModel.value}');
        // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      }
    } catch (e) {
      getAllServicesContractorStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  //============= contactor details ==============
  Rx<RxStatus> getContractorDetailsStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<ContactorDetailsModel> contactorDetailsModel = ContactorDetailsModel().obs;
  Future<void> getContractorDetails({required String userId}) async {
    getContractorDetailsStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(
        ApiUrl.getContractorDetails(userId: userId),
      );
      
      contactorDetailsModel.value = ContactorDetailsModel.fromJson(
        response.body,
      );

      getContractorDetailsStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('contractor details loaded successfully');
        // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      }
    } catch (e) {
      print("====> Error in getContractorDetails: $e");
      getContractorDetailsStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }
}
