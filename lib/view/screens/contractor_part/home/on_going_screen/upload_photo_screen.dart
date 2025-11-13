import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/photo_upload_controller.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/widget/custom_ongoing_card.dart';

import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_text/custom_text.dart';
import '../model/booking_model.dart';
import 'controller/on_going_controller.dart';

class UploadPhotoScreen extends StatelessWidget {
  const UploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PhotoUploadController controller = Get.find<PhotoUploadController>();
    final BookingModelData data =
        Get.find<OnGoingController>().onGoingBookingList[Get.arguments['id']];
    final bool isWeekly = data.bookingType! == 'weekly';

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Photo Upload".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // in progress card
            CustomOngoingCard(index: Get.arguments['id'], isShowButton: false),

            const Divider(height: 50),
            const SizedBox(height: 10),

            // date with "Mark as Completed"  button
            if (isWeekly)
              Obx(() {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children:
                              data.bookingDateAndStatus!.asMap().entries.map((
                                e,
                              ) {
                                final bool isIncomplete =
                                    data.bookingDateAndStatus![e.key].status ==
                                    'in_complete';

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                        text: data
                                            .bookingDateAndStatus![e.key]
                                            .date
                                            .toString()
                                            .substring(0, 11),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                        bottom: 4.h,
                                      ),

                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.4,
                                        child: CustomButton(
                                          height: 45,
                                          onTap: () {
                                            if (isIncomplete) {
                                              controller.selectDate(e.key);
                                            }
                                          },
                                          title:
                                              isIncomplete
                                                  ? (controller
                                                              .selectedDateIndex
                                                              .value ==
                                                          e.key
                                                      ? 'Selected'
                                                      : 'Mark as Complete')
                                                  : 'Completed',
                                          fontSize: 14.sp,
                                          fillColor:
                                              isIncomplete
                                                  ? (controller
                                                              .selectedDateIndex
                                                              .value ==
                                                          e.key
                                                      ? Colors.blueGrey
                                                      : AppColors.primary)
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ),

                    const Divider(height: 50),

                    // material list
                    Column(
                      children:
                          data.material!.map((material) {
                            if (material.count != null && material.count! > 0) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: material.name ?? 'Material',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                    Row(
                                      children: [
                                        // - Button
                                        IconButton(
                                          onPressed:
                                              () => controller.decreaseQuantity(
                                                material.id!,
                                              ),
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 20,
                                          ),
                                        ),

                                        // Quantity
                                        Obx(
                                          () => Text(
                                            '${controller.getQuantity(material.id!)}',
                                            style: TextStyle(fontSize: 14.sp),
                                          ),
                                        ),

                                        // + Button
                                        IconButton(
                                          onPressed:
                                              () => controller.increaseQuantity(
                                                material.id!,
                                                material.count!,
                                              ),
                                          icon: const Icon(Icons.add, size: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }).toList(),
                    ),
                  ],
                );
              }),

            const Divider(),

            // image adding field with finish button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: controller.workImages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: controller.pickWorkImages,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              width: 1.1,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    return FutureBuilder(
                      future: controller.workImages[index - 1].readAsBytes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          );
                        }
                        return Container(color: Colors.grey[300]);
                      },
                    );
                  },
                ),
              ),
            ),

            Obx(() {
              return controller.status.value.isLoading
                  ? const CustomLoader()
                  : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: CustomButton(
                      height: 45,
                      onTap:
                          isWeekly
                              ? controller.finishWeeklyService
                              : controller.finishService,
                      title: "Finish".tr,
                      fillColor: AppColors.primary,
                    ),
                  );
            }),

            const SizedBox(height: kBottomNavigationBarHeight),
          ],
        ),
      ),
    );
  }
}
