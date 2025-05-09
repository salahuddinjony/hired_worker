import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../../utils/app_icons/app_icons.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';
class CustomProfileMenuList extends StatelessWidget {
  final String? name;
  final String? image;
  final Function()? onTap;
 const CustomProfileMenuList({super.key, this.name, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            children: [
              CustomImage(imageSrc: image?? AppIcons.payment,),
              CustomText(text:name??  "Payments Methods", fontSize: 18.w,fontWeight: FontWeight.w600,color: AppColors.black,left: 8.w,)
            ],
          ),
        ),
      ),
    );
  }
}
