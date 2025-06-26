import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/customer_home_screen/widget/custom_popular_services_card.dart';

class SubCategoryItem extends StatelessWidget {
  SubCategoryItem({
    super.key,
    required this.categoryName,
    required this.subCategoryName,
  });

  String categoryName;
  String subCategoryName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: categoryName,
          fontSize: 16.w,
          fontWeight: FontWeight.w600,
          color: AppColors.black_08,
          bottom: 10.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(5, (value) {
              return CustomPopularServicesCard(
                image: AppConstants.electrician,
                name: subCategoryName,
                onTap: () {
                  Get.toNamed(AppRoutes.customerAllContractorViewScreen);
                },
              );
            }),
          ),
        ),
      ],
    );
  }
}
