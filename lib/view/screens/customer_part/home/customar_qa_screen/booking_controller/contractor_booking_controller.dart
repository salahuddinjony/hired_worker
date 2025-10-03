import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';

/// ContractorBookingController - Manages booking data, Q&A, and materials
/// 
/// questionsAndAnswers structure:
/// [
///   {
///     'questionId': 'unique_id',
///     'question': 'The question text',
///     'answer': 'User provided answer'
///   }
/// ]
/// 
/// materialsAndQuantity structure:
/// [
///   {
///     'name': 'Material name',
///     'unit': 'pcs/kg/liters etc.',
///     'quantity': '0' // String representation of quantity
///   }
/// ]
class ContractorBookingController extends GetxController {

 List<Map<String, String>> questionsAndAnswers = [];
  List<Map<String, String>> materialsAndQuantity = [];
  RxBool showMaterials = true.obs;
  
  // Q&A management
  List<TextEditingController> answerControllers = [];
  List<Map<String, dynamic>> questions = [];

RxBool isLoading = false.obs;
RxString bookingType='OneTime'.obs; // OneTime or Recurring
RxString durations = '1'.obs; // 1,2,3,4,5
TextEditingController durationController = TextEditingController(text: '1');
TextEditingController dayController = TextEditingController();

Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
  if (picked != null) {
    dayController.text = "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
    refresh();
  }
}

Future<void> selectTime(BuildContext context) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );
  if (picked != null) {
    durationController.text = "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
    refresh();
  }
}

Future<void> createBooking({ required String contractorId, required String subcategoryId}) async {
    isLoading.value = true;

    final customerId= await SharePrefsHelper.getString(AppConstants.userId);

  final bookingData ={
  "customerId": customerId,
  "contractorId": contractorId,
  "subCategoryId": subcategoryId,
  "questions": [
  questionsAndAnswers
  ],
  "material": [
  materialsAndQuantity
  ],
  "bookingType": bookingType.value,
  "duration": durations.value,
  "day": dayController.text,
  "startTime": durationController.text
};
  try{
    final response = await ApiClient.postData(
      ApiUrl.createBooking,
      bookingData,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      isLoading.value = false;
      final data = response.body;
      debugPrint('create booking response: $data');
      showCustomSnackBar("Booking created successfully", isError: false);
      // Get.offAllNamed(AppRoutes.customerBottomNavBar);
    } else {
      debugPrint('create booking failed: ${response.body}');
      showCustomSnackBar("Failed to create booking. Please try again.", isError: true);
    }

  }catch(e){
    isLoading.value = false;
    debugPrint('create booking error: $e');
    showCustomSnackBar("Failed to create booking. Please try again.", isError: true);
  }finally{
    isLoading.value = false;
    refresh();
  }
}

  // Materials management methods
  void toggleShowMaterials() {
    showMaterials.value = !showMaterials.value;
  }

  void initializeMaterials(List<dynamic> materials) {
    materialsAndQuantity.clear();
    for (var material in materials) {
      materialsAndQuantity.add({
        'name': material['name'] ?? 'Unknown',
        'unit': material['unit'] ?? 'pcs',
        'quantity': '0'
      });
    }
    refresh();
  }

  void incrementMaterial(int index) {
    if (index < materialsAndQuantity.length) {
      int currentQuantity = int.parse(materialsAndQuantity[index]['quantity'] ?? '0');
      materialsAndQuantity[index]['quantity'] = (currentQuantity + 1).toString();
      refresh();
    }
  }

  void decrementMaterial(int index) {
    if (index < materialsAndQuantity.length) {
      int currentQuantity = int.parse(materialsAndQuantity[index]['quantity'] ?? '0');
      if (currentQuantity > 0) {
        materialsAndQuantity[index]['quantity'] = (currentQuantity - 1).toString();
        refresh();
      }
    }
  }

  bool isMaterialSelected(int index) {
    if (index < materialsAndQuantity.length) {
      return int.parse(materialsAndQuantity[index]['quantity'] ?? '0') > 0;
    }
    return false;
  }

  // Q&A management methods
  void initializeQuestions(List<dynamic> questionsList) {
    questions.clear();
    answerControllers.clear();
    questionsAndAnswers.clear();
    
    for (int i = 0; i < questionsList.length; i++) {
      var question = questionsList[i];
      
      String questionId;
      String questionText;
      
      // Handle different question object types
      if (question is Map<String, dynamic>) {
        questionId = question['id'] ?? i.toString();
        questionText = question['question'] ?? question['text'] ?? 'Question ${i + 1}';
      } else {
        // Handle FaqData or other custom objects
        try {
          questionId = question.id?.toString() ?? i.toString();
          questionText = question.question ?? question.text ?? 'Question ${i + 1}';

        } catch (e) {
          // Fallback if properties don't exist
          questionId = i.toString();
          questionText = 'Question ${i + 1}';
          debugPrint('Error accessing question properties: $e');
        }
      }
      
      questions.add({
        'id': questionId,
        'question': questionText,
      });
      
      // Create a controller for each question
      answerControllers.add(TextEditingController());
      
      // Initialize empty answer
      questionsAndAnswers.add({
        'question': questionText,
        'answer': ''
      });
    }
    refresh();
  }

  void updateAnswer(int index, String answer) {
    if (index < questionsAndAnswers.length) {
      questionsAndAnswers[index]['answer'] = answer;
      refresh();
    }
  }

  bool validateAnswers() {
    for (var qa in questionsAndAnswers) {
      if (qa['answer']?.trim().isEmpty ?? true) {
        showCustomSnackBar("Please answer all questions", isError: true);
        return false;
      }
    }
    return true;
  }

  void collectAllAnswers() {
    for (int i = 0; i < answerControllers.length; i++) {
      if (i < questionsAndAnswers.length) {
        questionsAndAnswers[i]['answer'] = answerControllers[i].text.trim();
      }
    }
    
    // Debug: Print collected Q&A data
    debugPrint('=== Collected Questions and Answers ===');
    for (var qa in questionsAndAnswers) {
      debugPrint('Q: ${qa['question']}');
      debugPrint('A: ${qa['answer']}');
      debugPrint('---');
    }
  }

  String getQuestionsAndAnswersAsString() {
    String result = '';
    for (var qa in questionsAndAnswers) {
      result += 'Q: ${qa['question']}\n';
      result += 'A: ${qa['answer']}\n\n';
    }
    return result;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (var controller in answerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}