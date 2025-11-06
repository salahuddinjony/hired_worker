import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/withdraw_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../controller/profile_controller.dart';
import 'widget/custom_earn_container.dart';

class EranScreen extends StatefulWidget {
  const EranScreen({super.key});

  @override
  State<EranScreen> createState() => _EranScreenState();
}

class _EranScreenState extends State<EranScreen> {
  final profileController = Get.find<ProfileController>();
  final WithdrawController withdrawController = Get.find<WithdrawController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(() {
        if (withdrawController.status.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  ),
                ),
                child: Column(
                  children: [
                    CustomRoyelAppbar(
                      leftIcon: true,
                      titleName: "My Balance".tr,
                      color: AppColors.white,
                      backgroundClr: Colors.transparent,
                    ),
                    Obx(() {
                      return CustomText(
                        text:
                            "\$${profileController.contractorModel.value.data?.contractor?.balance ?? " - "}",
                        fontSize: 20.w,
                        fontWeight: FontWeight.w500,
                        bottom: 10.h,
                      );
                    }),
                    CustomText(
                      text: "Available Balance".tr,
                      fontSize: 14.w,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white.withValues(alpha: .5),
                      bottom: 20.h,
                    ),
                    CustomButton(
                      width: 120.w,
                      height: 36.h,
                      onTap: () {
                        showAmountDialog(context);
                      },
                      title: "Withdraw".tr,
                      textColor: AppColors.primary,
                      fillColor: AppColors.white,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              CustomText(
                top: 10.h,
                left: 16.w,
                text: "Activity".tr,
                fontSize: 20.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                bottom: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: CustomTabBar(
                  tabs: withdrawController.nameList,
                  selectedIndex: withdrawController.currentIndex.value,
                  onTabSelected: (value) {
                    withdrawController.currentIndex.value = value;
                    setState(() {});
                    withdrawController.update();
                  },
                  selectedColor: AppColors.primary,
                  unselectedColor: AppColors.black_04,
                ),
              ),
              SizedBox(height: 10.h),

              if (withdrawController.currentIndex.value == 0)
                Obx(() {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      controller: withdrawController.receivedScrollController,
                      itemCount:
                          withdrawController.receivedList.length +
                          (withdrawController
                                  .statusForReceived
                                  .value
                                  .isLoadingMore
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if (index < withdrawController.receivedList.length) {
                          final data = withdrawController.receivedList[index];
                          return CustomEarnContainer(data: data);
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }),

              if (withdrawController.currentIndex.value == 1)
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    controller: withdrawController.rejectedScrollController,
                    itemCount:
                        withdrawController.rejectedList.length +
                        (withdrawController
                                .statusForRejected
                                .value
                                .isLoadingMore
                            ? 1
                            : 0),
                    itemBuilder: (context, index) {
                      if (index < withdrawController.rejectedList.length) {
                        final data = withdrawController.rejectedList[index];
                        return CustomEarnContainer(data: data);
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),

              // if (withdrawController.currentIndex.value == 2)
              //   Expanded(
              //     child: ListView(
              //       padding: EdgeInsets.zero,
              //       children: List.generate(2, (value) {
              //         return CustomEarnContainer(statusText: "Pending".tr);
              //       }),
              //     ),
              //   ),
            ],
          );
        }
      }),
    );
  }

  void showAmountDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Amount'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Enter amount'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                final num? amount = num.tryParse(value);
                if (amount == null) {
                  return 'Please enter a valid number';
                }
                if (amount <= 0) {
                  return 'Amount must be greater than 0';
                }
                return null; // Valid input
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String amount = amountController.text;
                  Navigator.of(context).pop();

                  Get.find<WithdrawController>().withdraw(num.parse(amount));
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
