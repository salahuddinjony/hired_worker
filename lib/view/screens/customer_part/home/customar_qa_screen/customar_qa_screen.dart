import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
// materials are received as plain maps (List<dynamic>) to avoid cross-module
// Model type conflicts (different MaterialModel classes in different folders).
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';

class CustomarQaScreen extends StatelessWidget {
  CustomarQaScreen({super.key});

  final controller = Get.find<ContractorBookingController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};

    // Ensure IDs are strings even if passed as numbers
    final dynamic rawContractorId = args['contractorId'];
    final dynamic rawSubcategoryId = args['subcategoryId'];
    final String contractorId = rawContractorId?.toString() ?? '';
    final String subcategoryId = rawSubcategoryId?.toString() ?? '';
    final List<dynamic> materials = args['materials'] ?? [];
    final String contractorName = args['contractorName'] ?? '';
    final String categoryName = args['categoryName'] ?? '';
    final String subCategoryName = args['subCategoryName'] ?? '';
    final String contractorIdForTimeSlot =
        args['contractorIdForTimeSlot'] ?? '';
    final String subCategoryImage =
        args['subCategoryImage']?.toString() ?? '';

    // hourlyRate may come as String, int, or double - parse defensively
    final dynamic rawHourly = args['hourlyRate'];
    try {
      if (rawHourly == null) {
        controller.hourlyRate = 0;
      } else if (rawHourly is int) {
        controller.hourlyRate = rawHourly;
      } else if (rawHourly is double) {
        controller.hourlyRate = rawHourly.toInt();
      } else {
        controller.hourlyRate = int.tryParse(rawHourly.toString()) ?? 0;
      }
    } catch (e) {
      controller.hourlyRate = 0;
    }

    final rawQuestions = args['questions'];

    List<Map<String, dynamic>> questions = [];
    if (rawQuestions == null) {
      questions = [];
    } else if (rawQuestions is Map && rawQuestions['data'] is List) {
      // API response: data: [ { question: [ ... ] } ]
      final dataList = rawQuestions['data'];
      for (var item in dataList) {
        if (item is Map && item['question'] is List) {
          for (int i = 0; i < item['question'].length; i++) {
            questions.add({
              'id': '${i + 1}',
              'question': item['question'][i],
            });
          }
        } else if (item is Map && item['question'] is String) {
          questions.add({
            'id': item['_id']?.toString() ?? '',
            'question': item['question'],
          });
        }
      }
    } else if (rawQuestions is List) {
      for (int i = 0; i < rawQuestions.length; i++) {
        final q = rawQuestions[i];
        if (q is Map && q['question'] is String) {
          questions.add({
            'id': q['_id']?.toString() ?? '${i + 1}',
            'question': q['question'],
          });
        } else if (q is String) {
          questions.add({
            'id': '${i + 1}',
            'question': q,
          });
        }
      }
    } else if (rawQuestions is String) {
      questions = [{ 'id': '1', 'question': rawQuestions }];
    }



    // Initialize questions in controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (questions.isNotEmpty) {
        controller.initializeQuestions(questions);
      } else {
        debugPrint('No questions available to initialize.');
      }
    });

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Q&A".tr),
      body: GetBuilder<ContractorBookingController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  if(controller.questions.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 50.h, bottom: 20.h),
                      child: Text(
                        "No questions available at this time.".tr,
                        style: TextStyle(
                          fontSize: 16.w,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  // Dynamic questions list - render based on controller.questions
                  ...List.generate(controller.questions.length, (index) {
                    final q = controller.questions[index];
                    final questionText =
                        q['question']?.toString() ?? 'Question ${index + 1}';

                    return GetBuilder<ContractorBookingController>(
                      builder: (ctrl) {
                        return CustomFormCard(
                          visibleAllTest: true,
                          title: "${index + 1}. $questionText",
                          hintText: "Answer here...",
                          controller:
                              index < ctrl.answerControllers.length
                                  ? ctrl.answerControllers[index]
                                  : TextEditingController(),
                          onChanged: (value) {
                            ctrl.updateAnswer(index, value);
                          },
                        );
                      },
                    );
                  }),

                  SizedBox(height: 30.h),

                  CustomButton(
                    onTap: () {
                      // Collect all answers before proceeding
                      controller.collectAllAnswers();

                      // Validate that all questions are answered
                      if (controller.validateAnswers()) {
                        debugPrint(
                          'All questions Q and A : ${controller.questionsAndAnswers}',
                        );
                        Get.toNamed(
                          AppRoutes.customarMaterialsScreen,
                          arguments: {
                            'contractorId': contractorId,
                            'contractorIdForTimeSlot': contractorIdForTimeSlot,
                            'subcategoryId': subcategoryId,
                            'materials': materials,
                            'controller': controller,
                            'contractorName': contractorName,
                            'categoryName': categoryName,
                            'subCategoryName': subCategoryName,
                            'hourlyRate': controller.hourlyRate,
                            'subCategoryImage': subCategoryImage,
                          },
                        );
                      }
                    },
                    title: "Submit".tr,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
