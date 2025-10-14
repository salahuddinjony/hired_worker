import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/message/chat/inbox_screen/screen/inbox_screen.dart';
import 'package:servana/view/screens/message/message_list_screen/message_list_screen.dart';
import 'package:servana/view/screens/customer_part/home/customer_home_screen/customer_home_screen.dart';
import '../../../utils/app_colors/app_colors.dart';
import '../../../utils/app_icons/app_icons.dart';
import '../../screens/customer_part/order/customer_request_history_screen/customer_request_history_screen.dart';
import '../../screens/customer_part/profile/customer_profile_screen/customer_profile_screen.dart';

class CustomerNavbar extends StatefulWidget {
  final int currentIndex;
  const CustomerNavbar({super.key, required this.currentIndex});

  @override
  State<CustomerNavbar> createState() => _NavbarState();
}

class _NavbarState extends State<CustomerNavbar> {
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
        Get.offAll(() => const CustomerHomeScreen());
        break;
      case 1:
        Get.to(() => const CustomerRequestHistoryScreen());
        break;
      case 2:
        Get.to(() => InboxScreen());
        break;
      case 3:
        Get.to(() => const CustomerProfileScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
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
      duration: const Duration(milliseconds: 300),
      height: isSelected ? 32.h : 26.h,
      width: isSelected ? 32.h : 26.h,
      child: SvgPicture.asset(
        assetName,
        colorFilter: isSelected ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) : const ColorFilter.mode(Colors.white70, BlendMode.srcIn),
      ),
    );
  }
}
