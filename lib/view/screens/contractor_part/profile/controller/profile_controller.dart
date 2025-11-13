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
import 'package:servana/view/screens/customer_part/profile/widgets/add_address_dialog.dart';
import 'package:servana/view/screens/customer_part/profile/widgets/address_selection_bottom_sheet.dart';

import '../../complete_your_profile/controller/map_controller.dart';

class ProfileController extends GetxController {
  final CustomController customController = Get.find<CustomController>();

  //========= update profile controller ===========//
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> bioController = TextEditingController().obs;
  Rx<TextEditingController> experienceController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;

  // Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;

  initUserProfileInfoTextField(Data data) {
    nameController.value.text = data.fullName ?? '';
    phoneController.value.text = data.contactNo ?? '';
    dobController.value.text = data.contractor?.dob.toString() ?? '';
    // cityController.value.text = data.contractor?.location?.address ?? '';
    bioController.value.text = data.contractor?.bio ?? "";
    experienceController.value.text = data.contractor?.experience ?? "";
    customController.selectedGender.value = data.contractor?.gender ?? '';
  }

  RxInt activityTypeindex = 0.obs;

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
    // getMaterial();
    super.onInit();
  }

  //========= Customer Profile ===========//
  Rx<ContractorModel> contractorModel = ContractorModel().obs;
  Rx<Location> location = Location().obs;

  Future<void> getMe() async {
    try {
      final response = await ApiClient.getData(ApiUrl.getMe);

      if (response.statusCode == 200 || response.statusCode == 201) {
        contractorModel.value = ContractorModel.fromJson(response.body);
        location.value = contractorModel.value.data!.contractor!.location!;

        initUserProfileInfoTextField(contractorModel.value.data!);

        contractorModel.refresh();
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

  // //======= get material =======//
  // Future<void> getMaterial() async {
  //   getMaterialStatus.value = RxStatus.loading();
  //   try {
  //     final response = await ApiClient.getData(ApiUrl.materials);

  //     materialModel.value = MaterialModel.fromJson(response.body);

  //     getMaterialStatus.value = RxStatus.success();
  //     refresh();

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //     } else {
  //       showCustomSnackBar(
  //         response.body['message'] ?? "Material Failed",
  //         isError: false,
  //       );
  //     }
  //   } catch (e) {
  //     getMaterialStatus.value = RxStatus.success();
  //     refresh();
  //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
  //   }
  // }

  //========= update profile ===========//
  Rx<RxStatus> updateProfileStatus = Rx<RxStatus>(RxStatus.success());

  Future<void> updateProfile() async {
    dynamic response;
    updateProfileStatus.value = RxStatus.loading();
    final String userId = await SharePrefsHelper.getString(AppConstants.userId);
    final Map<String, String> body = {
      'fullName': nameController.value.text,
      'contactNo': phoneController.value.text,
      // 'city': cityController.value.text,
      'dob': dobController.value.text,
      'experience': experienceController.value.text,
      'bio': bioController.value.text,
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

      if (notificationModel.value.data == null ||
          notificationModel.value.data!.isEmpty) {
        notificationStatus.value = RxStatus.empty();
      } else {
        notificationStatus.value = RxStatus.success();
      }
    } catch (e) {
      notificationStatus.value = RxStatus.error(e.toString());
    }
  }

  final TextEditingController addressNameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();

  void editAddress({
    String? addId,
    String? address,
    String? street,
    String? unit,
    String? direction,
    double? latitude,
    double? longitude,
  }) {
    // Fill controllers with address data
    addressNameController.text = address ?? '';
    streetController.text = street ?? '';
    unitController.text = unit ?? '';
    directionsController.text = direction ?? '';

    // Show bottom sheet for editing
    Get.bottomSheet(
      AddAddressBottomSheet(
        locationId: location.value.id,
        address: location.value.address ?? '',
        latitude: location.value.coordinates![0].toDouble(),
        longitude: location.value.coordinates![1].toDouble(),
        unit: location.value.unit ?? '',
        street: location.value.street ?? '',
        directions: location.value.direction ?? '',
        isUpdate: true,
        name: "",
        isContractor: true,
        isFromProfileContractor: true,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  // Show bottom sheet for address selection
  void showAddressBottomSheet({bool isFromProfile = false, bool? useByUserId}) {
    Get.bottomSheet(
      AddressSelectionBottomSheet(
        isFromProfile: isFromProfile,
        useByUserId: useByUserId,
        isContractor: true,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      enableDrag: true,
    );
  }

  // Navigate to map and then show add address dialog
  Future<void> showAddAddressDialog({bool isFromProfile = false}) async {
    // First, navigate to map to pick location
    if (!Get.isRegistered<MapController>()) {
      Get.put(MapController());
    }

    final result = await Get.toNamed(
      '/SeletedMapScreen',
      arguments: {'returnData': true},
    );

    // If location is selected, show address details bottom sheet
    if (result != null && result is Map<String, dynamic>) {
      final address = result['address'] ?? '';
      final latitude = result['latitude'];
      final longitude = result['longitude'];

      // Show bottom sheet with address details
      Get.bottomSheet(
        AddAddressBottomSheet(
          address: address,
          latitude: latitude,
          longitude: longitude,
          isFromProfile: isFromProfile,
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: true,
      );
    }
  }
}
