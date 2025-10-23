import 'dart:convert';

import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/profile/eran_screen/withdraw_screen.dart';
import 'package:servana/view/screens/contractor_part/profile/model/withdraw_model.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';

class WithdrawController extends GetxController {
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());

  Future<void> withdraw(num amount) async {
    status.value = RxStatus.loading();

    final Map<String, dynamic> body = {"amount": amount};

    try {
      final response = await ApiClient.patchData(
        ApiUrl.withdraw,
        jsonEncode(body),
      );

      final WithdrawModel withdrawModel = WithdrawModel.fromJson(response.body);

      if (withdrawModel.data?.url != null) {
        showCustomSnackBar("Please add your bank details first.", isError: false,);

        final bool? result = await Get.to(
          () => WithdrawScreen(url: withdrawModel.data!.url!),
        );

       if (result != null && result) {
          showCustomSnackBar("Your bank details have been added successfully.", isError: false,);
          showCustomSnackBar("Your withdrawal is being processed.", isError: false,);

          withdraw(amount);
          return;
        } else {
          showCustomSnackBar('Something went wrong. Please try again later.');
        }
      } else {
        showCustomSnackBar(withdrawModel.data?.message, isError: false,);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }

    status.value = RxStatus.success();
  }
}
