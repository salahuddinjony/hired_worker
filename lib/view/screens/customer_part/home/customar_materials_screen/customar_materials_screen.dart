import 'package:flutter/material.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
class CustomarMaterialsScreen extends StatelessWidget {
  const CustomarMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Materials",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
