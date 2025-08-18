import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/skill_selection_controller.dart';
import '../../../../core/app_routes/app_routes.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class SkillsAddScreen extends StatefulWidget {
  const SkillsAddScreen({super.key});

  @override
  State<SkillsAddScreen> createState() => _SkillsAddScreenState();
}

class _SkillsAddScreenState extends State<SkillsAddScreen> {
  final List<String> skills = [
    "Core Electrical",
    "Appliance",
    "Equipment Work",
    "Intercom Systems",
    "Solar Panel Installation",
    "EV Charger Installation",
  ];

  final Set<String> selectedSkils = {};

  void toggleSelection(String skill) {
    setState(() {
      if (selectedSkils.contains(skill)) {
        selectedSkils.remove(skill);
      } else {
        selectedSkils.add(skill);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final SkillSelectionController controller =
        Get.find<SkillSelectionController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Selected Skills".tr,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
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
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  final skill = skills[index];
                  final isSelected = selectedSkils.contains(skill);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: GestureDetector(
                      onTap: () => toggleSelection(skill),
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
                                skill, // eta change kora hoise
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
            Obx(() {
              return controller.status.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                    onTap: () {
                      controller.updateContractorData(selectedSkils);
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
