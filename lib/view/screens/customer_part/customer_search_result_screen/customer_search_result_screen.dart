import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text_field/custom_text_field.dart';
class CustomerSearchResultScreen extends StatelessWidget {
  const CustomerSearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            children: [
              CustomTextField(
                fillColor: AppColors.white,
                hintText: "Search......".tr,
                hintStyle: TextStyle(color: AppColors.black_08),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomImage(imageSrc: AppIcons.search, ),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
