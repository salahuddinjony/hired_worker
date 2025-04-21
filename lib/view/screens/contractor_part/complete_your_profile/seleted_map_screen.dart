import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
class SeletedMapScreen extends StatelessWidget {
  const SeletedMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Selected Location",),
      body: Stack(
        children: [
          Positioned(
            bottom: 30,
              right: 30,
              left: 30,
              child: CustomButton(onTap: (){
                Get.toNamed(AppRoutes.scheduleSeletedScreen);
              }, title: "Continue",))
        ],
      ),
    );
  }
}
