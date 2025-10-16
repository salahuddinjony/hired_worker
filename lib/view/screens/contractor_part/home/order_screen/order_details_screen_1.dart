import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/order_screen/widget/custom_service_request_card.dart';

import '../../../../../utils/helper_methods/helper_methods.dart';
import '../../../../components/custom_button/custom_button.dart';
import '../model/booking_model.dart';
import 'controller/order_controller.dart';

class OrderDetailsScreen1 extends StatefulWidget {
  const OrderDetailsScreen1({super.key});

  @override
  State<OrderDetailsScreen1> createState() => _OrderDetailsScreen1State();
}

class _OrderDetailsScreen1State extends State<OrderDetailsScreen1> {
  @override
  Widget build(BuildContext context) {
    final BookingModelData data =
        Get.find<OrderController>().pendingBookingList[Get.arguments['index']];

    return Scaffold(
      extendBody: true,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Request".tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // first card
            CustomServiceRequestCard(
              title: getSubCategoryName(data),
              rating:
                  data.contractorId?.contractor?.ratings?.toString() ?? ' - ',
              dateTime: data.updatedAt!,
              id: data.id!,
              image: data.contractorId?.img,
              status: '',
              isButtonShow: false,
              height: 100,
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
                                Text('${e.price}\$'),
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

            // accept & cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onTap: () async {
                    await Get.find<OrderController>().acceptOrder(data.id!);
                    Get.back();
                  },
                  title: "Accept".tr,
                  height: 26.h,
                  width: 70.w,
                  fontSize: 10.w,
                  borderRadius: 10,
                ),
                CustomButton(
                  onTap: () async {
                    await Get.find<OrderController>().cancelOrder(data.id!);
                    Get.back();
                  },
                  title: "Cancel".tr,
                  height: 26.h,
                  width: 50.w,
                  fontSize: 10.w,
                  fillColor: Colors.transparent,
                  isBorder: true,
                  textColor: AppColors.red,
                  borderRadius: 10,
                  borderWidth: .3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
