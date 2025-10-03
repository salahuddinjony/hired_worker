import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class SelectMaterialsRow extends StatelessWidget {
  final String? name;
  final String? unit;
  final String quantity;
  final bool isSelected;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  
  const SelectMaterialsRow({
    super.key, 
    this.name,
    this.unit,
    required this.quantity,
    required this.isSelected,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: isSelected, 
                onChanged: (value) {
                  if (value == true && onIncrement != null) {
                    onIncrement!();
                  } else if (value == false && onDecrement != null) {
                    // Set quantity to 0 when unchecked
                    while (int.parse(quantity) > 0 && onDecrement != null) {
                      onDecrement!();
                    }
                  }
                }
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name ?? "Material", 
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  if (unit != null)
                    CustomText(
                      text: "Unit: $unit", 
                      fontSize: 12.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_08,
                    ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: Icon(
                  Icons.remove,
                  color: AppColors.black,
                  size: 18,
                ),
              ),
              CustomText(
                text: quantity,
                fontSize: 24.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                right: 4,
                left: 4,
              ),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(
                  Icons.add,
                  color: AppColors.black,
                  size: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
