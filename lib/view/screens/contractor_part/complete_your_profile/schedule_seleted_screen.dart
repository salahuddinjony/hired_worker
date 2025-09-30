import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/schedule_selection_controller.dart';

import '../../../components/custom_loader/custom_loader.dart';

class ScheduleSelectedScreen extends StatefulWidget {
  const ScheduleSelectedScreen({super.key});

  @override
  State<ScheduleSelectedScreen> createState() => _ScheduleSelectedScreenState();
}

class _ScheduleSelectedScreenState extends State<ScheduleSelectedScreen> {
  final List<String> days = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  final Set<String> selectedDays = {};

  void toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScheduleSelectionController controller =
        Get.find<ScheduleSelectionController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Selecte Times".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              "Set up your personal information.".tr,
              style: TextStyle(color: Colors.black87),
            ),
            Text(
              "You can always change it later.".tr,
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: days.length,
                itemBuilder: (context, index) {
                  final day = days[index];
                  final isSelected = selectedDays.contains(day);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: GestureDetector(
                      onTap: () => toggleDay(day),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              isSelected
                                  ? const Color(
                                    0xFF3C003D,
                                  ).withValues(alpha: 0.1)
                                  : Colors.transparent,
                        ),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    isSelected
                                        ? const Color(0xFF3C003D)
                                        : const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                isSelected ? Icons.check : Icons.add,
                                size: 20,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                '$day - 09 : 00 AM - 11 : 00 PM',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              return controller.status.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                      controller.updateContractorData(selectedDays);
                    },
                    title: "Continue".tr,
                  );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
