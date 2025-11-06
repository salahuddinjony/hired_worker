import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/extensions/widget_extension.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';

import '../../../../../helper/image_handelar/image_handelar.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';

class ContractorSignUpScreen extends StatelessWidget {
  const ContractorSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final AuthController authController = Get.find<AuthController>();
    final bool isContactor = Get.arguments['isContactor'] ?? false;
    return Scaffold(
      appBar: CustomRoyelAppbar(
        titleName:
            "${isContactor ? 'Contractor'.tr : 'Customer'.tr} ${'Signup'.tr}",
        leftIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  top: 20.h,
                  text: "Create a New Account".tr,
                  fontSize: 24.w,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
              ),
              Center(
                child: CustomText(
                  top: 10.h,
                  text:
                      "Set up your username and password.\nYou can always change it later."
                          .tr,
                  fontSize: 14.w,
                  fontWeight: FontWeight.w300,
                  color: AppColors.black,
                  bottom: 20.h,
                ),
              ),

              // image
              Obx(() {
                return Center(
                  child: Stack(
                    children: [
                      authController.selectedImage.value == null
                          ? CustomNetworkImage(
                            imageUrl:
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/Octicons-cloud-upload.svg/1200px-Octicons-cloud-upload.svg.png',
                            height: 120.h,
                            width: 120.w,
                            fit: BoxFit.fill,
                            boxShape: BoxShape.circle,
                            backgroundColor: AppColors.black.withValues(
                              alpha: 0.05,
                            ),
                          )
                          : Container(
                            height: 120.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(
                                  authController.selectedImage.value!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                      Positioned(
                        bottom: 5,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            authController.pickImageFromGallery();
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 18,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 10),

              CustomFormCard(
                title: "Enter your name".tr,
                hintText: "Enter your name".tr,
                controller: authController.nameController.value,
              ),
              CustomFormCard(
                title: "Enter your Email".tr,
                hintText: "Enter your email".tr,
                controller: authController.emailController.value,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormCard(
                      title: "Enter your mobile number".tr,
                      hintText: "Enter your number".tr,
                      controller: authController.phoneController.value,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your mobile number";
                        } else if (value.length < 10) {
                          return "Please enter a valid mobile number";
                        }

                        return null;
                      },
                    ),

                    // date of birth
                    CustomFormCard(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your date of birth';
                        }

                        return null;
                      },
                      title: "Date of Birth".tr,
                      hintText: 'dd/mm/yyyy',
                      controller: authController.dobController.value,
                      readOnly: true,
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null) {
                          authController.dobController.value.text = DateFormat(
                            'dd/MM/yyyy',
                          ).format(pickedDate);
                        }
                      },
                    ),
                  ],
                ),
              ),

              isContactor == false
                  ? CustomFormCard(
                    title: "Enter your address".tr,
                    hintText: "Enter your address".tr,
                    controller: authController.addressController.value,
                    readOnly: true,
                    onTap: () async {
                      // // Initialize MapController if not already registered (for reusable map screen)
                      // if (!Get.isRegistered<MapController>()) {
                      //   Get.put(MapController());
                      // }

                      // // Navigate to map screen with argument to return data
                      // final result = await Get.toNamed(
                      //   '/SeletedMapScreen',
                      //   arguments: {'returnData': true},
                      // );

                      // // Update address field with selected location
                      // if (result != null && result is Map<String, dynamic>) {
                      //   authController.updateAddressFromMap(result);
                      // }
                      authController.showAddAddressDialog(isSignUp: true);
                    },
                  )
                  : const SizedBox.shrink(),
              CustomFormCard(
                isPassword: true,
                title: "Enter New Password".tr,
                hintText: "Enter your password".tr,
                controller: authController.passController.value,
              ),
              CustomFormCard(
                isPassword: true,
                title: "Enter Confirm Password".tr,
                hintText: "Enter your password".tr,
                controller: authController.confirmController.value,
              ),
              Obx(() {
                return Row(
                  children: [
                    Checkbox(
                      value: authController.agreeWithTaP.value,
                      onChanged: (value) {
                        authController.agreeWithTaP.value = value ?? true;
                      },
                    ),
                    CustomText(
                      text: "I agree to the ".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    CustomText(
                      text: "Terms".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ).onTap(() {
                      Get.toNamed(AppRoutes.termsConditionsScreen);
                    }),
                    CustomText(
                      text: " and ".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                    CustomText(
                      text: "Privacy Policy.".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blue,
                    ).onTap(() {
                      Get.toNamed(AppRoutes.privacyPolicyScreen);
                    }),
                  ],
                );
              }),
              SizedBox(height: 30.h),
              Obx(() {
                return authController.signUpLoading.value.isLoading
                    ? const CustomLoader()
                    : CustomButton(
                      onTap: () {
                        if (isContactor) {
                          if (isContactor &&
                              authController.selectedImage.value == null) {
                            showCustomSnackBar('Please upload your image first');

                            return;
                          }

                          if (_formKey.currentState!.validate()) {
                            authController.customerSignUp(isContactor);
                          }
                        } else {
                          authController.customerSignUp(isContactor);
                        }
                      },
                      title: "Submit".tr,
                    );
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account?".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: CustomText(
                      text: "Login".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
