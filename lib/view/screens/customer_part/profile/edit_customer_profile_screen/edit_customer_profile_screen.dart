import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/view/components/custom_Controller/custom_controller.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../controller/customer_profile_controller.dart';

class EditCustomerProfileScreen extends StatelessWidget {
  EditCustomerProfileScreen({super.key});
  final CustomerProfileController profileController =
      Get.find<CustomerProfileController>();
  final CustomController customController = Get.find<CustomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Edit Profile".tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========= Font-end Design Flutter Image Picker Code ===========//
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      final data = profileController.customerModel.value.data;
                      // Check if an image is selected, if not use the default profile image
        
                      return profileController.selectedImage.value == null
                          ? (data?.img != null)
                              ? CustomNetworkImage(
                                imageUrl: ImageHandler.imagesHandle(data?.img),
                                height: 80.h,
                                width: 80.w,
                                boxShape: BoxShape.circle,
                              )
                              : CustomNetworkImage(
                                imageUrl: AppConstants.profileImage,
                                height: 80.h,
                                width: 80.w,
                                boxShape: BoxShape.circle,
                              )
                          : Container(
                            height: 80.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(
                                  profileController.selectedImage.value!,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                    }),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          profileController.pickImageFromGallery();
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
              ),
              SizedBox(height: 20.h),
              CustomFormCard(
                title: "Name".tr,
                controller: profileController.nameController.value,
                hintText: 'name',
              ),
              CustomFormCard(
                title: "Phone Number".tr,
                hintText: 'phone number',
        
                controller: profileController.phoneController.value,
              ),
              CustomText(
                text: 'Gender'.tr,
                bottom: 10.h,
                fontSize: 18.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
              CustomRoyelDropdown(
                list: customController.cetagoryList,
                selectedValue: customController.selectedGender,
                title: 'Select Gender',
                isBorder: true,
                fillColor: Colors.transparent,
                textColor: AppColors.black,
              ),
              SizedBox(height: 10.h),
        
              CustomFormCard(
                title: "Date of Birth".tr,
                hintText: 'yyyy/mm/dd',
                controller: profileController.dobController.value,
                readOnly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
        
                  if (pickedDate != null) {
                    profileController.dobController.value.text =
                        "${pickedDate.toLocal()}".split(' ')[0];
                  }
                },
              ),
        
              CustomFormCard(
                title: "City".tr,
                controller: profileController.cityController.value,
                hintText: 'City',
              ),
              Obx(
                () =>
                    profileController.updateProfileStatus.value.isLoading
                        ? const CustomLoader()
                        : CustomButton(
                          onTap: () {
                            profileController.updateProfile();
                          },
                          title: "Update".tr,
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
