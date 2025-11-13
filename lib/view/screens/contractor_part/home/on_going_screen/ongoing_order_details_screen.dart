import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/home/on_going_screen/widget/custom_ongoing_card.dart';

import '../model/booking_model.dart';
import 'controller/on_going_controller.dart';

class OngoingOrderDetailsScreen extends StatefulWidget {
  const OngoingOrderDetailsScreen({super.key});

  @override
  State<OngoingOrderDetailsScreen> createState() =>
      _OngoingOrderDetailsScreenState();
}

class _OngoingOrderDetailsScreenState extends State<OngoingOrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Create a unique loading state for this booking
    final BookingModelData data =
        Get.find<OnGoingController>().onGoingBookingList[Get
            .arguments['index']];

    return Scaffold(
      extendBody: true,
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Request".tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // first card
            CustomOngoingCard(
              index: Get.arguments['index'],
              isShowButton: false,
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
                  Text('Task/Service : ${data.subCategoryId?.name ?? " - "}'),
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
                                Text('\$${e.price}'),
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
                      Text(
                        '${data.bookingType == "oneTime" ? "One Time" : "Weekly"}',
                      ),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Date: '),
                      Text(
                        data.day == null || data.day!.isEmpty
                            ? " - "
                            : data.day!.length >= 2
                            ? data.day!.join('\n')
                            : "${data.day?[0] ?? " - "}",
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Time: '),
                      Text("${data.startTime ?? " "} - ${data.endTime ?? " "}"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }
}
