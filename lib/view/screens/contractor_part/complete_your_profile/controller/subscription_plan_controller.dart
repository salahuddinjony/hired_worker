import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/model/subscription_plan_model.dart';

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
      status.value = RxStatus.error();
    }
  }
}
