import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_button/custom_button.dart';

class CategorySeletedScreen extends StatefulWidget {
  const CategorySeletedScreen({super.key});

  @override
  State<CategorySeletedScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySeletedScreen> {
  final List<CategoryItem> categories = [
    CategoryItem('Electrician', Icons.electrical_services),
    CategoryItem('Cleaner', Icons.cleaning_services),
    CategoryItem('Carpentry', Icons.handyman),
    CategoryItem('Outdoor', Icons.fence),
    CategoryItem('Painter', Icons.format_paint),
    CategoryItem('Plumber', Icons.plumbing),
  ];

  final Set<String> selectedCategories = {};

  void toggleSelection(String title) {
    setState(() {
      if (selectedCategories.contains(title)) {
        selectedCategories.remove(title);
      } else {
        selectedCategories.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0E5ED),
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Category",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Set up your personal information.",
              style: TextStyle(color: Colors.black87),
            ),
            const Text(
              "You can always change it later.",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: categories.map((item) {
                  final isSelected = selectedCategories.contains(item.title);
                  return GestureDetector(
                    onTap: () => toggleSelection(item.title),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF3C003D) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
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
                              color: isSelected ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            CustomButton(
              onTap: () {
                Get.toNamed(AppRoutes.certificateScreen);
                // handle selectedDays if needed
                debugPrint("Selected Categories: $selectedCategories");
              },
              title: "Continue",
            ),
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
