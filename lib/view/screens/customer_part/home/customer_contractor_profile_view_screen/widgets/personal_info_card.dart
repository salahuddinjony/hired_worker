import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class PersonalInfoCard extends StatelessWidget {
  final String dob;
  final String gender;
  final String city;
  final String language;

  const PersonalInfoCard({
    Key? key,
    required this.dob,
    required this.gender,
    required this.city,
    required this.language,
  }) : super(key: key);

  Widget _row(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(icon, size: 20.w, color: AppColors.primary),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: title, fontSize: 12.w, fontWeight: FontWeight.w400, color: AppColors.black_08),
            CustomText(text: value, fontSize: 14.w, fontWeight: FontWeight.w500, color: AppColors.black),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          children: [
            _row(Icons.cake, "Date of Birth".tr, dob.isNotEmpty ? dob : "N/A"),
            Padding(padding: EdgeInsets.symmetric(vertical: 12.h), child: Divider(color: AppColors.black_08.withValues(alpha: .3), height: 1)),
            _row(Icons.person, "Gender".tr, gender.isNotEmpty ? gender : "N/A"),
            Padding(padding: EdgeInsets.symmetric(vertical: 12.h), child: Divider(color: AppColors.black_08.withValues(alpha: .3), height: 1)),
            _row(Icons.location_city, "City".tr, city.isNotEmpty ? city : "No city specified"),
            Padding(padding: EdgeInsets.symmetric(vertical: 12.h), child: Divider(color: AppColors.black_08.withValues(alpha: .3), height: 1)),
            _row(Icons.language, "Language".tr, language.isNotEmpty ? language : "No language specified"),
          ],
        ),
      ),
    );
  }
}
