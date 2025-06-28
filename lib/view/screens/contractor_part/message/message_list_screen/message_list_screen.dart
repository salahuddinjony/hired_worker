import 'package:flutter/material.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'widget/custom_message_list_card.dart';

class MessageListScreen extends StatelessWidget {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Messages"),
      body: Column(
        children: List.generate(5, (value) {
          return CustomMessageListCard();
        }),
      ),
      bottomNavigationBar: Navbar(currentIndex: 2),
    );
  }
}
