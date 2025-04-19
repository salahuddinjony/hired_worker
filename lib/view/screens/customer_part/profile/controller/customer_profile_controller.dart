import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class CustomerProfileController extends GetxController{

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
}