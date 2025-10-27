import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_check.dart';
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
  void resetCategoryScrollController() {
    try {
      scrollCategoryController.dispose();
    } catch (_) {}
    scrollCategoryController = ScrollController();
    scrollCategoryController.addListener(() {
      _onScroll(
        getMoreData: getMoreCategory,
        hasMoreData: categoryHasMoreData.value,
        isPaginating: categoryIsPaginating.value,
        scrollController: scrollCategoryController,
      );
    });
  }

  // PageController for banners and current index observable (used by UI)
  PageController bannerPageController = PageController();

  // Pagination for category
  ScrollController scrollCategoryController = ScrollController();
  int categoryCurrentPage = 1;
  RxBool categoryHasMoreData = true.obs;
  RxBool categoryIsPaginating = false.obs;

  // Pagination for sub-category
  ScrollController scrollSubCategoryController = ScrollController();
  // (Removed duplicate declarations)

  // Pagination for single subcategory
  ScrollController singleSubCategoryScrollController = ScrollController();
  // (Removed duplicate declarations)

  @override
  void onInit() {
    super.onInit();
    getCategory();
    getSubCategory();
    getAllContactor();
    getBanners();

    // Add scroll listener for category pagination
    scrollCategoryController.addListener(() {
      _onScroll(
        getMoreData: getMoreCategory,
        hasMoreData: categoryHasMoreData.value,
        isPaginating: categoryIsPaginating.value,
        scrollController: scrollCategoryController,
      );
    });

    //  Add scroll listener for sub-category pagination
    scrollSubCategoryController.addListener(() {
      _onScroll(
        getMoreData: getMoreSubCategory,
        hasMoreData: subCategoryHasMoreData.value,
        isPaginating: subCategoryIsPaginating.value,
        scrollController: scrollSubCategoryController,
      );
    });

    // Add scroll listener for single sub-category pagination
    singleSubCategoryScrollController.addListener(() {
      _onScroll(
        getMoreData: getMoreSingleSubCategory,
        hasMoreData: singleSubCategoryHasMoreData.value,
        isPaginating: singleSubCategoryIsPaginating.value,
        scrollController: singleSubCategoryScrollController,
      );
    });
  }

  void _onScroll({
    required ScrollController scrollController,
    required isPaginating,
    required bool hasMoreData,
    required Function getMoreData,
  }) {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isPaginating &&
        hasMoreData) {
      getMoreData();
    }
  }

  RxInt currentBannerIndex = 0.obs;
  Timer? bannerTimer;

  //======= get Category =======//
  Rx<RxStatus> getCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<CustomerCategoryModel> categoryModel = CustomerCategoryModel().obs;

  Future<void> getCategory({int page = 1, bool isRefresh = false}) async {
    getCategoryStatus.value = RxStatus.loading();
    try {
      if (isRefresh) {
        categoryCurrentPage = 1;
        categoryHasMoreData.value = true;
        categoryIsPaginating.value = false;
        categoryModel.value.data?.clear();
      }
      if (page == 1) {
        getCategoryStatus.value = RxStatus.loading();
      }
      final Map<String, dynamic> queryParameters = {
        'limit': '18',
        'page': page.toString(),
      };
      final response = await ApiClient.getData(
        ApiUrl.categories,
        query: queryParameters,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newFetchedData =
            CustomerCategoryModel.fromJson(response.body).data ?? [];
        if (page == 1) {
          categoryModel.value = CustomerCategoryModel.fromJson(response.body);
        } else {
          // Append new data to existing list
          if (categoryModel.value.data == null) {
            categoryModel.value.data = newFetchedData;
          } else {
            categoryModel.value.data?.addAll(newFetchedData);
          }
        }
        if (newFetchedData.length < 18) {
          categoryHasMoreData.value = false;
        } else {
          categoryHasMoreData.value = true;
        }
        categoryCurrentPage = page;
        getCategoryStatus.value = RxStatus.success();
      } else {
        getCategoryStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
      }
      refresh();
      debugPrint('category data: ${categoryModel.value}');
      // showCustomSnackBar(response.body['message'] ?? " ", isError: false);
    } catch (e) {
      getCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  // Load more data when scrolling reaches the bottom
  Future<void> getMoreCategory() async {
    if (!categoryHasMoreData.value ||
        categoryIsPaginating.value ||
        getCategoryStatus.value.isLoading) {
      return;
    }
    debugPrint(
      'Loading more category data. for page: ${categoryCurrentPage + 1}',
    );
    categoryIsPaginating.value = true;
    await getCategory(page: categoryCurrentPage + 1);
  }

  // Refresh data from the beginning
  Future<void> refreshCategory() async {
    await getCategory(page: 1, isRefresh: true);
  }

  //======= get Sub Category =======//
  Rx<RxStatus> getSubCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<SubCategorysModel> subCategoryModel = SubCategorysModel().obs;
  int subCategoryCurrentPage = 1;
  RxBool subCategoryHasMoreData = true.obs;
  RxBool subCategoryIsPaginating = false.obs;

  Future<void> getSubCategory({int page = 1, bool isRefresh = false}) async {
    getSubCategoryStatus.value = RxStatus.loading();
    try {
      if (isRefresh) {
        subCategoryCurrentPage = 1;
        subCategoryHasMoreData.value = true;
        subCategoryIsPaginating.value = false;
        subCategoryModel.value.data?.clear();
      }
      final Map<String, dynamic> queryParameters = {
        'limit': '500',
        'page': page.toString(),
      };
      final response = await ApiClient.getData(
        ApiUrl.subCategories,
        query: queryParameters,
      );

      final newFetchedData =
          SubCategorysModel.fromJson(response.body).data ?? [];
      if (page == 1) {
        subCategoryModel.value = SubCategorysModel.fromJson(response.body);
      } else {
        if (subCategoryModel.value.data == null) {
          subCategoryModel.value.data = newFetchedData;
        } else {
          subCategoryModel.value.data?.addAll(newFetchedData);
        }
      }
      if (newFetchedData.length < 500) {
        subCategoryHasMoreData.value = false;
      } else {
        subCategoryHasMoreData.value = true;
      }
      subCategoryCurrentPage = page;
      getSubCategoryStatus.value = RxStatus.success();
      refresh();
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${subCategoryModel.value}');
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      }
    } catch (e) {
      getSubCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  Future<void> getMoreSubCategory() async {
    if (!subCategoryHasMoreData.value ||
        subCategoryIsPaginating.value ||
        getSubCategoryStatus.value.isLoading) {
      return;
    }
    debugPrint(
      'Loading more subcategory data. for page: ${subCategoryCurrentPage + 1}',
    );
    subCategoryIsPaginating.value = true;
    await getSubCategory(page: subCategoryCurrentPage + 1);
    subCategoryIsPaginating.value = false;
  }

  Future<void> refreshSubCategory() async {
    await getSubCategory(page: 1, isRefresh: true);
  }

  //======= get single Sub Category =======//
  Rx<RxStatus> getSingleSubCategoryStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<SingleSubCategorysModel> singleSubCategoryModel =
      SingleSubCategorysModel().obs;
  int singleSubCategoryCurrentPage = 1;
  RxBool singleSubCategoryHasMoreData = true.obs;
  RxBool singleSubCategoryIsPaginating = false.obs;

  Future<void> getSingleSubCategory({
    required String categoryId,
    int page = 1,
    bool isRefresh = false,
  }) async {
    getSingleSubCategoryStatus.value = RxStatus.loading();
    if (isRefresh) {
      singleSubCategoryCurrentPage = 1;
      singleSubCategoryHasMoreData.value = true;
      singleSubCategoryIsPaginating.value = false;
      singleSubCategoryModel.value.data?.clear();
    }
    try {
      final response = await ApiClient.getData(
        ApiUrl.singleSubCategory(categoryId: categoryId),
        query: {'page': page.toString(), 'limit': '500'},
      );

      final newFetchedData =
          SingleSubCategorysModel.fromJson(response.body).data ?? [];
      if (page == 1) {
        singleSubCategoryModel.value = SingleSubCategorysModel.fromJson(
          response.body,
        );
      } else {
        if (singleSubCategoryModel.value.data == null) {
          singleSubCategoryModel.value.data = newFetchedData;
        } else {
          singleSubCategoryModel.value.data?.addAll(newFetchedData);
        }
      }
      if (newFetchedData.length < 500) {
        singleSubCategoryHasMoreData.value = false;
      } else {
        singleSubCategoryHasMoreData.value = true;
      }
      singleSubCategoryCurrentPage = page;
      getSingleSubCategoryStatus.value = RxStatus.success();
      refresh();
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('category data: ${singleSubCategoryModel.value}');
      } else {
        showCustomSnackBar(response.body['message'] ?? " ", isError: false);
      }
    } catch (e) {
      getSingleSubCategoryStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  Future<void> getMoreSingleSubCategory({required String categoryId}) async {
    if (!singleSubCategoryHasMoreData.value ||
        singleSubCategoryIsPaginating.value ||
        getSingleSubCategoryStatus.value.isLoading) {
      return;
    }
    singleSubCategoryIsPaginating.value = true;
    await getSingleSubCategory(
      categoryId: categoryId,
      page: singleSubCategoryCurrentPage + 1,
    );
    singleSubCategoryIsPaginating.value = false;
  }

  Future<void> refreshSingleSubCategory({required String categoryId}) async {
    await getSingleSubCategory(
      categoryId: categoryId,
      page: 1,
      isRefresh: true,
    );
  }

  // (Removed duplicate getMoreSingleSubCategory method)

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
        query: {
          if (subCategoryId != null) 'subCategory': subCategoryId,
          'limit': '1000',
        },
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
        query: {'limit': '500'},
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
      final response = await ApiClient.getData(
        ApiUrl.getBanners,
        query: {'limit': '100'},
      );
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
      final next =
          (currentBannerIndex.value + 1) %
          bannerList
              .where((banner) => banner.type.toLowerCase() == 'top')
              .length;
      try {
        bannerPageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        currentBannerIndex.value = next;
      } catch (e) {}
    });
  }

  @override
  void onClose() {
    bannerTimer?.cancel();
    try {
      bannerPageController.dispose();
      // scrollCategoryController.dispose();
    } catch (_) {}
    super.onClose();
  }
}
