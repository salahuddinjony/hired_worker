import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_Controller/custom_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/model/notification_model.dart';
import 'package:servana/view/screens/customer_part/profile/model/user_model.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class CustomerProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getMe();
  }

  final CustomController customController = Get.find<CustomController>();
  //========= update profile controller ===========//
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;

  //========= change password controllers ===========//
  Rx<TextEditingController> oldPasswordController = TextEditingController().obs;
  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<TextEditingController> confirmNewPasswordController =
      TextEditingController().obs;

  initUserProfileInfoTextField(Data data) {
    nameController.value.text = data.fullName ?? '';
    phoneController.value.text = data.contactNo ?? '';
    dobController.value.text = data.customer?.dob ?? '';
    cityController.value.text = data.customer?.city ?? '';
    customController.selectedGender.value = data.customer?.gender ?? '';
  }

  RxInt currentIndex = 0.obs;
  RxInt activityTypeindex = 0.obs;
  RxList<String> nameList =
      [
        AppStrings.receivedText,
        AppStrings.requestedText,
        AppStrings.rejectedText,
      ].obs;

  //========= Image Picker GetX Controller Code ===========//

  final Rx<File?> selectedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // Pick an image from the gallery
  Future<void> pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // Pick an image using the camera
  Future<void> pickImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  //========= Customer Profile ===========//
  Rx<CustomerModel> customerModel = CustomerModel().obs;

  Future<void> getMe() async {
    try {
      final response = await ApiClient.getData(ApiUrl.getMe);

      if (response.statusCode == 200 || response.statusCode == 201) {
        customerModel.value = CustomerModel.fromJson(response.body);
        initUserProfileInfoTextField(customerModel.value.data!);
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Something went wrong",
          isError: true,
        );
      }
    } catch (e) {
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  //========= update profile ===========//
  Rx<RxStatus> updateProfileStatus = Rx<RxStatus>(RxStatus.success());
  Future<void> updateProfile() async {
    dynamic response;
    updateProfileStatus.value = RxStatus.loading();
    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    final Map<String, String> body = {
      'fullName': nameController.value.text,
      'contactNo': phoneController.value.text,
      'city': cityController.value.text,
      'dob': dobController.value.text,
      'gender': customController.selectedGender.value,
    };

    if (selectedImage.value != null) {
      response = await ApiClient.patchMultipartData(
        ApiUrl.updateProfile(userId: userId),
        body,
        multipartBody: [MultipartBody("file", selectedImage.value!)],
      );
    } else {
      response = await ApiClient.patchData(
        ApiUrl.updateProfile(userId: userId),
        jsonEncode(body),
      );
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      updateProfileStatus.value = RxStatus.success();
      final decoded =
          selectedImage.value != null
              ? jsonDecode(response.body)
              : response.body;
      showCustomSnackBar(
        decoded['message'] ?? "Profile Updated Successfully",
        isError: false,
      );
      getMe();
      Get.back();
    } else {
      updateProfileStatus.value = RxStatus.success();
      showCustomSnackBar("Something went wrong", isError: false);
    }
  }

  // get notifications

  RxList<CustomNotification> notificationsList = <CustomNotification>[].obs;
  Rx<RxStatus> getNotificationStatus = Rx<RxStatus>(RxStatus.success());
  Future<void> getNotifications() async {
    // EasyLoading.show();
    try {
      getNotificationStatus.value = RxStatus.loading();
      final String userId = await SharePrefsHelper.getString(
        AppConstants.userId,
      );
      final Map<String, String> queryParams = {'userId': userId};
      final response = await ApiClient.getData(
        ApiUrl.getNotificationList,
        query: queryParams,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        notificationsList.value =
            NotificationModel.fromJson(response.body).data ?? [];
        getNotificationStatus.value = RxStatus.success();
      } else {
        getNotificationStatus.value = RxStatus.error();
        showCustomSnackBar(
          response.body['message'] ?? "Something went wrong",
          isError: true,
        );
      }
    } catch (e) {
      getNotificationStatus.value = RxStatus.error();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
      debugPrint('Error in getNotifications: $e');
    } finally {
      EasyLoading.dismiss();
    }
  }

  //change password
  Rx<RxStatus> changePasswordStatus = Rx<RxStatus>(RxStatus.success());
  Future<void> changePassword() async {
    changePasswordStatus.value = RxStatus.loading();

    if (oldPasswordController.value.text.isEmpty ||
        newPasswordController.value.text.isEmpty ||
        confirmNewPasswordController.value.text.isEmpty) {
      changePasswordStatus.value = RxStatus.success();
      EasyLoading.showError("Please fill all the fields");
      return;
    }

    if (newPasswordController.value.text !=
        confirmNewPasswordController.value.text) {
      changePasswordStatus.value = RxStatus.success();
      EasyLoading.showError("New password and confirm password do not match");
      return;
    }
    final Map<String, String> body = {
      "oldPassword": oldPasswordController.value.text,
      "newPassword": newPasswordController.value.text,
    };

    try {
      final response = await ApiClient.postData(
        ApiUrl.changePassword,
        jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        changePasswordStatus.value = RxStatus.success();
        EasyLoading.showSuccess(
          response.body['message'] ?? "Password changed successfully",
        );
        oldPasswordController.value.clear();
        newPasswordController.value.clear();
        confirmNewPasswordController.value.clear();
        Get.back();
      } else {
        changePasswordStatus.value = RxStatus.success();
        EasyLoading.showError(
          response.body['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      changePasswordStatus.value = RxStatus.success();
      debugPrint('Error in changePassword: $e');
      EasyLoading.showError(AppStrings.checknetworkconnection);
    }
  }
}
