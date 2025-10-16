import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/model/subscription_plan_model.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/subscribe_screen/purchase_screen.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';

class SubscriptionPlanController extends GetxController {
  // for plans
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  Rx<SubscriptionPlanModel> subscriptionPlan = SubscriptionPlanModel().obs;

  @override
  void onInit() {
    super.onInit();

    getPlans();
  }

  Future<void> getPlans() async {
    status.value = RxStatus.loading();

    try {
      final response = await ApiClient.getData(ApiUrl.subscriptionPlanList);

      subscriptionPlan.value = SubscriptionPlanModel.fromJson(response.body);

      if (subscriptionPlan.value.data == null ||
          subscriptionPlan.value.data!.isEmpty) {
        status.value = RxStatus.empty();
      } else {
        status.value = RxStatus.success();
      }
    } catch (e) {
      debugPrint('xxx' + e.toString());
      status.value = RxStatus.error();
    }
  }

  Future<void> purchase(String id, num amount) async {
    status.value = RxStatus.loading();

    final Map<String, dynamic> body = {"planId": id, "amount": amount};

    try {
      final response = await ApiClient.postData(
        ApiUrl.purchaseSubscriptionPlan,
        jsonEncode(body),
      );

      if (response.statusCode == 200) {
        status.value = RxStatus.success();
        Get.to(() => PurchaseScreen(url: response.body['data']));
      } else {
        showCustomSnackBar('Something went wrong. Please try again.');
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }

    status.value = RxStatus.success();
  }
}
