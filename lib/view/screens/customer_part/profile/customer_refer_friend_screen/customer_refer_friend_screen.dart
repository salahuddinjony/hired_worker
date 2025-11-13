import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_images/app_images.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import '../../../../../utils/app_colors/app_colors.dart';

class CustomerReferFriendScreen extends StatelessWidget {
  const CustomerReferFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Refer a Friend".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            const Center(child: CustomImage(imageSrc: AppImages.referImage)),
            CustomText(
              top: 20.h,
              text: "Refer a Friend &\nGet 50% off",
              fontSize: 32.w,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
            CustomText(
              top: 20.h,
              text: "Get 50% off upto \$20 after your friend’s 1st order",
              fontSize: 14.w,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
            ),
            CustomText(
              top: 20.h,
              text: "Your friend gets 50% off on their 1st order",
              fontSize: 14.w,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              bottom: 50,
            ),
            CustomButton(
              width: MediaQuery.sizeOf(context).width / 2,
              onTap: () {},
              title: "Refer a Friend".tr,
            ),
          ],
        ),
      ),
    );
  }
}
