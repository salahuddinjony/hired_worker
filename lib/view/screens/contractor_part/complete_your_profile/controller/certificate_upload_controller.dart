import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../utils/app_const/app_const.dart';

class CertificateUploadController extends GetxController {
  var skillFile = Rx<File?>(null);
  var otherFile = Rx<File?>(null);
  var certificate = Rx<File?>(null);

  String certificateUrl = '';
  String skillUrl = '';
  String otherUrl = '';

  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  Future<void> pickSkillFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      skillFile.value = File(pickedFile.files.single.path!);
    }
  }

  Future<void> pickOtherFile() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      otherFile.value = File(pickedFile.files.single.path!);
    }
  }

  Future<void> pickCertificate() async {
    final pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pickedFile != null && pickedFile.files.single.path != null) {
      certificate.value = File(pickedFile.files.single.path!);
    }
  }

  Future<void> uploadAllFiles() async {
    status.value = RxStatus.loading();

    try {
      
      if (certificate.value != null) {
        certificateUrl = await _uploadFile(certificate.value!);
      }

      if (skillFile.value != null) {
        skillUrl = await _uploadFile(skillFile.value!);
      }

      if (otherFile.value != null) {
        otherUrl = await _uploadFile(otherFile.value!);
      }

      showCustomSnackBar("All files uploaded successfully!", isError: false);

      
      await updateContractorData();

      Get.toNamed(AppRoutes.skillsAddScreen);

    } catch (e, stackTrace) {
      debugPrint("Upload Error: $e");
      debugPrint("StackTrace: $stackTrace");
      showCustomSnackBar("Error uploading files: $e", isError: true);
      status.value = RxStatus.error();
    } finally {
      status.value = RxStatus.success();
    }
  }

  Future<void> updateContractorData() async {
    try {
      final String userId = await SharePrefsHelper.getString(AppConstants.userId);
      final String uri = '${ApiUrl.updateUser}/$userId';

      final Map<String, dynamic> data = {
        "certificates": [
          if (certificateUrl.isNotEmpty) certificateUrl,
          if (skillUrl.isNotEmpty) skillUrl,
          if (otherUrl.isNotEmpty) otherUrl,
        ]
      };

      final Map<String, String> body = {
        'data': jsonEncode(data),
      };

      final response = await ApiClient.patchMultipartData(
        uri,
        body,
        multipartBody: [],
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200 && responseBody['success'] == true) {
        showCustomSnackBar("Contractor data updated successfully!", isError: false);
        
      } else {
        throw Exception(responseBody['message'] ?? 'Failed to update contractor data');
      }

    } catch (e, stackTrace) {
      debugPrint("Update Contractor Error: $e");
      debugPrint("StackTrace: $stackTrace");
      showCustomSnackBar("Error updating contractor data: $e", isError: true);
      rethrow; 
    }
  }

  Future<String> _uploadFile(File file) async {
    try {
      final multipartBody = [MultipartBody('file', file)];

      final response = await ApiClient.postMultipartData(
        ApiUrl.upload,
        <String, String>{},
        multipartBody: multipartBody,
      );

      final responseBody = jsonDecode(response.body);

      if (responseBody['success'] == true && responseBody['data'] != null) {
        return responseBody['data'];
      } else {
        throw Exception(responseBody['message'] ?? 'Upload failed');
      }
    } catch (e, stackTrace) {
      debugPrint("File Upload Error: $e");
      debugPrint("StackTrace: $stackTrace");
      throw Exception("Failed to upload file: $e");
    }
  }
}
