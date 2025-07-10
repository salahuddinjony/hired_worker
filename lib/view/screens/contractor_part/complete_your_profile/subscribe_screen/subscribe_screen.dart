import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/widget/subscription_card.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Select Your Plan".tr,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SubscriptionCard(
                planName: "Gold".tr,
                price: "99.99 \$",
                duration: "Monthly".tr,
                features: List.generate(6, (_) => "First Feature Here"),
                onSubscribe: () {
                  // Handle Gold plan subscription
                },
              ),
              SubscriptionCard(
                planName: "Platinum".tr,
                price: "149.99 \$",
                duration: "Monthly".tr,
                features: List.generate(6, (_) => "First Feature Here"),
                onSubscribe: () {
                  // Handle Platinum plan subscription
                },
              ),
              SubscriptionCard(
                planName: "Diamond".tr,
                price: "249.99 \$",
                duration: "Monthly".tr,
                features: List.generate(6, (_) => "First Feature Here"),
                onSubscribe: () {
                  // Handle Diamond plan subscription
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
