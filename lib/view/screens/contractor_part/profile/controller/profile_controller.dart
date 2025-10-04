import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_Controller/custom_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/model/contractor_model.dart';
import 'package:servana/view/screens/contractor_part/profile/model/material_model.dart';
import 'package:servana/view/screens/contractor_part/profile/model/notification_model.dart';

import '../../../../../utils/app_strings/app_strings.dart';

class ProfileController extends GetxController {
  final CustomController customController = Get.find<CustomController>();

  //========= update profile controller ===========//
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;

  initUserProfileInfoTextField(Data data) {
    nameController.value.text = data.fullName ?? '';
    phoneController.value.text = data.contactNo ?? '';
    dobController.value.text = data.contractor?.dob.toString() ?? '';
    cityController.value.text = data.contractor?.location ?? '';
    customController.selectedGender.value = data.contractor?.gender ?? '';
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

  bool flag = false;

  @override
  void onInit() {
    getMe();
    getMaterial();
    super.onInit();
  }

  //========= Customer Profile ===========//
  Rx<ContractorModel> contractorModel = ContractorModel().obs;

  Future<void> getMe() async {
    try {
      final response = await ApiClient.getData(ApiUrl.getMe);

      if (response.statusCode == 200 || response.statusCode == 201) {
        contractorModel.value = ContractorModel.fromJson(response.body);

        debugPrint('xxx - inside get me ${contractorModel.value.data!.contractor!.materials!.length}');

        initUserProfileInfoTextField(contractorModel.value.data!);
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Something went wrong",
          isError: true,
        );
      }
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
    }
  }

  Rx<RxStatus> getMaterialStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<MaterialModel> materialModel = MaterialModel().obs;

  //======= get material =======//
  Future<void> getMaterial() async {
    getMaterialStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(ApiUrl.materials);

      materialModel.value = MaterialModel.fromJson(response.body);

      getMaterialStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Material Failed",
          isError: false,
        );
      }
    } catch (e) {
      getMaterialStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }

  //========= update profile ===========//
  Rx<RxStatus> updateProfileStatus = Rx<RxStatus>(RxStatus.success());

  Future<void> updateProfile() async {
    dynamic response;
    updateProfileStatus.value = RxStatus.loading();
    String userId = await SharePrefsHelper.getString(AppConstants.userId);
    Map<String, String> body = {
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

  Rx<RxStatus> notificationStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<NotificationModel> notificationModel = NotificationModel().obs;

  Future<void> getNotification() async {
    notificationStatus.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(
        '${ApiUrl.notification}?userId=${contractorModel.value.data!.id}',
      );

      notificationModel.value = NotificationModel.fromJson(response.body);

      if (notificationModel.value.data == null || notificationModel.value.data!.isEmpty) {
        notificationStatus.value = RxStatus.empty();
      } else {
        notificationStatus.value = RxStatus.success();
      }

    } catch (e) {
      notificationStatus.value = RxStatus.error(e.toString());
    }
  }
}
