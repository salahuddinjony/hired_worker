import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/order/controller/customer_order_controller.dart';
import '../../../../../utils/app_colors/app_colors.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  Widget buildStar(CustomerOrderController controller, int index) {
    return Obx(() {
      final filled = index <= controller.rating.value;
      return GestureDetector(
        onTap: () => controller.setRating(index),
        child: Icon(
          Icons.star,
          size: 40.sp,
          color: filled ? Colors.amber : Colors.grey,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerOrderController>();
    final Map<String, dynamic> args = Get.arguments;
    final String contractorId = args['contractorId'] ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: CustomText(
          text: 'Ratting'.tr,
          fontSize: 18.w,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            SizedBox(height: 24.h),
            CustomText(
              text: 'How do you want to rate the service'.tr,
              fontSize: 14.w,
              color: Colors.black38,
            ),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => buildStar(controller, i + 1)),
            ),
            SizedBox(height: 24.h),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.reviewTextController,
                maxLines: 6,
                decoration: InputDecoration.collapsed(
                  hintText: 'Write a review'.tr,
                ),
              ),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              title: 'Review'.tr,
              onTap: () async {
                final success = await controller.submitReview(
                  contractorId: contractorId,
                  rating: controller.rating.value,
                  review: controller.reviewTextController.text,
                );

                if (success) {
                  controller.clearReview();
                  Get.back();
                }
              },
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () {
                controller.clearReview();
                Get.back();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomText(
                    text: 'Not Now'.tr,
                    color: AppColors.primary,
                    fontSize: 16.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
