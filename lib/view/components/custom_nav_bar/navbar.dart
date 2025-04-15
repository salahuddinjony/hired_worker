// ignore_for_file: prefer_const_constructors

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../screens/contractor_part/home/home_screen/home_screen.dart';
import '../../screens/contractor_part/home/order_screen/order_screen.dart';
import '../../screens/contractor_part/message/message_list_screen/message_list_screen.dart';
import '../../screens/contractor_part/profile/profile_screen/profile_screen.dart';

class Navbar extends StatefulWidget {
  final int currentIndex;
  const Navbar({super.key, required this.currentIndex});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late int bottomNavIndex;

  final List<String> selectedIcon = [
    AppIcons.home,
    AppIcons.order,
    AppIcons.message,
    AppIcons.profile,
  ];

  @override
  void initState() {
    bottomNavIndex = widget.currentIndex;
    super.initState();
  }

  void _handleTap(int index) {
    if (bottomNavIndex == index) return;

    setState(() {
      bottomNavIndex = index;
    });

    switch (index) {
      case 0:
        Get.offAll(() => HomeScreen());
        break;
      case 1:
       Get.to(() => OrderScreen());
        break;
      case 2:
       Get.to(() => MessageListScreen());
        break;
      case 3:
       Get.to(() => ProfileScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 75.h,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      index: bottomNavIndex,
      backgroundColor: Colors.transparent,
      color: AppColors.primary,
      onTap: _handleTap,
      items: List.generate(selectedIcon.length, (i) {
        return CustomNavIcon(
          assetName: selectedIcon[i],
          isSelected: i == bottomNavIndex,
        );
      }),
    );
  }
}

class CustomNavIcon extends StatelessWidget {
  final String assetName;
  final bool isSelected;

  const CustomNavIcon({
    super.key,
    required this.assetName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isSelected ? 32.h : 26.h,
      width: isSelected ? 32.h : 26.h,
      child: SvgPicture.asset(
        assetName,
        color: isSelected ? Colors.white : Colors.white70,
      ),
    );
  }
}