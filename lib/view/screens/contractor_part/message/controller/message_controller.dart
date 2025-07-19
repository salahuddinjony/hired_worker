import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/service/socket_service.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/screens/contractor_part/message/model/conversation_model.dart';
import 'package:servana/view/screens/contractor_part/message/model/message_room_model.dart'
    hide Datum;

class MessageController extends GetxController {
  final Rx<RxStatus> getAllRoomListStatus = Rx<RxStatus>(RxStatus.success());
  final Rx<AllMessageRoomModel> allMessageRoomModel = AllMessageRoomModel().obs;

  final Rx<RxStatus> getAllMessageListStatus = Rx<RxStatus>(RxStatus.success());
  final Rx<ConvarsationModel> conversationModel = ConvarsationModel().obs;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

 //  RxString userId = ''.obs;

  @override
  void onInit() async {
    super.onInit();
  //  userId.value = await SharePrefsHelper.getString(AppConstants.userId);
    
    getAllRoomList();
    receiveMessage();
  }

  Future<void> getAllRoomList() async { 

   final userId = await SharePrefsHelper.getString(AppConstants.userId);
    try {
      getAllRoomListStatus.value = RxStatus.loading();
      var response = await ApiClient.getData(
        ApiUrl.allMessageRoom(userId: userId),
      );

      if (response.statusCode == 200) {
        allMessageRoomModel.value = AllMessageRoomModel.fromJson(response.body);
        getAllRoomListStatus.value = RxStatus.success();
      } else {
        getAllRoomListStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      getAllRoomListStatus.value = RxStatus.error();
      debugPrint('Error in getAllRoomList: $e');
    }
  }

  Future<void> getAllMessageList(String roomId) async {
    try {
      getAllMessageListStatus.value = RxStatus.loading();
      var response = await ApiClient.getData(ApiUrl.allMessage(roomId: roomId));
      if (response.statusCode == 200) {
        conversationModel.value = ConvarsationModel.fromJson(response.body);
        getAllMessageListStatus.value = RxStatus.success();
      } else {
        getAllMessageListStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      getAllMessageListStatus.value = RxStatus.error();
      debugPrint('Error in getAllMessageList: $e');
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String chatRoomId,
  }) async {    
   final userId = await SharePrefsHelper.getString(AppConstants.userId); 

    debugPrint("userId============================= >> $userId");
    final messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    var body = {
      "chatRoomId": chatRoomId,
      "sender": userId,
      "receiver": receiverId,
      "message": messageText,
    }; 


    debugPrint("before send============================= >> ${body.toString()}");

    SocketApi.sendEvent('sendMessage', body);
    messageController.clear();
    scrollToBottom();
  }

  void receiveMessage() {
    SocketApi.listen('newMessage', (data) {
      try {
        debugPrint('📥 1111111112313213 New message: $data');
        final newMessage = Datum.fromJson(data);
        conversationModel.update((val) {
          val?.data ??= [];
          val?.data?.add(newMessage);
        });
        scrollToBottom();
      } catch (e) {
        debugPrint('❌ Error parsing message: $e');
      }
    });
  }

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
