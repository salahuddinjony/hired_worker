import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/controller/photo_upload_controller.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/widget/custom_ongoing_card.dart';

import '../../../../components/custom_button/custom_button.dart';

class UploadPhotoScreen extends StatelessWidget {
  const UploadPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PhotoUploadController controller = Get.find<PhotoUploadController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Photo Upload".tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // in progress card
            CustomOngoingCard(index: Get.arguments['id'], isShowButton: false),

            // image adding field
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
              return controller.status.value.isLoading ? const CustomLoader() : SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  height: 45,
                  onTap: controller.finishService,
                  title: "Finish".tr,
                  fillColor: AppColors.primary,
                ),
              );
            },),
          ],
        ),
      ),
    );
  }
}
