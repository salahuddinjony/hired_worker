import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import 'widget/custom_ongoing_card.dart';

class OnGoingScreen extends StatelessWidget {
  const OnGoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "On Going"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: Icon(Icons.access_time, size: 45)),
            CustomText(
              text: "03 : 22 PM",
              fontSize: 32.w,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
            Column(
              children: List.generate(4, (value){
                return CustomOngoingCard();
              })
            )
          ],
        ),
      ),
    );
  }
}
