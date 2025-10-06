import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String role;
  final String location;

  const ProfileHeader({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomNetworkImage(
      imageUrl: imageUrl,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.r),
        bottomRight: Radius.circular(20.r),
      ),
      child: CustomRoyelAppbar(leftIcon: true),
    );
  }
}
