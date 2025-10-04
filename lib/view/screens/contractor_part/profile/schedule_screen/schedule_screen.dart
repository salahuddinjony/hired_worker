import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/screens/contractor_part/profile/controller/profile_controller.dart';
import 'package:servana/view/screens/contractor_part/profile/schedule_screen/controller/schedule_controller.dart';

import '../../../../components/custom_button/custom_button.dart';
import '../../../../components/custom_loader/custom_loader.dart';
import '../model/contractor_model.dart';

class ScheduleScreen extends StatelessWidget {
  final List<String> days = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final List<String> fullDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final mySchedule =
        profileController.contractorModel.value.data?.contractor?.myScheduleId;

    final ScheduleController controller = Get.find<ScheduleController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Schedule".tr),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              itemCount: days.length,
              itemBuilder: (context, index) {
                return AvailabilityTile(
                  day: days[index],
                  fullDay: fullDays[index],
                  schedule: mySchedule,
                );
              },
            ),
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
            child: Obx(() {
              return controller.status.value.isLoading
                  ? CustomLoader()
                  : CustomButton(
                onTap: () => controller.updateContractorData(),
                title: "Save".tr,
              );
            }),
          ),
        ],
      ),
    );
  }
}

class AvailabilityTile extends StatefulWidget {
  final String day;
  final String fullDay;
  final MyScheduleId? schedule;

  const AvailabilityTile({
    super.key,
    required this.day,
    required this.fullDay,
    required this.schedule,
  });

  @override
  State<AvailabilityTile> createState() => _AvailabilityTileState();
}

class _AvailabilityTileState extends State<AvailabilityTile> {
  bool isAvailable = false;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  final ScheduleController controller = Get.find<ScheduleController>();

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
  }

  void _initializeSchedule() {
    // Find the schedule for this day
    final daySchedule = widget.schedule?.schedules?.firstWhere(
          (schedule) => schedule.days == widget.fullDay,
      orElse: () => Schedule(),
    );

    if (daySchedule?.timeSlots != null && daySchedule!.timeSlots!.isNotEmpty) {
      final timeSlot = daySchedule.timeSlots!.first;
      final times = timeSlot.split('-');

      if (times.length == 2) {
        // Parse start time
        final startParts = times[0].split(':');
        if (startParts.length == 2) {
          final startHour = int.parse(startParts[0]);
          final startMinute = int.parse(startParts[1]);
          startTime = TimeOfDay(hour: startHour, minute: startMinute);
        }

        // Parse end time
        final endParts = times[1].split(':');
        if (endParts.length == 2) {
          final endHour = int.parse(endParts[0]);
          final endMinute = int.parse(endParts[1]);
          endTime = TimeOfDay(hour: endHour, minute: endMinute);
        }

        // Set availability to true if we have valid times
        if (startTime != null && endTime != null) {
          isAvailable = true;
        }
      }
    }

    // Notify controller after initialization
    _notifyController();
  }

  void _notifyController() {
    controller.updateDaySchedule(
      widget.day,
      widget.fullDay,
      isAvailable,
      startTime,
      endTime,
    );
  }

  Future<void> pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (startTime ?? const TimeOfDay(hour: 9, minute: 0))
          : (endTime ?? const TimeOfDay(hour: 18, minute: 0)),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }

        // Auto-enable availability when times are selected
        if (startTime != null && endTime != null) {
          isAvailable = true;
        }
        _notifyController(); // Notify controller of changes
      });
    }
  }

  String formatTime(TimeOfDay? time) {
    if (time == null) return "--:--";
    final hour = time.hourOfPeriod.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? "AM" : "PM";
    return "$hour:$minute $period";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Text(
              widget.day,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () => pickTime(isStart: true),
                          child: Text(
                            formatTime(startTime),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const Text("  -  "),
                        GestureDetector(
                          onTap: () => pickTime(isStart: false),
                          child: Text(
                            formatTime(endTime),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Available".tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Switch(
                      value: isAvailable,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          isAvailable = value;
                          // Clear times when turning off availability
                          if (!value) {
                            startTime = null;
                            endTime = null;
                          } else {
                            // Set default times when turning on availability
                            startTime ??= const TimeOfDay(hour: 9, minute: 0);
                            endTime ??= const TimeOfDay(hour: 18, minute: 0);
                          }
                          _notifyController(); // Notify controller of changes
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}