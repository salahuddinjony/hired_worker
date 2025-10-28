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
import 'package:servana/view/screens/customer_part/profile/model/address_model.dart';
import 'package:servana/view/screens/customer_part/profile/widgets/add_address_dialog.dart';
import 'package:servana/view/screens/customer_part/profile/widgets/address_selection_bottom_sheet.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class CustomerProfileController extends GetxController {
  // Edit an address
  void editAddress(SavedAddress address) {
    // Fill controllers with address data
    addressNameController.text = address.title;
    streetController.text = address.street ?? '';
    unitController.text = address.unit ?? '';
    directionsController.text = address.direction ?? '';

    // Show bottom sheet for editing
    Get.bottomSheet(
      AddAddressBottomSheet(
        locationId: address.id,
        address: address.address,
        latitude: address.latitude,
        longitude: address.longitude,
        unit: address.unit ?? '',
        street: address.street ?? '',
        directions: address.direction ?? '',
        isUpdate: true,
        name: address.name ?? '',

      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
    );
  }

  // PATCH address for a specific location
  Future<void> patchAddress({
    required String locationId,
    required String address,
    required List<double> coordinates,
    String? street,
    String? unit,
    String? directions,
    String? name,
  }) async {
    try {
      final String userId = customerModel.value.data?.customer?.id ?? '';
      final Map<String, dynamic> body = {
        "address": address,
        "street": street ?? streetController.text,
        "unit": unit ?? unitController.text,
        "coordinates": coordinates,
        "direction": directions ?? directionsController.text,
        "name": name ?? addressNameController.text,
      };
      final response = await ApiClient.patchData(
        "/customers/$userId/locations/$locationId",
        jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        showCustomSnackBar(
          response.body['message'] ?? "Address updated successfully",
          isError: false,
        );
        getMe();
        Get.back();
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

  // Delete an address
  void deleteAddress(SavedAddress address) {
    savedAddresses.removeWhere((a) => a.id == address.id);
    savedAddresses.refresh();
    // Optionally update profile on backend
    updateProfile(editLocations: true);
  }

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
  Rx<TextEditingController> additionalAddressController =
      TextEditingController().obs;

  // Location data
  RxnDouble latitude = RxnDouble();
  RxnDouble longitude = RxnDouble();

  // Temporary location data for new address
  RxnDouble tempLatitude = RxnDouble();
  RxnDouble tempLongitude = RxnDouble();

  // Saved addresses list
  RxList<SavedAddress> savedAddresses = <SavedAddress>[].obs;

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

  // Update address from map selection
  void updateAddressFromMap(Map<String, dynamic> locationData) {
    cityController.value.text = locationData['address'] ?? '';
    latitude.value = locationData['latitude'];
    longitude.value = locationData['longitude'];
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
        // Load saved addresses from backend
        final locations = customerModel.value.data?.customer?.location;
        if (locations != null && locations.isNotEmpty) {
          savedAddresses.value =
              locations.map((loc) {
                double? latitude;
                double? longitude;
                if (loc.coordinates != null && loc.coordinates!.isNotEmpty) {
                  longitude =
                      loc.coordinates!.length > 0 ? loc.coordinates![0] : null;
                  latitude =
                      loc.coordinates!.length > 1 ? loc.coordinates![1] : null;
                }
                return SavedAddress(
                  id:
                      loc.id ??
                      DateTime.now().millisecondsSinceEpoch.toString(),
                  title: loc.name ?? '',
                  name: loc.name ?? '',
                  address: loc.address ?? '',
                  city: cityController.value.text,
                  street: loc.street,
                  unit: loc.unit,
                  direction: loc.direction,
                  latitude: latitude,
                  longitude: longitude,
                  isSelected: loc.isSelect ?? false,
                );
              }).toList();
          // Set additionalAddressController to selected address
          final selected = getSelectedAddress();
          if (selected != null) {
            String fullAddress = selected.address;
            if (selected.unit != null && selected.unit!.isNotEmpty) {
              fullAddress = '${selected.unit}, $fullAddress';
            }
            if (selected.street != null && selected.street!.isNotEmpty) {
              fullAddress = '${selected.street}, $fullAddress';
            }
            additionalAddressController.value.text = fullAddress;
          }
        }
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
  RxString savedLocationType = ''.obs;

  // Map<String, dynamic> get locationsData => {
  //   "type": "Point",
  //   "coordinates": [longitude.value, latitude.value],
  //   "address": cityController.value.text,
  //   "name": savedLocationType.value,
  //   "isSelect": false,
  // };
  Future<void> updateProfile({bool editLocations=false}) async {
    dynamic response;
    updateProfileStatus.value = RxStatus.loading();
    final String userId = await SharePrefsHelper.getString(AppConstants.userId);

    // Prepare location list from savedAddresses
    final List<Map<String, dynamic>> locationList =
        savedAddresses
            .map(
              (addr) => {
                "type": "Point",
                "coordinates": [addr.longitude, addr.latitude],
                "address": addr.address,
                "name": addr.title,
                "street": addr.street ?? '',
                "unit": addr.unit ?? '',
                "direction": addr.direction ?? '',
                "isSelect": addr.isSelected,
              },
            )
            .toList();

    // For multipart, use Map<String, dynamic> so location can be a List
    final Map<String, dynamic> body = {
      'fullName': nameController.value.text,
      'contactNo': phoneController.value.text,
      'city': cityController.value.text,
      'dob': dobController.value.text,
      'gender': customController.selectedGender.value,
      'location': locationList,
    };

    if (selectedImage.value != null) {
      final Map<String, String> multipartFields = {
        'fullName': body['fullName']?.toString() ?? '',
        'contactNo': body['contactNo']?.toString() ?? '',
        'city': body['city']?.toString() ?? '',
        'dob': body['dob']?.toString() ?? '',
        'gender': body['gender']?.toString() ?? '',
      };

      final List<Map<String, dynamic>> locations =
          List<Map<String, dynamic>>.from(body['location'] ?? []);
      for (var i = 0; i < locations.length; i++) {
        final loc = locations[i];
        final prefix = 'location[$i]';
        if (loc['type'] != null)
          multipartFields['$prefix[type]'] = loc['type'].toString();
        if (loc['address'] != null)
          multipartFields['$prefix[address]'] = loc['address'].toString();
        if (loc['name'] != null)
          multipartFields['$prefix[name]'] = loc['name'].toString();
        if (loc['street'] != null)
          multipartFields['$prefix[street]'] = loc['street'].toString();
        if (loc['unit'] != null)
          multipartFields['$prefix[unit]'] = loc['unit'].toString();
        if (loc['directions'] != null)
          multipartFields['$prefix[directions]'] = loc['directions'].toString();
        if (loc['isSelect'] != null)
          multipartFields['$prefix[isSelect]'] = loc['isSelect'].toString();

        if (loc['coordinates'] != null && loc['coordinates'] is List) {
          final coords = List.from(loc['coordinates']);
          for (var j = 0; j < coords.length; j++) {
            multipartFields['$prefix[coordinates][$j]'] =
                coords[j]?.toString() ?? '';
          }
        }
      }

      response = await ApiClient.patchMultipartData(
        ApiUrl.updateProfile(userId: userId),
        multipartFields,
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
      if (!editLocations) {
        Get.back(); // Close address bottom sheet if open
      }
      // Get.back();
    } else {
      updateProfileStatus.value = RxStatus.success();
      showCustomSnackBar("Something went wrong", isError: false);
    }
  }

  void updateAddress(int index, SavedAddress updatedAddress) {
    if (index >= 0 && index < savedAddresses.length) {
      savedAddresses[index] = updatedAddress;
      savedAddresses.refresh();
      if (updatedAddress.isSelected) {
        String fullAddress = updatedAddress.address;
        if (updatedAddress.unit != null && updatedAddress.unit!.isNotEmpty) {
          fullAddress = '${updatedAddress.unit}, $fullAddress';
        }
        if (updatedAddress.street != null &&
            updatedAddress.street!.isNotEmpty) {
          fullAddress = '${updatedAddress.street}, $fullAddress';
        }
        additionalAddressController.value.text = fullAddress;
      }
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

  //========= Address Management Methods ===========//

  // Show bottom sheet for address selection
  void showAddressBottomSheet({bool isFromProfile = false}) { 
    Get.bottomSheet(
       AddressSelectionBottomSheet( 
        isFromProfile: isFromProfile, 
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

  TextEditingController streetController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController directionsController = TextEditingController();
  TextEditingController addressNameController = TextEditingController();

  // Add new address to the list
  void addNewAddress({
    bool isFromProfile = false,
    required String title,
    required String address,
    String? unit,
    String? street,
    String? directions,
    double? latitude,
    double? longitude,
  }) {
    debugPrint('=== Adding New Address ===');
    debugPrint('Title: $title');
    debugPrint('Address: $address');
    // PATCH address for a specific location
    // Future<void> patchAddress({
    //   required String locationId,
    //   required String address,
    //   required List<double> coordinates,
    // }) async {
    //   try {
    //     final String userId = await SharePrefsHelper.getString(
    //       AppConstants.userId,
    //     );
    //     final Map<String, dynamic> body = {
    //       "address": address,
    //       "street": streetController.text,
    //       "unit": unitController.text,
    //       "coordinates": coordinates,
    //       "detraction": directionsController.text,
    //       "name": addressNameController.text,
    //     };
    //     final response = await ApiClient.patchData(
    //       "/customers/$userId/locations/$locationId",
    //       jsonEncode(body),
    //     );
    //     if (response.statusCode == 200 || response.statusCode == 201) {
    //       showCustomSnackBar(
    //         response.body['message'] ?? "Address updated successfully",
    //         isError: false,
    //       );
    //       getMe();
    //       Get.back();
    //     } else {
    //       showCustomSnackBar(
    //         response.body['message'] ?? "Something went wrong",
    //         isError: true,
    //       );
    //     }
    //   } catch (e) {
    //     showCustomSnackBar(AppStrings.checknetworkconnection, isError: true);
    //   }
    // }

    debugPrint('Unit: $unit');
    debugPrint('Street: $street');
    debugPrint('Directions: $directions');
    debugPrint('City: ${cityController.value.text}');

    // Deselect all existing addresses
    for (int i = 0; i < savedAddresses.length; i++) {
      savedAddresses[i] = savedAddresses[i].copyWith(isSelected: false);
    }

    // Create new address and mark it as selected
    final newAddress = SavedAddress(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      address: address,
      unit: unit,
      street: street,
      direction: directions,
      city:
          cityController.value.text.isNotEmpty
              ? cityController.value.text
              : 'Not specified',
      latitude: latitude,
      longitude: longitude,
      isSelected: true, // Automatically select the new address
    );

    savedAddresses.add(newAddress);
    debugPrint(
      'Address added to list. Total addresses: ${savedAddresses.length}',
    );

    // Update the additional address controller to show the selected address
    String fullAddress = newAddress.address;
    if (unit != null && unit.isNotEmpty) {
      fullAddress = '$unit, $fullAddress';
    }
    if (street != null && street.isNotEmpty) {
      fullAddress = '$street, $fullAddress';
    }
    additionalAddressController.value.text = fullAddress;
    debugPrint('Additional address controller updated: $fullAddress');

    // Trigger UI update
    savedAddresses.refresh();
    if (isFromProfile) {
      updateProfile(editLocations: true);
    } else {
      updateProfile();
    }

    // Get.snackbar(
    //   '✓ Success'.tr,
    //   'Address added successfully'.tr,
    //   backgroundColor: Colors.green,
    //   colorText: Colors.white,
    //   duration: const Duration(seconds: 2),
    //   snackPosition: SnackPosition.BOTTOM,
    //   margin: EdgeInsets.all(16),
    //   borderRadius: 8,
    //   icon: const Icon(Icons.check_circle, color: Colors.white),
    // );
  }

  // Select an address from the list
  void selectAddress(int index) {
    // Deselect all addresses
    for (int i = 0; i < savedAddresses.length; i++) {
      savedAddresses[i] = savedAddresses[i].copyWith(isSelected: false);
    }

    // Select the chosen address
    savedAddresses[index] = savedAddresses[index].copyWith(isSelected: true);

    final selectedAddress = savedAddresses[index];

    // Update additional address controller
    String fullAddress = selectedAddress.address;
    if (selectedAddress.unit != null && selectedAddress.unit!.isNotEmpty) {
      fullAddress = '${selectedAddress.unit}, $fullAddress';
    }
    if (selectedAddress.street != null && selectedAddress.street!.isNotEmpty) {
      fullAddress = '${selectedAddress.street}, $fullAddress';
    }
    additionalAddressController.value.text = fullAddress;

    savedAddresses.refresh();
  }

  // Get selected address
  SavedAddress? getSelectedAddress() {
    try {
      return savedAddresses.firstWhere((address) => address.isSelected);
    } catch (e) {
      return null;
    }
  }
}
