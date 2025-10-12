import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class ScheduleWidget extends StatelessWidget {
  final dynamic scheduleModel;

  const ScheduleWidget({Key? key, this.scheduleModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (scheduleModel == null || (scheduleModel.schedules?.isEmpty ?? true)) {
      return Row(
        children: [
          // reuse the skills container for compact UI
          const Text("No schedule"),
          SizedBox(width: 6.w),
          CustomText(text: "available", fontSize: 14.w, fontWeight: FontWeight.w500, color: AppColors.black_08),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: scheduleModel.schedules.map<Widget>((schedule) {
        return Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 96.w,
                child: CustomText(text: schedule.days, fontSize: 14.w, fontWeight: FontWeight.w600, color: AppColors.black),
              ),
              Container(height: 28.h, width: 1.w, margin: EdgeInsets.symmetric(horizontal: 12.w), color: AppColors.black_08.withValues(alpha: .12)),
              // Let the chips size to their content (no artificial max width)
              Expanded(
                child: Wrap(
                  spacing: 10.w,
                  runSpacing: 8.h,
                  alignment: WrapAlignment.start,
                  children: schedule.timeSlots.map<Widget>((timeSlot) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.black_08.withValues(alpha: .06)),
                      ),
                      child: Center(
                        child: CustomText(
                          text: timeSlot,
                          fontSize: 13.w,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
