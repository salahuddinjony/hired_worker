import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomSkillsContainer extends StatelessWidget {
  final String? text;
  const CustomSkillsContainer({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Card(
        color: AppColors.white,
          elevation: .2,
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomText(text: text ?? "text", fontSize: 12.w,fontWeight: FontWeight.w500,color: AppColors.black,),
      )),
    );
  }
}
