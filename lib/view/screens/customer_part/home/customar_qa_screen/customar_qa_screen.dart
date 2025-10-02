import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
class CustomarQaScreen extends StatelessWidget {
  const CustomarQaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Q&A".tr,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              CustomFormCard(
                  title: "1. How many dimmers do you need installed ?",
                  hintText: "answer here.....",
                  controller: TextEditingController()),
              CustomFormCard(
                  title: "2. How many dimmers do you need installed ?",
                  hintText: "answer here.....",
                  controller: TextEditingController()),
              CustomFormCard(
                  title: "3. How many dimmers do you need installed ?",
                  hintText: "answer here.....",
                  controller: TextEditingController()),
              CustomFormCard(
                  title: "4. How many dimmers do you need installed ?",
                  hintText: "answer here.....",
                  controller: TextEditingController()),
              SizedBox(height: 30.h,),
              CustomButton(onTap: (){
                Get.toNamed(AppRoutes.customarMaterialsScreen);
              }, title: "Submit".tr,)
            ],
          ),
        ),
      ),
    );
  }
}
