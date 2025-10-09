import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/subscription_plan_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/widget/subscription_card.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../model/subscription_plan_model.dart';

class SubscribeScreen extends StatelessWidget {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SubscriptionPlanController controller =
        Get.find<SubscriptionPlanController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Select Your Plan".tr,
      ),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (controller.status.value.isEmpty) {
          return const Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Center(child: Text('No categories found')),
          );
        } else if (controller.status.value.isError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Column(
                children: [
                  Text(
                    controller.status.value.errorMessage ??
                        "Something went wrong. Please try again.",
                  ),
                  ElevatedButton(
                    onPressed: () {
                      controller.getPlans();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.all(20.h),
            child: SingleChildScrollView(
              child: Column(
                children:
                    List.generate(
                      controller.subscriptionPlan.value.data!.length,
                      (index) {
                        SubscriptionPlan subscriptionPlan =
                            controller.subscriptionPlan.value.data![index];

                        return SubscriptionCard(
                          planName: subscriptionPlan.subscriptionPlan ?? " - ",
                          price: "${subscriptionPlan.price ?? " - "}",
                          duration: subscriptionPlan.duration ?? " - ",
                          features: List.generate(
                            6,
                            (_) => "First Feature Here",
                          ),
                          onSubscribe: () {
                            Get.toNamed(AppRoutes.thanksScreen);
                          },
                        );
                      },
                    ).toList(),
              ),
            ),
          );
        }
      }),
    );
  }
}
