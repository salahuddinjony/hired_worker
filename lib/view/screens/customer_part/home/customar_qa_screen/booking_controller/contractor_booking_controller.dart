import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/service/api_client.dart';
import 'package:servana/service/api_url.dart';
import 'package:servana/utils/ToastMsg/toast_message.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/models/avalable_slot.dart';

class ContractorBookingController extends GetxController {
  // Store original material counts for update mode
  List<int> originalMaterialCounts = [];

  // Store available slots from API
  RxList<String> availableSlots = <String>[].obs;
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
  RxString bookingType = 'oneTime'.obs;
  RxString durations = '1'.obs;
  Rx<TextEditingController> startTimeController = TextEditingController().obs;
  Rx<TextEditingController> dayController = TextEditingController().obs;
  Rx<TextEditingController> endTimeController = TextEditingController().obs;
  RxList<String> selectedDates = <String>[].obs;
  RxString selectedHour = ''.obs;
  RxString selectedTime = ''.obs;

  Future<void> selectDate(BuildContext context, bool isOneTime) async {
    debugPrint(
      'ContractorBookingController.selectDate called; Get.context=${Get.context != null}, isOneTime=$isOneTime',
    );
    final ctx = Get.context ?? context;

    if (isOneTime) {
      // Single date selection (existing behavior)
      final DateTime? picked = await showDatePicker(
        context: ctx,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (picked != null) {
        final formatted =
            "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        // Clear any previous multiple selections
        selectedDates.clear();
        selectedDates.add(formatted);
        dayController.value.text = formatted;
        debugPrint('ContractorBookingController.selectDate picked: $formatted');
        refresh();
      }
    } else {
      // Multiple individual date selection (non-contiguous). We'll show a small dialog
      // where the user can add one date at a time, see the list, remove items, and finish.
      await showModalBottomSheet<void>(
        context: ctx,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (sheetCtx) {
          final List<String> tempDates = List<String>.from(selectedDates);
          return DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.55,
            minChildSize: 0.3,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 48,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Select Dates',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Choose one or more days for recurring booking',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed:
                                  () => setState(() => tempDates.clear()),
                              child: Text(
                                'Clear All',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Selected dates as chips
                        Expanded(
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children:
                                      tempDates.isEmpty
                                          ? [
                                            const Chip(
                                              label: Text('No dates selected'),
                                            ),
                                          ]
                                          : tempDates.map((d) {
                                            return InputChip(
                                              label: Text(d),
                                              onDeleted:
                                                  () => setState(
                                                    () => tempDates.remove(d),
                                                  ),
                                              deleteIcon: const Icon(
                                                Icons.close,
                                                size: 18,
                                              ),
                                            );
                                          }).toList(),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.calendar_today_outlined,
                                      ),
                                      label: const Text('Add Date'),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                      ),
                                      onPressed: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                              context: sheetCtx,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101),
                                            );
                                        if (picked != null) {
                                          final formatted =
                                              "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                                          if (!tempDates.contains(formatted)) {
                                            setState(
                                              () => tempDates.add(formatted),
                                            );
                                          }
                                        }
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    OutlinedButton.icon(
                                      icon: const Icon(Icons.sort_by_alpha),
                                      label: const Text('Sort'),
                                      onPressed:
                                          () =>
                                              setState(() => tempDates.sort()),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Small help / summary
                                Text(
                                  '${tempDates.length} dates selected',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(sheetCtx).pop();
                                },
                                child: const Text('Cancel'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Commit the selection
                                  selectedDates.clear();
                                  selectedDates.addAll(tempDates);

                                  if (selectedDates.isEmpty) {
                                    dayController.value.text = '';
                                  } else if (selectedDates.length == 1) {
                                    dayController.value.text =
                                        selectedDates.first;
                                  } else if (selectedDates.length <= 2) {
                                    dayController.value.text = selectedDates
                                        .join(', ');
                                  } else {
                                    dayController.value.text =
                                        '${selectedDates.length} dates selected';
                                  }

                                  debugPrint(
                                    'Selected multiple dates: ${selectedDates.length}',
                                  );
                                  Navigator.of(sheetCtx).pop();
                                  refresh();
                                },
                                child: const Text('Done'),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    );
                  },
                ),
              );
            },
          );
        },
      );
    }
  }

  Future<void> selectTime(
    BuildContext context,
    TextEditingController textController,
  ) async {
    final ctx = Get.context ?? context;
    final TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final formatted =
          "${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}";
      textController.text = formatted;
      debugPrint('ContractorBookingController.selectTime picked: $formatted');

      // Validate time range immediately after selecting end time
      if (textController == endTimeController.value &&
          startTimeController.value.text.isNotEmpty &&
          endTimeController.value.text.isNotEmpty) {
        // Perform validation
        if (!validateTimeRangeImmediate()) {
          // Clear the end time if validation fails
          textController.clear();
        }
      }
    }
    refresh();
  }

  /// Immediate validation for time picker (shows dialog instead of toast)
  bool validateTimeRangeImmediate() {
    if (startTimeController.value.text.isEmpty ||
        endTimeController.value.text.isEmpty) {
      return true; // Skip validation if times not set yet
    }

    try {
      // Parse start time
      final startParts = startTimeController.value.text.split(':');
      final startHour = int.parse(startParts[0]);
      final startMinute = int.parse(startParts[1]);

      // Parse end time
      final endParts = endTimeController.value.text.split(':');
      final endHour = int.parse(endParts[0]);
      final endMinute = int.parse(endParts[1]);

      // Create DateTime objects for calculation (using same date)
      final now = DateTime.now();
      final startTime = DateTime(
        now.year,
        now.month,
        now.day,
        startHour,
        startMinute,
      );
      var endTime = DateTime(now.year, now.month, now.day, endHour, endMinute);

      // Handle case where end time is before start time (crosses midnight)
      if (endTime.isBefore(startTime)) {
        endTime = endTime.add(const Duration(days: 1));
      }

      // Calculate actual duration in hours
      final difference = endTime.difference(startTime);
      final actualHours = difference.inMinutes / 60.0;

      // Get selected duration
      final selectedHours = durationInt;

      debugPrint('=== Time Range Validation (Immediate) ===');
      debugPrint('Start Time: ${startTimeController.value.text}');
      debugPrint('End Time: ${endTimeController.value.text}');
      debugPrint('Actual Duration: $actualHours hours');
      debugPrint('Selected Duration: $selectedHours hours');

      // Check if actual duration matches selected duration (allow small tolerance for rounding)
      if ((actualHours - selectedHours).abs() > 0.1) {
        // Show dialog instead of toast for immediate feedback
        Get.dialog(
          AlertDialog(
            title: const Text('Invalid Time Range'),
            content: Text(
              'The selected time range is ${actualHours.toStringAsFixed(1)} hours, but you selected $selectedHours hour${selectedHours > 1 ? 's' : ''}.\n\nPlease select an end time that matches your selected duration.',
            ),
            actions: [
              TextButton(onPressed: () => Get.back(), child: const Text('OK')),
            ],
          ),
          barrierDismissible: false,
        );
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('Error validating time range: $e');
      Get.dialog(
        AlertDialog(
          title: const Text('Invalid Time Format'),
          content: const Text('Please select valid start and end times.'),
          actions: [
            TextButton(onPressed: () => Get.back(), child: const Text('OK')),
          ],
        ),
        barrierDismissible: false,
      );
      return false;
    }
  }

  void initializeMaterials(dynamic materials) {
    materialsAndQuantity.clear();
    originalMaterialCounts.clear();

    for (final material in materials) {
      String name = 'Unknown';
      String unit = 'pcs';
      String price = '0';
      String count = '0'; // Default count

      try {
        // Handle MaterialsModel type
        if (material.runtimeType.toString().contains('MaterialsModel')) {
          name = material.name ?? 'Unknown';
          unit = material.unit ?? 'pcs';
          price = material.price?.toString() ?? '0';
          // MaterialsModel doesn't have count, keep default '0'
        }
        // Handle MaterialItem type (from booking data)
        else if (material.runtimeType.toString().contains('MaterialItem')) {
          name = material.name ?? 'Unknown';
          unit = material.unit ?? 'pcs';
          price = material.price?.toString() ?? '0';
          count = material.count?.toString() ?? '0'; // Preserve existing count
        }
        // Handle Map/JSON data
        else if (material is Map<String, dynamic>) {
          name = material['name']?.toString() ?? 'Unknown';
          unit = material['unit']?.toString() ?? 'pcs';
          price = material['price']?.toString() ?? '0';
          count =
              material['count']?.toString() ?? '0'; // Preserve existing count
        }
        // Handle dynamic objects with properties
        else {
          try {
            name = material.name?.toString() ?? 'Unknown';
            unit = material.unit?.toString() ?? 'pcs';
            price = material.price?.toString() ?? '0';
            // Try to get count if it exists
            try {
              count = material.count?.toString() ?? '0';
            } catch (e) {
              count = '0'; // Fallback if count doesn't exist
            }
          } catch (e) {
            debugPrint('Error accessing material properties: $e');
          }
        }

        debugPrint(
          'Parsed material: $name, unit: $unit, price: $price, count: $count',
        );
      } catch (e) {
        debugPrint('initializeMaterials: error parsing material: $e');
      }

      materialsAndQuantity.add({
        'name': name,
        'unit': unit,
        'price': price,
        'count': count, // Use the extracted count value
      });
      originalMaterialCounts.add(int.tryParse(count) ?? 0);
    }
    refresh();
  }

  void incrementMaterial(int index) {
    if (index < materialsAndQuantity.length) {
      final currentQuantity =
          int.tryParse(materialsAndQuantity[index]['count'] ?? '0') ?? 0;
      materialsAndQuantity[index]['count'] = (currentQuantity + 1).toString();
      refresh();
    }
  }

  void decrementMaterial(int index) {
    if (index < materialsAndQuantity.length) {
      final currentQuantity =
          int.tryParse(materialsAndQuantity[index]['count'] ?? '0') ?? 0;
      int minCount = 0;
      if (Get.arguments != null &&
          Get.arguments['isUpdate'] == true &&
          index < originalMaterialCounts.length) {
        minCount = originalMaterialCounts[index];
      }
      if (currentQuantity > minCount) {
        materialsAndQuantity[index]['count'] = (currentQuantity - 1).toString();
        refresh();
      }
    }
  }

  bool isMaterialSelected(int index) {
    if (index < materialsAndQuantity.length) {
      return (int.tryParse(materialsAndQuantity[index]['count'] ?? '0') ?? 0) >
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
      final question = questionsList[i];

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
    for (final qa in questionsAndAnswers) {
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
    for (final qa in questionsAndAnswers) {
      debugPrint('Q: ${qa['question']}');
      debugPrint('A: ${qa['answer']}');
      debugPrint('---');
    }
  }

  String getQuestionsAndAnswersAsString() {
    String result = '';
    for (final qa in questionsAndAnswers) {
      result += 'Q: ${qa['question']}\n';
      result += 'A: ${qa['answer']}\n\n';
    }
    return result;
  }

  // ---------total payable amount-----------------

  /// Duration in hours
  int get durationInt => int.tryParse(durations.value) ?? 1;
  int get totalDurationAmount => hourlyRate * durationInt;

  int get materialsTotalAmount {
    int total = 0;
    for (final material in materialsAndQuantity) {
      final int quantity = int.tryParse(material['count'] ?? '0') ?? 0;
      final int pricePerUnit = int.tryParse(material['price'] ?? '0') ?? 0;
      total += quantity * pricePerUnit;
    }
    return total;
  }

  int get weeklyTotalAmount => totalDurationAmount * selectedDates.length;

  int calculateTotalPayableAmount() {
    int total = 0;

    if (bookingType.value == 'weekly' && selectedDates.length > 1) {
      total += weeklyTotalAmount;
    } else {
      total += totalDurationAmount;
    }
    // Add materials cost
    total += materialsTotalAmount;

    // Debug: Print total calculation breakdown

    debugPrint('=== Total Payable Amount Calculation ===');
    debugPrint('Hourly Rate: $hourlyRate');
    debugPrint('Duration (Hours): $durationInt');
    debugPrint('Total from Hourly Rate: ${hourlyRate * durationInt}');
    for (final material in materialsAndQuantity) {
      final int quantity = int.tryParse(material['count'] ?? '0') ?? 0;
      final int pricePerUnit = int.tryParse(material['price'] ?? '0') ?? 0;
      debugPrint(
        'Material: ${material['name']}, Quantity: $quantity, Price/Unit: $pricePerUnit, Total: ${quantity * pricePerUnit}',
      );
    }

    return total;
  }

  int get totalAmount => calculateTotalPayableAmount();

  /// Validates that the time range matches the selected duration
  bool validateTimeRange() {
    if (startTimeController.value.text.isEmpty ||
        endTimeController.value.text.isEmpty) {
      return true; // Skip validation if times not set yet
    }

    try {
      // Parse start time
      final startParts = startTimeController.value.text.split(':');
      final startHour = int.parse(startParts[0]);
      final startMinute = int.parse(startParts[1]);

      // Parse end time
      final endParts = endTimeController.value.text.split(':');
      final endHour = int.parse(endParts[0]);
      final endMinute = int.parse(endParts[1]);

      // Create DateTime objects for calculation (using same date)
      final now = DateTime.now();
      final startTime = DateTime(
        now.year,
        now.month,
        now.day,
        startHour,
        startMinute,
      );
      var endTime = DateTime(now.year, now.month, now.day, endHour, endMinute);

      // Handle case where end time is before start time (crosses midnight)
      if (endTime.isBefore(startTime)) {
        endTime = endTime.add(const Duration(days: 1));
      }

      // Calculate actual duration in hours
      final difference = endTime.difference(startTime);
      final actualHours = difference.inMinutes / 60.0;

      // Get selected duration
      final selectedHours = durationInt;

      debugPrint('=== Time Range Validation ===');
      debugPrint('Start Time: ${startTimeController.value.text}');
      debugPrint('End Time: ${endTimeController.value.text}');
      debugPrint('Actual Duration: $actualHours hours');
      debugPrint('Selected Duration: $selectedHours hours');

      // Check if actual duration matches selected duration (allow small tolerance for rounding)
      if ((actualHours - selectedHours).abs() > 0.1) {
        EasyLoading.showInfo(
          "Time range (${actualHours.toStringAsFixed(1)} hours) doesn't match selected duration ($selectedHours hour${selectedHours > 1 ? 's' : ''})",
          duration: const Duration(seconds: 4),
        );
        isLoading.value = false;
        return false;
      }

      return true;
    } catch (e) {
      debugPrint('Error validating time range: $e');
      EasyLoading.showInfo("Invalid time format");
      isLoading.value = false;
      return false;
    }
  }

  bool isNotEmptyField() {
    if (startTimeController.value.text.isEmpty ||
        endTimeController.value.text.isEmpty) {
      EasyLoading.showInfo("Please select start and end time");
      isLoading.value = false;
      return false;
    }
    if (dayController.value.text.isEmpty) {
      EasyLoading.showInfo("Please select day(s)");
      isLoading.value = false;
      return false;
    }
    if (selectedDates.isEmpty) {
      EasyLoading.showInfo("Please select at least one date");
      isLoading.value = false;
      return false;
    }

    // Validate that time range matches selected duration
    if (!validateTimeRange()) {
      return false;
    }

    return true;
  }

  Future<bool> createBooking({
    required String contractorId,
    required String subcategoryId,
    required String paymentedBookingId,
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

    // Convert materials to the requested shape: {name, count, unit, price}

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

          // unit in our internal structure stores the quantity; rename to count
          final countNum = int.tryParse((m['count'] ?? '0').toString()) ?? 0;

          return {
            'name': name,
            'count': countNum,
            'unit': 'pcs',
            'price': priceNum,
          };
        }).toList();

    final payloadStartTime =
        startTimeController.value.text.isNotEmpty
            ? startTimeController.value.text
            : selectedTime.value;

    final bookingData = {
      'customerId': customerId,
      'bookingId': paymentedBookingId,
      'contractorId': contractorId,
      'subCategoryId': subcategoryId,
      'questions': questionsPayload,
      'material': materialsPayload,
      'bookingType': bookingType.value,
      'duration': durationInt,
      'startTime': payloadStartTime,
      'endTime': endTimeController.value.text,
      'day':
          bookingType.value == 'oneTime'
              ? dayController.value.text
              : selectedDates.toList(),
      'price':
          bookingType.value == 'weekly' && selectedDates.length > 1
              ? weeklyTotalAmount
              : totalDurationAmount,
      'totalAmount': calculateTotalPayableAmount(),
      'rateHourly': hourlyRate,
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
        // Try to show API error message if available
        String errorMsg = "Something went wrong";
        try {
          final body = response.body;
          dynamic decoded;
          if (body is String && body.isNotEmpty) {
            decoded = jsonDecode(body);
          } else if (body is Map) {
            decoded = body;
          }

          if (decoded is Map<String, dynamic>) {
            // 1) Prefer explicit message field
            if (decoded['message'] is String &&
                (decoded['message'] as String).isNotEmpty) {
              errorMsg = decoded['message'];
            }

            // 2) Then check errorSources array
            if (errorMsg.isEmpty &&
                decoded['errorSources'] is List &&
                decoded['errorSources'].isNotEmpty) {
              final firstError = decoded['errorSources'][0];
              if (firstError is Map &&
                  firstError['message'] is String &&
                  (firstError['message'] as String).isNotEmpty) {
                errorMsg = firstError['message'];
              }
            }

            // 3) Some APIs return nested err or errors
            if (errorMsg.isEmpty &&
                decoded['err'] is Map &&
                decoded['err']['message'] is String) {
              errorMsg = decoded['err']['message'];
            }
          }
        } catch (e) {
          debugPrint('Error parsing error body: $e');
        }

        // Final fallback
        if (errorMsg.isEmpty) errorMsg = 'Failed to create booking';

        EasyLoading.showInfo(errorMsg, duration: const Duration(seconds: 3));
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('create booking error: $e');
      EasyLoading.showError("$e");
      return false;
    } finally {
      EasyLoading.dismiss();
      isLoading.value = false;
      refresh();
    }
  }

  Future<bool> updateBooking({
    required String bookingId,
    required String contractorId,
    required String subcategoryId,
    required String id,
    required bool booking_update,
  }) async {
    isLoading.value = true;

    if (contractorId.trim().isEmpty) {
      EasyLoading.showError("Invalid contractor id");
      isLoading.value = false;
      return false;
    }

    if (bookingId.trim().isEmpty) {
      EasyLoading.showError("Invalid booking id");
      isLoading.value = false;
      return false;
    }

    if (!isNotEmptyField()) {
      return false;
    }

    final List<Map<String, String>> questionsPayload =
        questionsAndAnswers.map((qa) {
          return {
            'question': qa['question'] ?? '',
            'answer': qa['answer'] ?? '',
          };
        }).toList();

    // Convert materials to the requested shape: {name, count, unit, price}
    final List<Map<String, dynamic>> materialsPayload =
        materialsAndQuantity.map((m) {
          String name = '';
          try {
            name = (m['name'] ?? '').toString();
          } catch (_) {
            name = '';
          }

          final rawPrice = (m['price'] ?? '').toString();
          // Remove any non-digit, non-dot characters (like $)
          final cleaned = rawPrice.replaceAll(RegExp(r"[^0-9.]"), '');
          final priceNum = double.tryParse(cleaned) ?? 0.0;

          // unit in our internal structure stores the quantity; rename to count
          final countNum = int.tryParse((m['count'] ?? '0').toString()) ?? 0;

          return {
            'name': name,
            'count': countNum,
            'unit': 'pcs',
            'price': priceNum,
          };
        }).toList();

    final payloadStartTime =
        startTimeController.value.text.isNotEmpty
            ? startTimeController.value.text
            : selectedTime.value;

    // Build update payload with only the fields that can be updated
    final Map<String, dynamic> bookingData = {};

    // Only include fields that are being updated
    if (questionsPayload.isNotEmpty) {
      bookingData['questions'] = questionsPayload;
    }

    if (materialsPayload.isNotEmpty) {
      bookingData['material'] = materialsPayload;
    }

    if (bookingType.value.isNotEmpty) {
      bookingData['bookingType'] = bookingType.value;
    }

    if (id.trim().isNotEmpty) {
      bookingData['bookingId'] = id;
    }

    if (booking_update) {
      bookingData['booking_update'] = booking_update;
    }

    if (durationInt > 0) {
      bookingData['duration'] = durationInt;
    }

    if (payloadStartTime.isNotEmpty) {
      bookingData['startTime'] = payloadStartTime;
    }

    if (endTimeController.value.text.isNotEmpty) {
      bookingData['endTime'] = endTimeController.value.text;
    }

    if (selectedDates.isNotEmpty) {
      bookingData['day'] = selectedDates.toList();
    }

    // Calculate and include price based on booking type
    final calculatedPrice =
        bookingType.value == 'weekly' && selectedDates.length > 1
            ? weeklyTotalAmount
            : totalDurationAmount;

    if (calculatedPrice > 0) {
      bookingData['price'] = calculatedPrice;
    }

    // Calculate and include total amount
    final totalAmountCalc = calculateTotalPayableAmount();
    if (totalAmountCalc > 0) {
      bookingData['totalAmount'] = totalAmountCalc;
    }

    if (hourlyRate > 0) {
      bookingData['rateHourly'] = hourlyRate;
    }

    EasyLoading.show(status: 'Updating booking...');
    debugPrint('Updating booking with ID: $bookingId');
    debugPrint('Update data (only modified fields): $bookingData');

    try {
      // Use PATCH request to update the booking
      final response = await ApiClient.patchData(
        '/bookings/$bookingId',
        jsonEncode(bookingData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        final data = response.body;
        debugPrint('update booking response: $data');
        EasyLoading.showSuccess('Booking updated successfully!');
        return true;
      } else {
        debugPrint('update booking failed: ${response.body}');
        // Try to show API error message if available
        String errorMsg = "Something went wrong";
        try {
          final body = response.body;
          Map<String, dynamic>? decoded;

          if (body is String) {
            decoded = jsonDecode(body);
          } else if (body is Map) {
            decoded = Map<String, dynamic>.from(body);
          }

          if (decoded is Map<String, dynamic>) {
            // 1) Prefer explicit message field
            if (decoded['message'] is String &&
                (decoded['message'] as String).isNotEmpty) {
              errorMsg = decoded['message'];
            }

            // 2) Then check errorSources array
            if (errorMsg.isEmpty &&
                decoded['errorSources'] is List &&
                decoded['errorSources'].isNotEmpty) {
              final firstError = decoded['errorSources'][0];
              if (firstError is Map &&
                  firstError['message'] is String &&
                  (firstError['message'] as String).isNotEmpty) {
                errorMsg = firstError['message'];
              }
            }

            // 3) Some APIs return nested err or errors
            if (errorMsg.isEmpty &&
                decoded['err'] is Map &&
                decoded['err']['message'] is String) {
              errorMsg = decoded['err']['message'];
            }
          }
        } catch (e) {
          debugPrint('Error parsing error body: $e');
        }

        // Final fallback
        if (errorMsg.isEmpty) errorMsg = 'Failed to update booking';

        EasyLoading.showInfo(errorMsg, duration: Duration(seconds: 3));
        isLoading.value = false;
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint('update booking error: $e');
      EasyLoading.showError("$e");
      return false;
    } finally {
      EasyLoading.dismiss();
      isLoading.value = false;
      refresh();
    }
  }

  //for looup available slots
  //for looup available slots
  final Map<String, dynamic> apiResponse = {};
  Future<dynamic> lookupAvailableSlots({
    required String contractorIdForTimeSlot,
  }) async {
    isLoading.value = true;
    debugPrint(
      'Looking up available slots for contractor $contractorIdForTimeSlot',
    );
    final queryParameter = {
      'contractorId': contractorIdForTimeSlot,
      'day':
          selectedDates.length > 1
              ? selectedDates.first
              : dayController.value.text,
    };
    EasyLoading.show(status: 'Looking up available slots...');

    try {
      final response = await ApiClient.getData(
        ApiUrl.lookupAvailableSlots,
        query: queryParameter,
      );

      if (response.statusCode == 200) {
        final data = AvailableSlotResponse.fromJson(response.body);
        debugPrint('Available slots response: $data');
        availableSlots.value = data.data?.availableSlots ?? <String>[];
        // isSlotAvailable();

        // Expecting: {success: true, message: ..., data: {success: false, message: ..., unavailableDays: [...]}}
        if (data.data is Map && data.data!.success == false) {
          return {
            apiResponse: {
              'success': false,
              'message': data.data!.message,
              'unavailableDays': data.data!.availableSlots,
            },
          };
        }
        return true;
      } else {
        // Handle error response
        try {
          final body = response.body;
          dynamic slotData;
          if (body is String && body.isNotEmpty) {
            slotData = jsonDecode(body);
          } else if (body is Map) {
            slotData = body;
          }
          if (slotData is Map && slotData['success'] == false) {
            return {
              'success': false,
              'message':
                  slotData['message'] ??
                  'Some requested slots are unavailable.',
              'unavailableDays': slotData['unavailableDays'] ?? [],
            };
          }
        } catch (e) {
          debugPrint('Error parsing error body: $e');
        }
        return true;
      }
    } catch (e) {
      debugPrint('Error looking up available slots: $e');
      EasyLoading.showError('Error looking up available slots');
      return false;
    } finally {
      EasyLoading.dismiss();
      isLoading.value = false;
      refresh();
    }
  }

  bool isSlotAvailable() {
    debugPrint('Validating selected time slot against available slots...');

    for (final slot in availableSlots) {
      debugPrint('Checking slot: $slot');
      final slotParts = slot.split('-');
      if (slotParts.length == 2) {
        final slotStart = slotParts[0].trim();
        final slotEnd = slotParts[1].trim();

        // Parse slot start and end times
        final slotStartParts = slotStart.split(':');
        final slotEndParts = slotEnd.split(':');
        final startParts = startTimeController.value.text.split(':');
        final endParts = endTimeController.value.text.split(':');

        if (slotStartParts.length == 2 &&
            slotEndParts.length == 2 &&
            startParts.length == 2 &&
            endParts.length == 2) {
          final slotStartTime = TimeOfDay(
            hour: int.parse(slotStartParts[0]),
            minute: int.parse(slotStartParts[1]),
          );
          final slotEndTime = TimeOfDay(
            hour: int.parse(slotEndParts[0]),
            minute: int.parse(slotEndParts[1]),
          );
          final bookingStartTime = TimeOfDay(
            hour: int.parse(startParts[0]),
            minute: int.parse(startParts[1]),
          );
          final bookingEndTime = TimeOfDay(
            hour: int.parse(endParts[0]),
            minute: int.parse(endParts[1]),
          );

          final bool isStartInRange =
              (bookingStartTime.hour > slotStartTime.hour ||
                  (bookingStartTime.hour == slotStartTime.hour &&
                      bookingStartTime.minute >= slotStartTime.minute));
          final bool isEndInRange =
              (bookingEndTime.hour < slotEndTime.hour ||
                  (bookingEndTime.hour == slotEndTime.hour &&
                      bookingEndTime.minute <= slotEndTime.minute));

          if (isStartInRange && isEndInRange) {
            return true;
          }
        }
      }
    }
    return false;
  }

  // Future<dynamic> lookupAvailableSlots({required String contractorId}) async {
  //   isLoading.value = true;
  //   debugPrint('Looking up available slots for contractor $contractorId ');
  //   final body={
  //     'contractorId': contractorId,
  //     'date': dayController.value.text,
  //     'startTime': startTimeController.value.text,
  //     'duration':durations.value,
  //   };
  //   EasyLoading.show(status: 'Looking up available slots...');

  //   try {
  //     final response = await ApiClient.postData(
  //       '${ApiUrl.lookupAvailableSlots}',
  //       jsonEncode(body),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.body;
  //       debugPrint('Available slots response: $data');
  //       // Expecting: {success: true, message: ..., data: {success: false, message: ..., unavailableDays: [...]}}
  //       if (data is Map && data.containsKey('data')) {
  //         final slotData = data['data'];
  //         if (slotData is Map && slotData['success'] == false) {
  //           return {
  //             'success': false,
  //             'message': slotData['message'] ?? 'Some requested slots are unavailable.',
  //             'unavailableDays': slotData['unavailableDays'] ?? [],
  //           };
  //         }
  //       }
  //       return true;
  //     } else {
  //       debugPrint('Failed to lookup available slots: ${response.body}');
  //       String errorMsg = "Failed to lookup available slots";
  //       try {
  //         final body = response.body;
  //         dynamic decoded;
  //         if (body is String && body.isNotEmpty) {
  //           decoded = jsonDecode(body);
  //         } else if (body is Map) {
  //           decoded = body;
  //         }

  //         if (decoded is Map<String, dynamic>) {
  //           if (decoded['message'] is String && (decoded['message'] as String).isNotEmpty) {
  //             errorMsg = decoded['message'];
  //           }
  //           if (errorMsg.isEmpty &&
  //         decoded['errorSources'] is List &&
  //         decoded['errorSources'].isNotEmpty) {
  //             final firstError = decoded['errorSources'][0];
  //             if (firstError is Map &&
  //           firstError['message'] is String &&
  //           (firstError['message'] as String).isNotEmpty) {
  //         errorMsg = firstError['message'];
  //             }
  //           }
  //           if (errorMsg.isEmpty &&
  //         decoded['err'] is Map &&
  //         decoded['err']['message'] is String) {
  //             errorMsg = decoded['err']['message'];
  //           }
  //         }
  //         return {'success': false, 'message': errorMsg, 'unavailableDays': []};
  //       } catch (e) {
  //         debugPrint('Error parsing error body: $e');
  //       }
  //       EasyLoading.showError(errorMsg);
  //       return {'success': false, 'message': errorMsg, 'unavailableDays': []};
  //     }
  //   } catch (e) {
  //     debugPrint('Error looking up available slots: $e');
  //     EasyLoading.showError('Error looking up available slots');
  //     return false;
  //   } finally {
  //     EasyLoading.dismiss();
  //     isLoading.value = false;
  //     refresh();
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    // Dispose all controllers
    for (final controller in answerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
