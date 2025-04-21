import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class SelectMaterialsRow extends StatelessWidget {
  const SelectMaterialsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(value: true, onChanged: (value){}),
              CustomText(text: "Powerpoint", fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.black,)
            ],
          ),
          CustomText(text: "50\$", fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.black,)
        ],
      ),
    );
  }
}
