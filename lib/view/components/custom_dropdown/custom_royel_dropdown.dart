import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

class CustomRoyelDropdown extends StatelessWidget {
  final List<String> list;
  final RxString selectedValue;
  final String title;
  final double height;
  final double? width;
  final Color? fillColor;
  final Color textColor;
  final double? fontSize;
  final bool isBorder;
  final double? borderWidth;
  final double? borderRadius;

  const CustomRoyelDropdown({
    super.key,
    required this.list,
    required this.selectedValue,
    required this.title,
    this.height = 55,
    this.width = double.maxFinite,
    this.fillColor = Colors.transparent,
    this.textColor = AppColors.black,
    this.fontSize,
    this.isBorder = false,
    this.borderWidth,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        padding: EdgeInsets.only(left: 10.w),
        decoration: BoxDecoration(
          border: isBorder
              ? Border.all(color: AppColors.primary, width: borderWidth ?? 1)
              : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 8),
          color: fillColor,
        ),
        child: DropdownButton<String>(
          padding: EdgeInsets.only(right: 20.w),
          hint: CustomText(
            text: title,
            fontSize: fontSize ?? 18.sp,
            color: textColor,
            fontWeight: FontWeight.w500,
            right: 15.w,
          ),
          borderRadius: BorderRadius.circular(10),
          elevation: 2,
          dropdownColor: AppColors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.primary,
          ),
          iconSize: 25,
          underline: const SizedBox(),
          isExpanded: true,
          value: selectedValue.value.isNotEmpty ? selectedValue.value : null,
          onChanged: (String? newValue) {
            if (newValue != null) selectedValue.value = newValue;
          },
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12.w),
          items: list.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: CustomText(
                text: item,
                color: AppColors.black,
                fontSize: 15.w,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
