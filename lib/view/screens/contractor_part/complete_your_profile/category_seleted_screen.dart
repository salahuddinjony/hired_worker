import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/category_selection_controller.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';

class CategorySelectedScreen extends StatefulWidget {
  const CategorySelectedScreen({super.key});

  @override
  State<CategorySelectedScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectedScreen> {
  final List<CategoryItem> categories = [
    CategoryItem('Electrician', Icons.electrical_services),
    CategoryItem('Cleaner', Icons.cleaning_services),
    CategoryItem('Carpentry', Icons.handyman),
    CategoryItem('Outdoor', Icons.fence),
    CategoryItem('Painter', Icons.format_paint),
    CategoryItem('Plumber', Icons.plumbing),
  ];

  String? selectedCategory; // Now only one category can be selected

  void toggleSelection(String title) {
    setState(() {
      if (selectedCategory == title) {
        // If the clicked category is already selected, deselect it
        selectedCategory = null;
      } else {
        // Otherwise, select the new category
        selectedCategory = title;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CategorySelectionController controller =
        Get.find<CategorySelectionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF0E5ED),
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Category".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set up your personal information.".tr,
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              "You can always change it later.".tr,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children:
                    categories.map((item) {
                      final isSelected = selectedCategory == item.title;
                      return GestureDetector(
                        onTap: () => toggleSelection(item.title),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? const Color(0xFF3C003D)
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.icon,
                                size: 32,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                item.title,
                                style: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
            Obx(() {
              return controller.status.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                      controller.updateContractorData(selectedCategory);
                    },
                    title: "Continue".tr,
                  );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class CategoryItem {
  final String title;
  final IconData icon;

  CategoryItem(this.title, this.icon);
}
