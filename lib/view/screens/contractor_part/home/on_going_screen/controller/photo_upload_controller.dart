import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/on_going_controller.dart';
import '../../../../../../service/api_url.dart';

class PhotoUploadController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  late String bookingId;

  final ImagePicker _picker = ImagePicker();
  final RxList<XFile> workImages = <XFile>[].obs;

  @override
  void onInit() {
    super.onInit();

    bookingId =
        Get.find<OnGoingController>()
            .onGoingBookingList[Get.arguments['id']]
            .id!;
  }

  Future<void> pickWorkImages() async {
    final List<XFile>? pickedImages = await _picker.pickMultiImage();

    if (pickedImages != null) {
      workImages.addAll(pickedImages);
    }
  }

  Future<void> finishService() async {
    if (status.value.isLoading) return;

    status.value = RxStatus.loading();

    // patch
    final String endPoint = '${ApiUrl.bookings}/$bookingId';

   final body= {
    "status": "completed"
    };


    try {
      final response = await ApiClient.patchMultipartData(
        endPoint,
        body,
        multipartBody: workImages
            .map((image) => MultipartBody("file", File(image.path)))
            .toList(),
      );

      if (response.statusCode == 200) {
        Get.toNamed(
          AppRoutes.onGoingFinishScreen,
          arguments: {'id': Get.arguments['id']},
        );
      } else {
        showCustomSnackBar(response.body['message'], isError: false);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    } finally {
      status.value = RxStatus.success();
    }
  }
}
