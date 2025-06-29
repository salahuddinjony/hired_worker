import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/view/components/custom_Controller/custom_controller.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_dropdown/custom_royel_dropdown.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final ProfileController profileController = Get.find<ProfileController>();
  final CustomController customController = Get.find<CustomController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Edit Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //========= Font-end Design Flutter Image Picker Code ===========//
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    final data = profileController.contractorModel.value.data;
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
                        decoration: BoxDecoration(
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
              title: "Name",
              controller: profileController.nameController.value,
              hintText: 'name',
            ),
            CustomFormCard(
              title: "Phone Number",
              hintText: 'phone number',

              controller: profileController.phoneController.value,
            ),
            CustomText(
              text: 'Gender',
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
              title: "Date of Birth",
              hintText: 'yyyy/mm/dd',
              controller: profileController.dobController.value,
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
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
              title: "City",
              controller: profileController.cityController.value,
              hintText: 'City',
            ),
            SizedBox(height: 20.h),
            CustomButton(onTap: () {}, title: "Update"),
          ],
        ),
      ),
    );
  }
}
