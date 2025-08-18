import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../../../../core/app_routes/app_routes.dart';
class CertificateUploadController extends GetxController {
  ///================ CV and Certificate Upload ==================
  var nidFile = Rx<File?>(null);
  Future<void> pickNidFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      nidFile.value = File(pickedFile.files.single.path!);
    }
  }


  ///================== CertificateFile ===============
  var skillFile = Rx<File?>(null);

  Future<void> skillsFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      skillFile.value = File(pickedFile.files.single.path!);
    }
  }

  ///================== CertificateFile ===============
  var otherFile = Rx<File?>(null);

  Future<void> otherSFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      otherFile.value = File(pickedFile.files.single.path!);
    }
  }

  Future<void> updateContractorData() async {
    print(nidFile);
    print(skillFile);
    print(otherFile);

    Get.toNamed(AppRoutes.skillsAddScreen);
  }
}