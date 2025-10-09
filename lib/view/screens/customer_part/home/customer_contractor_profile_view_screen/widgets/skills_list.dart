import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/customer_part/home/customer_contractor_profile_view_screen/widgets/custom_skills_container.dart';

class SkillsList extends StatelessWidget {
  final List<String> skills;

  const SkillsList({Key? key, required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: CustomText(text: "Skills", fontSize: 16.w, fontWeight: FontWeight.w600, color: Colors.black, bottom: 8.h),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (skills.isNotEmpty
                ? skills.map((e) => CustomSkillsContainer(text: e)).toList()
                : [CustomSkillsContainer(text: "No skills listed")]),
          ),
        ),
      ],
    );
  }
}
