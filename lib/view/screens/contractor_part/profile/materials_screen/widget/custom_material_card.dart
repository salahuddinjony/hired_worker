import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomMaterialCard extends StatelessWidget {
  const CustomMaterialCard({super.key, required this.title, required this.price, required this.unit});
  final String title;
  final String price;
  final String unit;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withValues(alpha: .5)),
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 16.w,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                bottom: 4.h,
              ),
              CustomText(
                text: "$unit\$ / feet",
                fontSize: 14.w,
                fontWeight: FontWeight.w500,
                color: AppColors.textCLr,
                bottom: 4.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xffCDB3CD),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CustomText(
                  text: "\$$price",
                  fontSize: 12.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit, color: AppColors.black),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outline, color: AppColors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
