import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_check.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/service/socket_service.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/screens/contractor_part/message/model/conversation_model.dart';
import 'package:servana/view/screens/contractor_part/message/model/message_room_model.dart';

class MessageController extends GetxController {
  @override
  onInit() {
    SocketApi.init();
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

  //============ all message ==============

  // final RxList<Map<String, dynamic>> messages =
  //     <Map<String, dynamic>>[
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Enim posuere aenean enim malesuada diam donec augue facilisi.',
  //         'isSent': false,
  //       },
  //       {'text': 'Hello', 'isSent': false},
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Enim posuere aenean enim malesuada diam donec augue facilisi.',
  //         'isSent': false,
  //       },
  //       {'text': 'Hello', 'isSent': false},
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //       {
  //         'text':
  //             'Lorem ipsum dolor sit amet consectetur. Fringilla vitae dolor.',
  //         'isSent': true,
  //       },
  //     ].obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  final ScrollController scrollController = ScrollController();
  // void handleSend() {
  //   // final text = controller.text.trim();
  //   // if (text.isEmpty) return;

  //   // // messages.add({'text': text, 'isSent': true});
  //   // controller.clear();
  //   // SocketApi.sendEvent('sendMessage', text);
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     scrollController.animateTo(
  //       scrollController.position.maxScrollExtent + 100,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeOut,
  //     );
  //   });
  // }

  //=============== send message ================

   sendMessage({required String receiverId, required String chatRoomId}) async {
    final userId = await SharePrefsHelper.getString(AppConstants.userId);
    var body = {
      "chatRoomId": chatRoomId,
      "sender": userId,
      "receiver": receiverId,
      "message": messageController.value.text,
    };

    
      SocketApi.sendEvent('sendMessage', body);
    

    // getConversation(otherId: receiverId);
    debugPrint(
        'messageController.value.text=====================>>  ${messageController.value.text}');
    messageController.value.clear();
    // getConversation(otherId: receiverId);
    // imageUrls.clear();
  }

  //============ all message ==============
  Rx<RxStatus> getAllMessageListStatus = Rx<RxStatus>(RxStatus.success());
  Rx<ConvarsationModel> convarsationModel = ConvarsationModel().obs;
  Future<void> getAllMessageList(String roomId) async {
    try {
      getAllMessageListStatus.value = RxStatus.loading();
      var response = await ApiClient.getData(ApiUrl.allMessage(roomId: roomId));
      if (response.statusCode == 200) {
        convarsationModel.value = ConvarsationModel.fromJson(response.body);
        getAllMessageListStatus.value = RxStatus.success();
        refresh();
      } else {
        getAllMessageListStatus.value = RxStatus.error();
        ApiChecker.checkApi(response);
        refresh();
      }
    } catch (e) {
      getAllMessageListStatus.value = RxStatus.error();
      debugPrint('Error: $e');
      refresh();
    }
  }
}
