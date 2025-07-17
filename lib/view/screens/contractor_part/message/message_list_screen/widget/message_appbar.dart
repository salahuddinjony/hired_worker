import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessageAppBar({super.key, this.imageUrl, this.name});

  final String? imageUrl;
  final String? name;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                  CustomNetworkImage(
                    imageUrl: imageUrl ?? AppConstants.profileImage,
                    height: 55.h,
                    width: 55.w,
                    boxShape: BoxShape.circle,
                  ),
                  Expanded(
                    child: CustomText(
                      left: 10,
                      text: name ?? "Thomas",
                      color: Colors.black,
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
