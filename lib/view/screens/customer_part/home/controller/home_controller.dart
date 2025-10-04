import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/model.dart/contractor_question.dart';
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
  RxList<allContractor> getAllContactorList = <allContractor>[].obs;

  Future<void> getAllContactor({String? subCategoryId}) async {
    getAllServicesContractorStatus.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(
        ApiUrl.getAllContractors,
        query: {if (subCategoryId != null) 'subCategory': subCategoryId},
      );

      getAllServicesContractorStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;
        getAllContactorList.value = ContractorResponse.fromJson(data).data;
        debugPrint(
          'contractor data length: ${getAllContactorList.length} contractors',
        );
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

  // get contractor question based on subCategory
  Rx<RxStatus> getContractorQuestionStatus = Rx<RxStatus>(RxStatus.loading());
  RxList<FaqData> contractorQuestions =
      <FaqData>[
        FaqData(
          id: "1",
          question: ["What is your experience?"],
          subCategory: SubCategory(
            id: "subcat1",
            name: "Plumbing",
            img: "https://example.com/plumbing.png",
          ),
          isDeleted: false,
        ),
      ].obs;

  Future<bool> getContractorQuestions({required String subCategoryId}) async {
    getContractorQuestionStatus.value = RxStatus.loading();
    EasyLoading.show();

    try {
      final response = await ApiClient.getData(
        ApiUrl.getContractorQuestions(subCategoryId: subCategoryId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;
        contractorQuestions.value = FaqResponse.fromJson(data).data;
        getContractorQuestionStatus.value = RxStatus.success();
        debugPrint(
          'Contractor questions loaded successfully: ${contractorQuestions.length} questions',
        );
        return true;
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
        getContractorQuestionStatus.value = RxStatus.error();
        return false;
      }
    } catch (e) {
      getContractorQuestionStatus.value = RxStatus.error();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
      return false;
    } finally {
      EasyLoading.dismiss();
      refresh();
    }
  }

  // // Helper method to get the list of contractors
  // List<contractor_model.Datum> get contractors => getAllContactorModel.value.data ?? [];

  // // Helper method to get contractors by category (if filtering is needed in the future)
  // List<contractor_model.Datum> getContractorsByCategory(String categoryId) {
  //   if (categoryId.isEmpty) return contractors;
  //   // For now, return all contractors since the API doesn't seem to filter by category
  //   // You can implement filtering logic here when the API supports it
  //   return contractors;
  // }

  //============= contactor details ==============
  Rx<RxStatus> getContractorReviewsStatus = Rx<RxStatus>(RxStatus.loading());
  RxList<ReviewData> reviewsData = <ReviewData>[].obs;
  Future<void> getContractorReviews({required String userId}) async {
    getContractorReviewsStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(
        ApiUrl.getReviewas(userId: userId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;
        reviewsData.value =
            ReviewResponse.fromJson(data).data != null
                ? [ReviewResponse.fromJson(data).data!]
                : [];
        debugPrint(
          'contractor reviews data length: ${reviewsData.length} reviews',
        );
        getContractorReviewsStatus.value = RxStatus.success();
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
        getContractorReviewsStatus.value = RxStatus.error();
        refresh();
      }
    } catch (e) {

      print("====> Error in getContractorReviews: $e");
      getContractorReviewsStatus.value = RxStatus.error();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }finally {
      refresh();
    }
  }
}
