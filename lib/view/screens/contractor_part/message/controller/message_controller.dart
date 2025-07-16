import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/screens/contractor_part/message/model/message_room_model.dart';

class MessageController extends GetxController {
  @override
  onInit() {
    getAllRoomList();
    super.onInit();
  }

  Rx<RxStatus> getAllRoomListStatus = Rx<RxStatus>(RxStatus.success());
  Rx<AllMessageRoomModel> allMessageRoomModel = AllMessageRoomModel().obs;
  Future<void> getAllRoomList() async {
    try {
      getAllRoomListStatus.value = RxStatus.loading();
      final userId = await SharePrefsHelper.getString(AppConstants.userId);
      var response = await ApiClient.getData(
        ApiUrl.allMessageRoom(userId: userId),
      );
      if (response.statusCode == 200) {
        allMessageRoomModel.value = AllMessageRoomModel.fromJson(response.body);
        getAllRoomListStatus.value = RxStatus.success();
        refresh();
      } else {
        getAllRoomListStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
        refresh();
      }
    } catch (e) {
      getAllRoomListStatus.value = RxStatus.error();
      debugPrint('Error: $e');
      refresh();
    }
  }
}
