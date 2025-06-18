import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import 'widget/custom_material_card.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Materials"),
      body: Obx(() {
        final materials = profileController.materialModel.value.data ?? [];

        if (profileController.getMateriaStatus.value.isLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView.builder(
              
              itemCount: materials.length,
              itemBuilder: (context, index) {
                final material = materials[index];
                return CustomMaterialCard(
                  title: material.name ?? "",
                  unit: material.unit.toString(),
                  price: material.price.toString(),
                );
              },
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your navigation or action logic here
          // Get.toNamed(AppRoutes.addNewItemScreen);
        },
        backgroundColor: AppColors.primary, // Or your custom color
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
