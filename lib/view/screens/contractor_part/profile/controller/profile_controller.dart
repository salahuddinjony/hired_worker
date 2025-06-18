import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/profile/model/material_model.dart';

import '../../../../../utils/app_strings/app_strings.dart';

class ProfileController extends GetxController{

  RxInt currentIndex = 0.obs;
  RxInt activityTypeindex = 0.obs;
  RxList<String> nameList = [
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

    @override
  void onInit() {
    getMateria();
    super.onInit();
  }

  Rx<RxStatus> getMateriaStatus = Rx<RxStatus>(RxStatus.loading());
  Rx<MaterialModel> materialModel= MaterialModel().obs;

  //======= get materia =======//
  Future<void> getMateria() async {
    getMateriaStatus.value = RxStatus.loading();
    try {
      final response = await ApiClient.getData(ApiUrl.materials);

      materialModel.value = MaterialModel.fromJson(response.body);

      getMateriaStatus.value = RxStatus.success();
      refresh();

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Material data: ${materialModel.value}');
        showCustomSnackBar(
          response.body['message'] ?? "Material successful",
          isError: false,
        );
      } else {
        showCustomSnackBar(
          response.body['message'] ?? "Material Failed",
          isError: false,
        );
      }
    } catch (e) {
      getMateriaStatus.value = RxStatus.success();
      refresh();
      showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    }
  }
}