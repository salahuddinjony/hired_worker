import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';

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
    debugPrint("ProfileHeader received imageUrl: '$imageUrl'");

    // Check if imageUrl is empty or null
    if (imageUrl.isEmpty || imageUrl == 'null') {
      return Container(
        height: MediaQuery.of(context).size.height / 3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: Stack(
          children: [
            // Default placeholder
            Center(
              child: Icon(
                Icons.person,
                size: 80.w,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            // Custom back button with circular background
            Positioned(
              top: MediaQuery.of(context).padding.top + 10.h,
              left: 16.w,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.w),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.all(8.w),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return CustomNetworkImage(
      imageUrl: imageUrl,
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20.r),
        bottomRight: Radius.circular(20.r),
      ),
      child: Stack(
        children: [
          // Custom back button with circular background
          Positioned(
            top: MediaQuery.of(context).padding.top + 10.h,
            left: 16.w,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white, size: 20.w),
                onPressed: () => Navigator.of(context).pop(),
                padding: EdgeInsets.all(8.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
