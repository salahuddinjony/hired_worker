import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';

class ContractorBookingController extends GetxController {
  int hourlyRate = 0;

  // Optional contractor metadata to display on the details page
  String contractorName = '';
  String contractorCategory = '';

  List<Map<String, String>> questionsAndAnswers = [];
  List<Map<String, String>> materialsAndQuantity = [];

  // Q&A management
  List<TextEditingController> answerControllers = [];
  List<Map<String, dynamic>> questions = [];

  RxBool isLoading = false.obs;
  RxString bookingType = 'OneTime'.obs; // OneTime or Recurring
  RxString durations = '1'.obs; // 1,2,3,4,5
  Rx<TextEditingController> startTimeController = TextEditingController().obs;
  Rx<TextEditingController> dayController = TextEditingController().obs;
  Rx<TextEditingController> endTimeController = TextEditingController().obs;
  // Expose selected date/time as observable strings for the UI to bind to
  RxString selectedHour = ''.obs;
  RxString selectedTime = ''.obs;

  Future<void> selectDate(BuildContext context) async {
    debugPrint(
      'ContractorBookingController.selectDate called; Get.context=${Get.context != null}',
    );
    final ctx = Get.context ?? context;
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final formatted =
          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      dayController.value.text = formatted;
      // notify listeners
      debugPrint('ContractorBookingController.selectDate picked: $formatted');
      refresh();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final ctx = Get.context ?? context;
    final TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formatted =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      startTimeController.value.text = formatted;
      debugPrint('ContractorBookingController.selectTime picked: $formatted');
    }
    refresh();
  }

  void initializeMaterials(List<dynamic> materials) {
    materialsAndQuantity.clear();
    for (var material in materials) {
      String name = 'Unknown';
      String unit = '0';
      String price = '0';

      try {
        if (material is Map) {
          name = (material['name'] ?? 'Unknown').toString();
          unit = (material['unit'] ?? '0').toString();
          price = (material['price'] ?? '0').toString();
        } else {
          // material might be a model instance (e.g., MaterialModel) or other object
          // try common fields via reflection-like access
          try {
            final dynamic n = material.name ?? material['name'];
            name = n?.toString() ?? material.toString();
          } catch (_) {
            name = material.toString();
          }
          try {
            final dynamic u = material.unit ?? material['unit'];
            unit = u?.toString() ?? '0';
          } catch (_) {
            unit = '0';
          }
          try {
            final dynamic p = material.price ?? material['price'];
            price = p?.toString() ?? '0';
          } catch (_) {
            price = '0';
          }
        }
      } catch (e) {
        debugPrint('initializeMaterials: error parsing material: $e');
      }

      materialsAndQuantity.add({
        'name': name,
        // store quantity in 'unit' as a stringified integer; default to '0'
        'unit': unit,
        'price': price,
      });
    }
    refresh();
  }

  void incrementMaterial(int index) {
    if (index < materialsAndQuantity.length) {
      final currentQuantity =
          int.tryParse(materialsAndQuantity[index]['unit'] ?? '0') ?? 0;
      materialsAndQuantity[index]['unit'] = (currentQuantity + 1).toString();
      refresh();
    }
  }

  void decrementMaterial(int index) {
    if (index < materialsAndQuantity.length) {
      final currentQuantity =
          int.tryParse(materialsAndQuantity[index]['unit'] ?? '0') ?? 0;
      if (currentQuantity > 0) {
        materialsAndQuantity[index]['unit'] = (currentQuantity - 1).toString();
        refresh();
      }
    }
  }

  bool isMaterialSelected(int index) {
    if (index < materialsAndQuantity.length) {
      return (int.tryParse(materialsAndQuantity[index]['unit'] ?? '0') ?? 0) >
          0;
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

      if (question is Map<String, dynamic>) {
        // Support both 'id' and '_id' keys coming from different APIs
        questionId = question['id'] ?? question['_id'] ?? i.toString();

        final qField = question['question'] ?? question['text'];
        if (qField is List) {
          questionText =
              qField.isNotEmpty
                  ? qField.map((e) => e?.toString() ?? '').join(', ')
                  : 'Question ${i + 1}';
        } else {
          questionText = qField?.toString() ?? 'Question ${i + 1}';
        }
      } else {
        try {
          questionId = question.id?.toString() ?? i.toString();

          final qField = question.question ?? question.text;
          if (qField is List) {
            questionText =
                qField.isNotEmpty
                    ? qField.map((e) => e?.toString() ?? '').join(', ')
                    : 'Question ${i + 1}';
          } else {
            questionText = qField?.toString() ?? 'Question ${i + 1}';
          }
        } catch (e) {
          questionId = i.toString();
          questionText = 'Question ${i + 1}';
          debugPrint('Error accessing question properties: $e');
        }
      }

      questions.add({'id': questionId, 'question': questionText});

      // Create a controller for each question
      answerControllers.add(TextEditingController());

      // Initialize empty answer
      questionsAndAnswers.add({'question': questionText, 'answer': ''});
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

  // total payable amount
  int calculateTotalPayableAmount() {
    int total = 0;

    // Add hourly rate based on duration
    int durationHours = int.tryParse(durations.value) ?? 1;

    total += hourlyRate * durationHours;

    // Add materials cost
    for (var material in materialsAndQuantity) {
      int quantity = int.tryParse(material['unit'] ?? '0') ?? 0;
      int pricePerUnit = int.tryParse(material['price'] ?? '0') ?? 0;
      total += quantity * pricePerUnit;
    }

    // Debug: Print total calculation breakdown
    debugPrint('=== Total Payable Amount Calculation ===');
    debugPrint('Hourly Rate: $hourlyRate');
    debugPrint('Duration (Hours): $durationHours');
    debugPrint('Total from Hourly Rate: ${hourlyRate * durationHours}');
    for (var material in materialsAndQuantity) {
      int quantity = int.tryParse(material['unit'] ?? '0') ?? 0;
      int pricePerUnit = int.tryParse(material['price'] ?? '0') ?? 0;
      debugPrint(
        'Material: ${material['name']}, Quantity: $quantity, Price/Unit: $pricePerUnit, Total: ${quantity * pricePerUnit}',
      );
    }

    return total;
  }

  /// Materials subtotal — sum(quantity * price)
  int get materialsSubtotal {
    int sum = 0;
    for (var material in materialsAndQuantity) {
      int quantity = int.tryParse(material['unit'] ?? '0') ?? 0;
      int pricePerUnit = int.tryParse(material['price'] ?? '0') ?? 0;
      sum += quantity * pricePerUnit;
    }
    return sum;
  }

  /// Return list of selected materials (quantity > 0)
  List<Map<String, String>> get selectedMaterials {
    return materialsAndQuantity.where((m) {
      final q = int.tryParse(m['unit'] ?? '0') ?? 0;
      return q > 0;
    }).toList();
  }

  /// total amount combining hourly + materials
  int get totalAmount => calculateTotalPayableAmount();
  int get totalDurationAmount => hourlyRate * int.parse(durations.value);

  Future<bool> createBooking({
    required String contractorId,
    required String subcategoryId,
  }) async {
    isLoading.value = true;

    final customerId = await SharePrefsHelper.getString(AppConstants.userId);

    if (contractorId.trim().isEmpty) {
      EasyLoading.showError("Invalid contractor id");
      isLoading.value = false;
      return false;
    }

    final List<Map<String, String>> questionsPayload =
        questionsAndAnswers.map((qa) {
          return {
            'question': (qa['question'] ?? '').toString(),
            'answer': (qa['answer'] ?? '').toString(),
          };
        }).toList();

    // Convert materials to expected shape and normalize price (remove trailing $ and parse number)
    final List<Map<String, dynamic>> materialsPayload =
        materialsAndQuantity.map((m) {
          String name = '';
          try {
            name = (m['name'] ?? '').toString();
          } catch (_) {
            name = m.toString();
          }

          final rawPrice = (m['price'] ?? '').toString();
          // Remove any non-digit, non-dot characters (like $)
          final cleaned = rawPrice.replaceAll(RegExp(r"[^0-9.]"), '');
          final priceNum = double.tryParse(cleaned) ?? 0.0;
          final unitNum = int.tryParse((m['unit'] ?? '0').toString()) ?? 0;
          return {'name': name, 'unit': unitNum, 'price': priceNum};
        }).toList();

    final payloadStartTime =
        startTimeController.value.text.isNotEmpty
            ? startTimeController.value.text
            : selectedTime.value;

    final bookingData = {
      'customerId': customerId,
      'contractorId': contractorId,
      'subCategoryId': subcategoryId,
      'questions': questionsPayload,
      'material': materialsPayload,
      'bookingType': bookingType.value,
      'duration': int.tryParse(durations.value) ?? durations.value,
      'day': dayController.value.text,
      'startTime': payloadStartTime,
    };

    EasyLoading.show(status: 'Creating booking...');
    debugPrint('Creating booking with data: $bookingData');
    try {
      final response = await ApiClient.postData(
        ApiUrl.createBooking,
        jsonEncode(bookingData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        final data = response.body;
        debugPrint('create booking response: $data');
        EasyLoading.showSuccess('Booking created successfully!');
        return true;
      } else {
        debugPrint('create booking failed: ${response.body}');
        EasyLoading.showError("Failed to create booking. Please try again.");
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('create booking error: $e');
      EasyLoading.showError("Failed to create booking. Please try again.");
      return false;
    } finally {
      EasyLoading.dismiss();
      isLoading.value = false;
      refresh();
    }
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
