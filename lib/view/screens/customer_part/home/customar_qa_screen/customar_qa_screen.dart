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
   final String categoryName= args['categoryName'] ?? '';
   final String subCategoryName= args['subCategoryName'] ?? '';
   final String contractorIdForTimeSlot = args['contractorIdForTimeSlot'] ?? '';
   

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

    List<dynamic> questions = [];
    if (rawQuestions == null) {
      questions = [];
    } else if (rawQuestions is Map && rawQuestions['data'] is List) {
      questions = rawQuestions['data'];
    } else if (rawQuestions is List) {
      questions = rawQuestions;
    } else {
      questions = [rawQuestions];
    }


        // If no questions are provided, use demo questions immediately
        if (questions.isEmpty) {
      questions = [
        {'id': '1', 'question': 'How many dimmers do you need installed?'},
        {'id': '2', 'question': 'What type of lighting fixtures do you prefer?'},
      ];
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
                  // Dynamic questions list - render based on controller.questions
                  ...List.generate(
                    controller.questions.length,
                    (index) {
                      final q = controller.questions[index];
                      final questionText = q['question']?.toString() ?? 'Question ${index + 1}';

                      return GetBuilder<ContractorBookingController>(
                        builder: (ctrl) {
                          return CustomFormCard(
                            title: "${index + 1}. $questionText",
                            hintText: "Answer here...",
                            controller: index < ctrl.answerControllers.length 
                              ? ctrl.answerControllers[index]
                              : TextEditingController(),
                            onChanged: (value) {
                              ctrl.updateAnswer(index, value);
                            },
                          );
                        },
                      );
                    },
                  ),
                  
                  SizedBox(height: 30.h),
                  
                  CustomButton(
                    onTap: () {
                      // Collect all answers before proceeding
                      controller.collectAllAnswers();
                      
                      // Validate that all questions are answered
                      if (controller.validateAnswers()) {
                        debugPrint('All questions Q and A : ${controller.questionsAndAnswers}');
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
                          },
                        );
                      }
                    },
                    title: "Submit".tr,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
