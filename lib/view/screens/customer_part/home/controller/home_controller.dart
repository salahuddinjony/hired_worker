import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_strings/app_strings.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/models/contractor_question.dart';
import 'package:servana/view/screens/customer_part/home/model/all_contactor_model.dart';
import 'package:servana/view/screens/customer_part/home/model/contactor_details_model.dart';
import 'package:servana/view/screens/customer_part/home/model/customer_category_model.dart';
import 'package:servana/view/screens/customer_part/home/model/single_sub_category_model.dart';
import 'package:servana/view/screens/customer_part/home/model/sub_category_model.dart';
import 'package:servana/view/screens/customer_part/home/slider/model/banners_model.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getCategory();
    getSubCategory();
    getAllContactor();
    getBanners();
  }

  // PageController for banners and current index observable (used by UI)
  PageController bannerPageController = PageController();
  RxInt currentBannerIndex = 0.obs;
  Timer? bannerTimer;

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.body;
        debugPrint('Raw API response: $data');

        // Parse the response
        final contractorResponse = ContractorResponse.fromJson(data);
        getAllContactorList.value = contractorResponse.data;

        debugPrint(
          'contractor data length: ${getAllContactorList.length} contractors',
        );

        // Debug: Print each contractor's basic info
        for (int i = 0; i < getAllContactorList.length; i++) {
          final contractor = getAllContactorList[i];
          debugPrint(
            'Contractor $i: ${contractor.userId.fullName}, Skills: ${contractor.skillsCategory}',
          );
        }

        getAllServicesContractorStatus.value = RxStatus.success();
        refresh();
        // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      } else {
        getAllServicesContractorStatus.value = RxStatus.error();
        showCustomSnackBar(response.body['message'] ?? " ", isError: true);
      }
    } catch (e) {
      debugPrint('Error in getAllContractor: $e');
      getAllServicesContractorStatus.value = RxStatus.error();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  // get contractor question based on subCategory
  Rx<RxStatus> getContractorQuestionStatus = Rx<RxStatus>(RxStatus.loading());
  RxList<FaqData> contractorQuestions = <FaqData>[].obs;

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
    } finally {
      refresh();
    }
  }

  // get banner for top and bottom
  RxList<BannerItem> bannerList = <BannerItem>[].obs;
  Rx<RxStatus> bannerStatus = Rx<RxStatus>(RxStatus.loading());
  Future<void> getBanners() async {
    try {
      final response = await ApiClient.getData(ApiUrl.getBanners);
      if (response.statusCode == 200) {
        final data = BannersResponse.fromJson(response.body);
        bannerList.value = data.data;
        debugPrint("====> Banners loaded: ${bannerList.length} banners");
        bannerStatus.value = RxStatus.success();
        // start auto sliding from banners when loaded
        startBannerAutoSlide();
      } else {
        bannerStatus.value = RxStatus.error('Failed to load banners');
      }

      debugPrint('Banner Response: ${response.body}');
    } catch (e) {
      bannerStatus.value = RxStatus.error('Error: ${e.toString()}');
      debugPrint('Banner Error: ${e.toString()}');
    } finally {
      bannerStatus.refresh();
    }
  }


// Start the auto sliding of banners
  void startBannerAutoSlide() {
   
    bannerTimer?.cancel();
    if (bannerList.isEmpty) return;

    bannerTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (bannerList.isEmpty) return;
      final next = (currentBannerIndex.value + 1) % bannerList.where((banner) => banner.type.toLowerCase() == 'top').length;
      try {
        bannerPageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        currentBannerIndex.value = next;
      } catch (e) {
        
      }
    });
  }

  @override
  void onClose() {
    bannerTimer?.cancel();
    try {
      bannerPageController.dispose();
    } catch (_) {}
    super.onClose();
  }
}
