import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../utils/app_colors/app_colors.dart';
import '../../../../../components/custom_image/custom_image.dart';
import '../../../../../components/custom_text/custom_text.dart';

class CustomProfileMenuList extends StatelessWidget {
  final String? name;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final String? image;
  final IconData? iconData;
  final Function()? onTap;
  const CustomProfileMenuList({
    super.key,
    this.name,
    this.iconData,
    this.image,
    this.onTap,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  image != null
                      ? CustomImage(imageSrc: image!, height: 24.h, width: 24.w)
                      : Icon(
                        (iconData) ?? Icons.settings,
                        size: 24.w,
                        color: const Color.fromARGB(221, 80, 78, 78),
                      ),
                  CustomText(
                    text: name ?? "Payments Methods".tr,
                    fontSize: 18.w,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    left: 8.w,
                  ),
                ],
              ),
              if (showSwitch)
                Switch(value: switchValue, onChanged: onSwitchChanged),
            ],
          ),
        ),
      ),
    );
  }
}
