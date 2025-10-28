import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

import '../../../../utils/app_colors/app_colors.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import 'controller/sub_category_selection_controller.dart';

class SubCategorySelectedScreen extends StatefulWidget {
  const SubCategorySelectedScreen({super.key});

  @override
  State<SubCategorySelectedScreen> createState() =>
      _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<SubCategorySelectedScreen> {
  final List<String> selectedSubCategoryIds = [];

  void toggleSelection(String id) {
    setState(() {
      if (selectedSubCategoryIds.contains(id)) {
        selectedSubCategoryIds.remove(id);
      } else {
        selectedSubCategoryIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final SubCategorySelectionController controller =
    Get.find<SubCategorySelectionController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF0E5ED),
      appBar: const CustomRoyelAppbar(leftIcon: true, titleName: "Tasks"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Set up your personal information.".tr,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              "You can always change it later.".tr,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            Obx(() {
              if (controller.status.value.isLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                );
              } else if (controller.status.value.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Center(child: Text('No tasks found')),
                );
              } else if (controller.status.value.isError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Column(
                      children: [
                        Text(
                          controller.status.value.errorMessage ??
                              "Something went wrong. Please try again.",
                        ),
                        ElevatedButton(
                          onPressed: controller.getSubCategories,
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children:
                    controller.subCategoryModel.value.data!.map((item) {
                      final isSelected =
                      selectedSubCategoryIds.contains(item.id.toString());
                      return GestureDetector(
                        onTap: () => toggleSelection(item.id.toString()),
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected
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
                              ClipOval(
                                child: CachedNetworkImage(
                                  height: 45,
                                  width: 45,
                                  imageUrl: item.img ?? "",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.info_outline,
                                    color: Colors.grey[500],
                                  ),
                                  placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                item.name ?? " - ",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14.sp,
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
                );
              }
            }),

            Obx(() {
              if (!controller.status.value.isLoading) {
                return controller.updateStatus.value.isLoading
                    ? const CustomLoader()
                    : CustomButton(
                  onTap: () {
                    if (selectedSubCategoryIds.isNotEmpty) {

                      controller.updateContractorData(
                        selectedSubCategoryIds,
                      );
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please select at least one task to continue.",
                      );
                    }
                  },
                  title: "Continue".tr,
                );
              } else {
                return const SizedBox.shrink();
              }
            }),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
