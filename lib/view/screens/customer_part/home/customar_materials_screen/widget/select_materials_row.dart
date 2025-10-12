import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class SelectMaterialsRow extends StatelessWidget {
  final String? name;
  final String? unit;
  final String price;
  final String count;
  final bool isSelected;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  
  const SelectMaterialsRow({
    super.key, 
    this.name,
    this.unit,
    this.count = '0',
    required this.price,
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
                    // Safely parse price; if invalid default to 0
                    double current = double.tryParse(price) ?? 0;
                    // Decrement until zero
                    while (current > 0) {
                      onDecrement!();
                      current--;
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
                  CustomText(
                      text: "Unit price: \$${price}", 
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
                icon: const Icon(
                  Icons.remove,
                  color: AppColors.black,
                  size: 18,
                ),
              ),
              CustomText(
                text: count,
                fontSize: 24.w,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                right: 4,
                left: 4,
              ),
              IconButton(
                onPressed: onIncrement,
                icon: const Icon(
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
