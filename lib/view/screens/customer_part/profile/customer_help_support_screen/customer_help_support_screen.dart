import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/profile/controller/create_help_controller.dart';

class CustomerHelpSupportScreen extends StatelessWidget {
  CustomerHelpSupportScreen({super.key});

  final CreateHelpController controller = Get.put(CreateHelpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Help & Support".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(child: CustomImage(imageSrc: AppImages.helpImage)),
              CustomText(
                text: "Hello, how can we assist you?".tr,
                fontSize: 16.w,
                fontWeight: FontWeight.w500,
                color: AppColors.textCLr,
              ),
              CustomFormCard(
                  title: "Title",
                  hintText: "Enter the title of your issue",
                  controller: controller.titleController
              ),
              CustomFormCard(
                  title: "Write in below box",
                  hintText: "write here.....",
                  maxLine: 5,
                  controller: controller.detailsController
              ),
              SizedBox(height: 30.h,),
              Obx(() => CustomButton(
                onTap: controller.isLoading.value 
                    ? () {} 
                    : controller.createSupportTicket,
                title: controller.isLoading.value 
                    ? "Sending...".tr 
                    : "Send".tr,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
