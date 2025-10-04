import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_from_card/custom_from_card.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';

/// CustomarQaScreen - A dynamic Q&A screen that displays questions from arguments
/// 
/// This screen expects the following arguments:
/// - contractorId: String
/// - subcategoryId: String  
/// - materials: List<dynamic> (optional)
/// - questions: List<dynamic> with structure:
///   [
///     {
///       'id': 'question_1',
///       'question': 'How many dimmers do you need installed?',
///       'type': 'text' // optional, defaults to 'text'
///     },
///     {
///       'id': 'question_2', 
///       'question': 'What type of lighting fixtures do you prefer?',
///       'type': 'text'
///     }
///   ]
/// 
/// Example usage:
/// Get.toNamed(AppRoutes.customarQaScreen, arguments: {
///   'contractorId': 'contractor123',
///   'subcategoryId': 'subcat456',
///   'materials': [
///     {'name': 'Power Point', 'unit': 'pcs'},
///     {'name': 'Smoke Alarm', 'unit': 'pcs'},
///   ],
///   'questions': [
///     {'id': '1', 'question': 'How many dimmers do you need installed?'},
///     {'id': '2', 'question': 'What type of lighting fixtures do you prefer?'},
///     {'id': '3', 'question': 'Do you need any additional electrical work?'},
///   ],
/// });
/// 
/// The questionsAndAnswers list in controller will be populated with:
/// [
///   {
///     'questionId': 'question_1',
///     'question': 'How many dimmers do you need installed?',
///     'answer': 'User provided answer'
///   }
/// ]
class CustomarQaScreen extends StatelessWidget {
  CustomarQaScreen({super.key});

  final controller = Get.find<ContractorBookingController>();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> args = Get.arguments ?? {};
    String contractorId = args['contractorId'] ?? '';
    String subcategoryId = args['subcategoryId'] ?? '';
    List<dynamic> materials = args['materials'] ?? [];
    List<dynamic> questions = args['questions'] ?? [];

    // Initialize questions in controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (questions.isNotEmpty) {
        controller.initializeQuestions(questions);
      } else {
        // Fallback: initialize with demo questions if none provided
        controller.initializeQuestions([
          {'id': '1', 'question': 'How many dimmers do you need installed?'},
          {'id': '2', 'question': 'What type of lighting fixtures do you prefer?'},
          {'id': '3', 'question': 'Do you need any additional electrical work?'},
          {'id': '4', 'question': 'What is your preferred completion timeline?'},
          {'id': '5', 'question': 'Do you have any specific brand preferences?'},
        ]);
      }
    });

    // If no questions are provided, use demo questions immediately
    if (questions.isEmpty) {
      questions = [
        {'id': '1', 'question': 'How many dimmers do you need installed?'},
        {'id': '2', 'question': 'What type of lighting fixtures do you prefer?'},
        {'id': '3', 'question': 'Do you need any additional electrical work?'},
        {'id': '4', 'question': 'What is your preferred completion timeline?'},
        {'id': '5', 'question': 'Do you have any specific brand preferences?'},
      ];
    }


    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Q&A".tr),
      body: GetBuilder<ContractorBookingController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Dynamic questions list - always show questions (demo or provided)
                  ...List.generate(
                    questions.length,
                    (index) {
                      final question = questions[index];
                      String questionText;
                      
                      // Handle different question object types
                      if (question is Map<String, dynamic>) {
                        questionText = question['question'] ?? 'Question ${index + 1}';
                      } else {
      
                        try {
                          questionText = question.question ?? question.text ?? 'Question ${index + 1}';
                        } catch (e) {
                          questionText = 'Question ${index + 1}';
                          debugPrint('Error accessing question text: $e');
                        }
                      }
                      
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
                            'subcategoryId': subcategoryId,
                            'materials': materials,
                            'controller': controller,
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
