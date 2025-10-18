import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text_field/custom_text_field.dart';
import 'package:servana/view/screens/customer_part/customer_search_result_screen/search_category_controller.dart';
import 'package:servana/view/screens/customer_part/home/customer_home_screen/widget/custom_popular_services_card.dart';

class CustomerSearchResultScreen extends StatelessWidget {
  CustomerSearchResultScreen({super.key});

  final SearchCategoryController controller = Get.put(SearchCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black_08),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Search Services".tr,
          style: const TextStyle(
            color: AppColors.black_08,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              // Search TextField
              CustomTextField(
                textEditingController: controller.searchController,
                fillColor: AppColors.white,
                hintText: "Search......".tr,
                hintStyle: const TextStyle(color: AppColors.black_08),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomImage(imageSrc: AppIcons.search),
                ),
                suffixIcon: Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }
                  
                  if (controller.searchText.isNotEmpty) {
                    return IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.black_08,
                      ),
                      onPressed: () {
                        controller.searchController.clear();
                        controller.searchText.value = '';
                        controller.searchResults.clear();
                      },
                    );
                  }
                  
                  return const SizedBox.shrink();
                }),
              ),

              const SizedBox(height: 20),

              // Search Results Header
              Obx(() => controller.searchText.isEmpty
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Search Results (${controller.searchResults.length})",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),

              const SizedBox(height: 10),

              // Results List
              Expanded(
                child: Obx(() {
                  // Show empty state when no search
                  if (controller.searchText.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Start typing to search categories".tr,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Show loading indicator
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // Show empty results
                  if (controller.searchResults.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No results found".tr,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Try different keywords".tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Show results
                  return GridView.builder(
                    padding: const EdgeInsets.only(right: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final category = controller.searchResults[index];
                      return CustomPopularServicesCard(
                        image: category.img,
                        name: category.name,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.customerParSubCategoryItem,
                            arguments: {
                              'name': category.name,
                              'id': category.id,
                            },
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
