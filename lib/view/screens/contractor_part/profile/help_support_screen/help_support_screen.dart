import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/support_controller.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final SupportController controller = Get.find<SupportController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Help & Support".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Center(child: CustomImage(imageSrc: AppImages.helpImage)),
              CustomText(
                text: "Hello, how can we assist you?",
                fontSize: 16.w,
                fontWeight: FontWeight.w500,
                color: AppColors.textCLr,
              ),
              CustomFormCard(
                title: "Title",
                hintText: "Enter the title of your issue",
                controller: controller.titleEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              CustomFormCard(
                title: "Description",
                hintText: "Write your issue here...",
                maxLine: 5,
                controller: controller.messageEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),

              SizedBox(height: 30.h),
              Obx(() {
                return controller.status.value.isLoading
                    ? CustomLoader()
                    : CustomButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.sendMessage();
                        }
                      },
                      title: "Send".tr,
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
