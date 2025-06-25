import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/widget/subscription_card.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Select Your Plan"),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SubscriptionCard(
                planName: "Gold",
                price: "99.99 \$",
                duration: "Monthly",
                features: List.generate(6, (_) => "First Feature Here"),
                onSubscribe: () {
                  // Handle Gold plan subscription
                },
              ),
              SubscriptionCard(
                planName: "Platinum",
                price: "149.99 \$",
                duration: "Monthly",
                features: List.generate(6, (_) => "First Feature Here"),
                onSubscribe: () {
                  // Handle Platinum plan subscription
                },
              ),
              SubscriptionCard(
                planName: "Diamond",
                price: "249.99 \$",
                duration: "Monthly",
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
