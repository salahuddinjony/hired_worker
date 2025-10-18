import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/screens/customer_part/profile/controller/customer_profile_controller.dart';

class CustomerChangePasswordScreen extends StatelessWidget {
  final CustomerProfileController controller =
      Get.find<CustomerProfileController>();

  CustomerChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Change Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomFormCard(
              title: "Old Password".tr,
              hintText: "Enter your old password".tr,
              controller: controller.oldPasswordController.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your old password";
                }
                return null;
              },
            ),
            CustomFormCard(
              title: "New Password".tr,
              hintText: "Enter your new password".tr,
              controller: controller.newPasswordController.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a new password";
                }
                return null;
              },
            ),
            CustomFormCard(
              title: "Confirm New Password".tr,
              hintText: "Confirm your new password".tr,
              controller: controller.confirmNewPasswordController.value,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a new password";
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            Obx(
              () =>
                  controller.changePasswordStatus.value.isLoading
                      ? const CustomLoader()
                      : CustomButton(
                        onTap: () {
                          controller.changePassword();
                        },
                        title: "Change Password".tr,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
