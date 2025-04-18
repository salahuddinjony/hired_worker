import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/app_const/app_const.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../controller/profile_controller.dart';
class EditProfileScreen extends StatelessWidget {
   EditProfileScreen({super.key});
  final profileController =Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true,titleName: "Edit Profile",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            //========= Font-end Design Flutter Image Picker Code ===========//
            Center(
              child: Stack(
                children: [
                  Obx(() {
        // Check if an image is selected, if not use the default profile image
                    if (profileController.selectedImage.value != null) {
                      return Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(profileController.selectedImage.value!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return CustomNetworkImage(
                        imageUrl: AppConstants.profileImage,
                        height: 120.h,
                        width: 120.w,
                        boxShape: BoxShape.circle,
                      );
                    }
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
            SizedBox(height: 20.h,),
            CustomFormCard(title: "Name",
                controller: TextEditingController()),
            CustomFormCard(title: "Phone Number",
                controller: TextEditingController()),
            CustomFormCard(title: "Gender",
                controller: TextEditingController()),
            CustomFormCard(title: "Date of Birth",
                controller: TextEditingController()),
            CustomFormCard(title: "City",
                controller: TextEditingController()),
            SizedBox(height: 20.h,),
            CustomButton(onTap: (){}, title: "Update",)


          ],
        ),
      ),
    );
  }
}
