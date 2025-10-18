import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/order_screen/widget/custom_delivered_service_card.dart';
import 'package:servana/view/screens/contractor_part/home/order_screen/widget/custom_service_request_card.dart';

import '../../../../../utils/helper_methods/helper_methods.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../model/booking_model.dart';
import 'controller/order_controller.dart';

class OrderDetailsScreen2 extends StatefulWidget {
  const OrderDetailsScreen2({super.key});

  @override
  State<OrderDetailsScreen2> createState() => _OrderDetailsScreen2State();
}

class _OrderDetailsScreen2State extends State<OrderDetailsScreen2> {
  @override
  Widget build(BuildContext context) {
    final BookingModelData data =
        Get.find<OrderController>().completedBookingList[Get
            .arguments['index']];

    return Scaffold(
      extendBody: true,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Request".tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // first card
            CustomDeliveredServiceCard(
              title: getSubCategoryName(data),
              rating:
                  data.contractorId?.contractor?.ratings?.toString() ?? ' - ',
              dateTime: data.updatedAt!,
              image: data.contractorId?.img,
              isButtonShow: false,
              height: 100,
              price: (data.totalAmount ?? " - ").toString(),
            ),

            const SizedBox(height: 16.0),

            // images
            if (data.files != null && data.files!.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children:
                    data.files!.map((e) {
                      return Image.network(
                        e['url'],
                        height: 120,
                        width: 120,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null)
                            return child;
                          return const SizedBox(
                            height: 120,
                            width: 120,
                            child: const Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const SizedBox(
                            height: 120,
                            width: 120,
                            child: Center(
                              child: Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
              ),

            const SizedBox(height: 16.0),

            // details under card
            Container(
              decoration: BoxDecoration(
                color: AppColors.cardClr,
                borderRadius: BorderRadiusGeometry.circular(8.0),
              ),
              margin: const EdgeInsetsGeometry.symmetric(horizontal: 16.0),
              padding: const EdgeInsetsGeometry.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Service Contractor',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    thickness: 1.6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(data.contractorId?.fullName ?? " - "),
                      // Text('${data.contractorId}\$/h'),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Category/SubCategory : ${data.subCategoryId?.name ?? " - "}',
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Materials',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    thickness: 1.6,
                  ),
                  if (data.material != null && data.material!.isNotEmpty)
                    Column(
                      children:
                          data.material!.map((e) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('• ${e.name} - ${e.count} ${e.unit}'),
                                Text('AUD ${e.price}'),
                              ],
                            );
                          }).toList(),
                    ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Question',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    thickness: 1.6,
                  ),
                  if (data.questions != null && data.questions!.isNotEmpty)
                    Column(
                      children:
                          data.questions!.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('• Question: ${e.question}?'),
                                  Text('• Answer : ${e.answer}'),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Booking Type',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    thickness: 1.6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Radio(
                        value: 'one_time',
                        groupValue: 'one_time',
                        onChanged: null,
                      ),
                      Text('${data.bookingType}'),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Day/Duration',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Divider(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    thickness: 1.6,
                  ),
                  Text(
                    data.day == null || data.day!.isEmpty
                        ? " - "
                        : data.day!.length == 2
                        ? "${data.day?[0] ?? " - "} - ${data.day?[1] ?? " - "}"
                        : "${data.day?[0] ?? " - "}",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32.0),

            // completed
            Center(
              child: CustomButton(
                onTap: () async {},
                title: "Completed".tr,
                height: 26.h,
                width: 100.w,
                fontSize: 10.w,
                fillColor: Colors.transparent,
                isBorder: true,
                textColor: AppColors.green,
                borderRadius: 6,
                borderWidth: .3,
              ),
            ),

            const SizedBox(height: kBottomNavigationBarHeight,),
          ],
        ),
      ),
    );
  }
}
