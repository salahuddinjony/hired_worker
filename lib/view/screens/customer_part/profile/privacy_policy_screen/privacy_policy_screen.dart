import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Privacy Policy",),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            CustomText(text: "Welcome to Razco Foods. Razco provides access to the mobile application/app  to you subject to the terms and conditions (“Terms”) set out on this page. By using the Website, you, a registered or guest user in terms of the eligibility criteria set out herein (“User”) agree to be bound by the Terms. Please read them carefully as your continued usage of the Website, you signify your agreement to be bound by these Terms. If you do not want to be bound by the Terms, you must not subscribe to or use the Website or our services.",
              fontSize: 18.w,
              fontWeight: FontWeight.w400,
              color: AppColors.black,
              textAlign: TextAlign.justify,
              maxLines: 20,
            )
          ],
        ),
      ),
    );
  }
}
