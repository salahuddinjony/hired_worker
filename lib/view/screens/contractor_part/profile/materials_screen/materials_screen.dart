import 'package:flutter/material.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import 'widget/custom_material_card.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Materials"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: List.generate(5, (value){
            return CustomMaterialCard();
          })
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your navigation or action logic here
         // Get.toNamed(AppRoutes.addNewItemScreen);
        },
        backgroundColor: AppColors.primary, // Or your custom color
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
