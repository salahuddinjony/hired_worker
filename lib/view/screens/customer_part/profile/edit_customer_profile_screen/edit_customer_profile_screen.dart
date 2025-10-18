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
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';
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
                title: "Address".tr,
                controller: profileController.cityController.value,
                hintText: 'Address',
                readOnly: true,
                onTap: () async {
               
                  if (!Get.isRegistered<MapController>()) {
                    Get.put(MapController());
                  }
                  
                  // Navigate to map screen with argument to return data instead of updating contractor data
                  final result = await Get.toNamed(
                    '/SeletedMapScreen',
                    arguments: {'returnData': true},
                  );
                  
                  // Update address field with selected location
                  if (result != null && result is Map<String, dynamic>) {
                    profileController.updateAddressFromMap(result);
                  }
                },
              ),
              SizedBox(height: 20.h),
              
              // Additional Address Section Title
              CustomText(
                text: 'Saved Addresses'.tr,
                fontSize: 18.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                bottom: 10.h,
              ),
              
              // Additional Address Card
              GestureDetector(
                onTap: () {
                  profileController.showAddressBottomSheet();
                },
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Obx(
                    () {
                      final hasAddress = profileController.additionalAddressController.value.text.isNotEmpty;
                      
                      return Row(
                        children: [
                          // Icon Container
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Icon(
                              hasAddress ? Icons.location_on : Icons.add_location_alt_outlined,
                              color: AppColors.primary,
                              size: 24.w,
                            ),
                          ),
                          
                          SizedBox(width: 12.w),
                          
                          // Text Content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: hasAddress 
                                      ? "Selected Address".tr 
                                      : "Add Address".tr,
                                  fontSize: 16.w,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.black,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: hasAddress
                                      ? profileController.additionalAddressController.value.text
                                      : "Tap to manage your saved addresses".tr,
                                  fontSize: 13.w,
                                  fontWeight: FontWeight.w400,
                                  color: hasAddress ? AppColors.black_05 : Colors.grey[500]!,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                          
                          SizedBox(width: 8.w),
                          
                          // Arrow Icon
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey[400],
                            size: 16.w,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              // CustomFormCard(
              //   title: "Additional Address".tr,
              //   hintText: 'additional address',
              //   controller: profileController.phoneController.value,
              // ),
              SizedBox(height: 30.h),
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
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
