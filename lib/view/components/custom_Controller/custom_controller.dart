import 'package:get/get.dart';

class CustomController extends GetxController {
  RxInt currentIndex = 0.obs;

  RxList<String> cetagoryList = ["Male", "Female"].obs;
  RxString selectedGender = "Male".obs;

  RxList<String> specializationList =
      ["Cardiology", "Neurology", "Urology"].obs;
  RxString selectedSpecialization = "Cardiology".obs;
}
