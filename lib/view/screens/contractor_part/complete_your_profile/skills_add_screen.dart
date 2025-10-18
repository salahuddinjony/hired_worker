import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/skill_selection_controller.dart';
import '../../../components/custom_button/custom_button.dart';
import '../../../components/custom_loader/custom_loader.dart';
import '../../../components/custom_royel_appbar/custom_royel_appbar.dart';

class SkillsAddScreen extends StatefulWidget {
  const SkillsAddScreen({super.key});

  @override
  State<SkillsAddScreen> createState() => _SkillsAddScreenState();
}

class _SkillsAddScreenState extends State<SkillsAddScreen> {
  final Set<String> selectedSkills = {};
  final TextEditingController _skillController = TextEditingController();
  final FocusNode _skillFocusNode = FocusNode();

  final SkillSelectionController controller =
      Get.find<SkillSelectionController>();

  void addSkill() {
    final skill = _skillController.text.trim();
    if (skill.isNotEmpty && !selectedSkills.contains(skill)) {
      setState(() {
        selectedSkills.add(skill);
        _skillController.clear();
      });
    } else if (selectedSkills.contains(skill)) {
      // Show error message for duplicate skill
      Get.snackbar(
        'Duplicate Skill',
        'This skill is already added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void removeSkill(String skill) {
    setState(() {
      selectedSkills.remove(skill);
    });
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      addSkill();
    }
  }

  @override
  void dispose() {
    _skillController.dispose();
    _skillFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Add Skills".tr),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              "Add your skills and expertise.".tr,
              style: const TextStyle(color: Colors.black87),
            ),
            Text(
              "You can always change it later.".tr,
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 24),

            // Skill Input Section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: RawKeyboardListener(
                focusNode: FocusNode(),
                onKey: _handleKeyPress,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        controller: _skillController,
                        focusNode: _skillFocusNode,
                        decoration: InputDecoration(
                          hintText: "Enter a skill...".tr,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                        onSubmitted: (_) => addSkill(),
                      ),
                    ),
                    IconButton(
                      onPressed: addSkill,
                      icon: const Icon(
                        Icons.add_circle,
                        color: Color(0xFF3C003D),
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Instructions
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Press Enter or click the + button to add a skill".tr,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ),

            const SizedBox(height: 24),

            // Selected Skills Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${"Your Skills".tr}(${selectedSkills.length})",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Selected Skills List
            Expanded(
              child:
                  selectedSkills.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.construction_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No skills added yet".tr,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Add your skills above to get started".tr,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                      : ListView.builder(
                        itemCount: selectedSkills.length,
                        itemBuilder: (context, index) {
                          final skill = selectedSkills.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: const Color(0xFF3C003D).withValues(alpha: .1),
                                border: Border.all(
                                  color: const Color(
                                    0xFF3C003D,
                                  ).withValues(alpha: .3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3C003D),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(6),
                                    child: const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      skill,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => removeSkill(skill),
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red.shade600,
                                      size: 16,
                                    ),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),

            // Continue Button
            Obx(() {
              return Column(
                children: [
                  if (selectedSkills.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Add at least one skill to continue".tr,
                        style: TextStyle(
                          color: Colors.orange.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  controller.status.value.isLoading
                      ? const CustomLoader()
                      : CustomButton(
                        onTap: () {
                          if (selectedSkills.isNotEmpty) {
                            controller.updateContractorData(selectedSkills);
                          }
                        },
                        title: "Continue".tr,
                      ),
                ],
              );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
