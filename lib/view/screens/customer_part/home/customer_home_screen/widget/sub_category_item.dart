import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/customer_home_screen/widget/custom_popular_services_card.dart';

// Alias to avoid Datum name conflict
import 'package:servana/view/screens/customer_part/home/model/sub_category_model.dart'
    as sub;

class SubCategoryPreviewSection extends StatelessWidget {
  final Axis scrollDirection;
  const SubCategoryPreviewSection({
    super.key,
    this.scrollDirection = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      final List<sub.Datum> data =
          homeController.subCategoryModel.value.data ?? [];

      if (homeController.getSubCategoryStatus.value.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      // Group subcategories by category name
      final Map<String, List<sub.Datum>> groupedData = {};
      for (final item in data) {
        final categoryName = item.categoryId?.name ?? 'Unknown';
        groupedData.putIfAbsent(categoryName, () => []);
        groupedData[categoryName]!.add(item);
      }

      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: 0.w,
          vertical: 0.h,
        ), // tighter padding
        children:
            groupedData.entries.take(2).map((entry) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: entry.key,
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black_08,
                      bottom: 6.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: scrollDirection,
                      child: Row(
                        children:
                            entry.value.map<Widget>((item) {
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: CustomPopularServicesCard(
                                  image: item.img ?? '',
                                  name: item.name ?? '',
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes
                                          .customerAllContractorBasedSubCategoryViewScreen,
                                      arguments: {
                                        'id': item.id ?? '',
                                        'name': item.name ?? 'Subcategory',
                                      },
                                    );
                                  },
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      );
    });
  }
}
