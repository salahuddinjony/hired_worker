import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class AudioCallScreen extends StatelessWidget {
  const AudioCallScreen(
      {super.key,
      required this.userName,
      required this.callId,
      required this.userId});

  final String userName;
  final String callId;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZegoUIKitPrebuiltCall(
          events: ZegoUIKitPrebuiltCallEvents(),
          onDispose: () {
            // controller.createCallHistory(
            //     senderId: senderID, receiverId: receiverId, userName: userName);
          },
          appID: 662723268,
          appSign: "58202b9af50bcea95ad16997f2cf1daf8d68f3ab96945904b4f050506e3078b0",
          callID: callId, //common
          userID: userId,
          userName: userName,
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()),
    );
  }
}
