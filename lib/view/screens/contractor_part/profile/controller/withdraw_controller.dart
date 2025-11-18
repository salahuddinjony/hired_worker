import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/eran_screen/withdraw_screen.dart';
import 'package:servana/view/screens/contractor_part/profile/model/withdraw_history_model.dart';
import 'package:servana/view/screens/contractor_part/profile/model/withdraw_model.dart';

import '../../../../../service/api_client.dart';
import '../../../../../service/api_url.dart';
import '../../../../../utils/ToastMsg/toast_message.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class WithdrawController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxList<String> nameList =
      [
        AppStrings.receivedText,
        AppStrings.rejectedText,
        // AppStrings.requestedText,
      ].obs;

  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.success());
  Rx<RxStatus> statusForReceived = Rx<RxStatus>(RxStatus.loading());
  Rx<RxStatus> statusForRejected = Rx<RxStatus>(RxStatus.loading());

  RxList<WithdrawalData> receivedList = <WithdrawalData>[].obs;
  RxList<WithdrawalData> rejectedList = <WithdrawalData>[].obs;

  // for pending list
  ScrollController receivedScrollController = ScrollController();
  int receivedPageNumber = 1;
  bool isReceivedLock = false;

  // for delivered list
  ScrollController rejectedScrollController = ScrollController();
  int rejectedPageNumber = 1;
  bool isRejectedLock = false;

  @override
  void onInit() {
    super.onInit();

    callAllMethods();

    receivedScrollController.addListener(() {
      if (receivedScrollController.position.pixels ==
          receivedScrollController.position.maxScrollExtent) {
        getMoreReceivedData();
      }
    });

    rejectedScrollController.addListener(() {
      if (rejectedScrollController.position.pixels ==
          rejectedScrollController.position.maxScrollExtent) {
        getMoreRejectedData();
      }
    });
  }

  Future<void> callAllMethods() async {
    status.value = RxStatus.loading();

    await Future.wait([getReceivedData(), geRejectedData()]);

    status.value = RxStatus.success();
  }

  Future<void> getReceivedData() async {
    statusForReceived.value = RxStatus.loading();

    receivedList.clear();

    try {
      final receivedResponse = await ApiClient.getData(
        '${ApiUrl.withdraw}?status=received&page=$receivedPageNumber&limit=10',
      );

      final WithdrawHistoryModel withdrawHistoryModel =
          WithdrawHistoryModel.fromJson(receivedResponse.body);

      if (withdrawHistoryModel.data == null ||
          withdrawHistoryModel.data!.withdrawals!.isEmpty) {
        statusForReceived.value = RxStatus.empty();
      } else {
        receivedList.addAll(withdrawHistoryModel.data!.withdrawals!);
        statusForReceived.value = RxStatus.success();
      }
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
      statusForReceived.value = RxStatus.error(
        'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> getMoreReceivedData() async {
    if (statusForReceived.value.isLoading ||
        statusForReceived.value.isLoadingMore ||
        isReceivedLock)
      return;

    statusForReceived.value = RxStatus.loadingMore();
    receivedPageNumber++;

    try {
      final pendingServiceResponse = await ApiClient.getData(
        '${ApiUrl.withdraw}?status=received&page=$receivedPageNumber&limit=10',
      );

      final WithdrawHistoryModel withdrawHistoryModel =
          WithdrawHistoryModel.fromJson(pendingServiceResponse.body);

      if (withdrawHistoryModel.data == null ||
          withdrawHistoryModel.data!.withdrawals!.isEmpty) {
        showCustomSnackBar('No more data load');
        isReceivedLock = true;
      } else {
        receivedList.addAll(withdrawHistoryModel.data!.withdrawals!);
      }
    } catch (e) {
      receivedPageNumber--;
      debugPrint('xxx ${e.toString()}');
      showCustomSnackBar(e.toString());
    }

    statusForReceived.value = RxStatus.success();
  }

  Future<void> geRejectedData() async {
    statusForRejected.value = RxStatus.loading();

    rejectedList.clear();

    try {
      final rejectedResponse = await ApiClient.getData(
        '${ApiUrl.withdraw}?status=rejected',
      );

      final WithdrawHistoryModel withdrawHistoryModel =
          WithdrawHistoryModel.fromJson(rejectedResponse.body);

      if (withdrawHistoryModel.data == null ||
          withdrawHistoryModel.data!.withdrawals!.isEmpty) {
        statusForRejected.value = RxStatus.empty();
      } else {
        rejectedList.addAll(withdrawHistoryModel.data!.withdrawals!);
        statusForRejected.value = RxStatus.success();
      }
    } catch (e) {
      debugPrint('xxx ${e.toString()}');
      statusForRejected.value = RxStatus.error(
        'Something went wrong. Please try again later.',
      );
    }
  }

  Future<void> getMoreRejectedData() async {
    if (statusForRejected.value.isLoadingMore ||
        statusForRejected.value.isLoading ||
        isRejectedLock)
      return;
    statusForRejected.value = RxStatus.loadingMore();
    rejectedPageNumber++;

    try {
      final rejectedResponse = await ApiClient.getData(
        '${ApiUrl.withdraw}?status=rejected&page=$rejectedPageNumber&limit=10',
      );

      final WithdrawHistoryModel withdrawHistoryModel =
          WithdrawHistoryModel.fromJson(rejectedResponse.body);

      if (withdrawHistoryModel.data == null ||
          withdrawHistoryModel.data!.withdrawals!.isEmpty) {
        showCustomSnackBar('No more data load');
        isRejectedLock = true;
      } else {
        rejectedList.addAll(withdrawHistoryModel.data!.withdrawals!);
      }
    } catch (e) {
      rejectedPageNumber--;
      debugPrint('xxx ${e.toString()}');
      showCustomSnackBar(e.toString());
    }

    statusForRejected.value = RxStatus.success();
  }

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
        showCustomSnackBar(
          "Please add your bank details first.",
          isError: false,
        );

        final bool? result = await Get.to(
          () => WithdrawScreen(url: withdrawModel.data!.url!),
        );

        if (result != null && result) {
          showCustomSnackBar(
            "Your bank details have been added successfully.",
            isError: false,
          );
          showCustomSnackBar(
            "Your withdrawal is being processed.",
            isError: false,
          );

          withdraw(amount);
          return;
        } else {
          showCustomSnackBar('Something went wrong. Please try again later.');
        }
      } else {
        showCustomSnackBar(withdrawModel.data?.message, isError: false);
      }
    } catch (e) {
      showCustomSnackBar(e.toString());
    }

    Get.find<ProfileController>().getMe();

    status.value = RxStatus.success();
  }
}
