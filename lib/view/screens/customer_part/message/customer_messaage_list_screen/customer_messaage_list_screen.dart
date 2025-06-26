import 'package:flutter/material.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../contractor_part/message/message_list_screen/widget/custom_message_list_card.dart';

class CustomerMessaageListScreen extends StatelessWidget {
  const CustomerMessaageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(      extendBody: true,

      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Messages"),
      body: Column(
          children: List.generate(5, (value){
            return CustomMessageListCard();
          })
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 2),
    );
  }
}
