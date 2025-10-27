import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/view/screens/customer_part/home/model/customer_category_model.dart';

class SearchCategoryController extends GetxController {
  
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.empty());
  
  TextEditingController searchController = TextEditingController();
  
  // Observable list to hold search results
  RxList<Datum> searchResults = <Datum>[].obs;
  
  // Loading state
  RxBool isLoading = false.obs;
  
  // Observable search text for reactive UI
  RxString searchText = ''.obs;
  
  // Debounce timer for search optimization
  Timer? _debounce;  @override
  void onInit() {
    super.onInit();
    // Listen to search text changes
    searchController.addListener(_onSearchChanged);
  }

  // Handle search text changes with debounce
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    
    // Update observable search text
    searchText.value = searchController.text.trim();
    
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final searchTerm = searchController.text.trim();
      if (searchTerm.isNotEmpty) {
        searchCategories(searchTerm);
      } else {
        // Clear results when search is empty
        searchResults.clear();
        status.value = RxStatus.empty();
      }
    });
  }

  // API call to search categories
  Future<void> searchCategories(String searchTerm) async {
    try {
      isLoading.value = true;
      status.value = RxStatus.loading();
      final Map <String, String> queryParameters = {
        'searchTerm': searchTerm,
        'limit': '200',
      };
      
      // Make API call with searchTerm as query parameter
      Response response = await ApiClient.getData(
        ApiUrl.categories,
        query: queryParameters,
      );

      if (response.statusCode == 200) {
        // Parse the response body as JSON first
        final responseData = response.body is String 
            ? jsonDecode(response.body) 
            : response.body;
        
        final customerCategoryModel = CustomerCategoryModel.fromJson(responseData);
        
        if (customerCategoryModel.success == true) {
          searchResults.value = customerCategoryModel.data ?? [];
          
          if (searchResults.isEmpty) {
            status.value = RxStatus.empty();
          } else {
            status.value = RxStatus.success();
          }
        } else {
          searchResults.clear();
          status.value = RxStatus.error(customerCategoryModel.message ?? 'Error fetching data');
        }
      } else {
        searchResults.clear();
        status.value = RxStatus.error('Failed to load data');
      }
    } catch (e) {
      searchResults.clear();
      status.value = RxStatus.error(e.toString());
      debugPrint('Error searching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchController.dispose();
    super.onClose();
  }
}