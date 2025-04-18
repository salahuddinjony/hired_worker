// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../custom_image/custom_image.dart';
import '../custom_text/custom_text.dart';

class CustomRoyelAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleName;
  final String? rightIcon;
  //final void Function()? leftOnTap;
  final void Function()? rightOnTap;
  final bool? leftIcon;
  final Color? color;

  const CustomRoyelAppbar({
    super.key,
    this.titleName,
   // this.leftOnTap,
    this.rightIcon,
    this.rightOnTap,
    this.leftIcon = false, this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 80,
        elevation: 0,
        foregroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                rightOnTap!();
              },
              icon: rightIcon == null ? SizedBox(): CustomImage(imageSrc: rightIcon!, height: 32,width: 32,)),

        ],
        backgroundColor: Colors.transparent,
        leading: leftIcon == true
            ? BackButton(color: color?? AppColors.black,)
            : null,
        title: CustomText(
          text: titleName ?? "",
          fontSize: 20.w,
          fontWeight: FontWeight.w600,
          color:color?? AppColors.primary,
        ));
  }

  @override
  // TO DO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60);
}
