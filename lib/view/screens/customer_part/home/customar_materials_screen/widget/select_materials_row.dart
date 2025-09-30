import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_text/custom_text.dart';
class SelectMaterialsRow extends StatelessWidget {
  final String? name;
  const SelectMaterialsRow({super.key, this.name});

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
              CustomText(text: name ??"Powerpoint", fontSize: 14.w,fontWeight: FontWeight.w500,color: AppColors.black,)
            ],
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.remove,color: AppColors.black,size: 18,),),
              CustomText(text: "0",fontSize: 24.w,fontWeight: FontWeight.w500,color: AppColors.black,right: 4,left: 4,),
              IconButton(onPressed: (){}, icon: Icon(Icons.add,color: AppColors.black,size: 18,),),
            ],
          )
        ],
      ),
    );
  }
}
