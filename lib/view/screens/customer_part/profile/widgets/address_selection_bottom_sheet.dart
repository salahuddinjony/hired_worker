import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../controller/customer_profile_controller.dart';
import '../model/address_model.dart';

class AddressSelectionBottomSheet extends StatelessWidget {
  const AddressSelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomerProfileController controller = Get.find<CustomerProfileController>();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 1, 
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: .1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: "Saved Addresses".tr,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ],
                ),
                // Close button
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 18.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1.h, thickness: 1, color: Colors.grey[200]),
          
          SizedBox(height: 12.h),

          // Add New Address Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: InkWell(
              onTap: () {
                Get.back();
                controller.showAddAddressDialog();
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withValues(alpha: .8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: .3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    CustomText(
                      text: "Add New Address".tr,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Address List - SCROLLABLE SECTION
          Flexible(
            child: Obx(
              () => controller.savedAddresses.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Column(
                        children: [
                          Icon(
                            Icons.location_off_outlined,
                            size: 64.sp,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 16.h),
                          CustomText(
                            text: "No saved addresses yet".tr,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[600]!,
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: "Add your first address above".tr,
                            fontSize: 13.sp,
                            color: Colors.grey[400]!,
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(), // ✅ Made scrollable
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                      itemCount: controller.savedAddresses.length,
                      separatorBuilder: (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final address = controller.savedAddresses[index];
                        return _AddressItem(
                          address: address,
                          onTap: () {
                            controller.selectAddress(index);
                            Get.back();
                          },
                        );
                      },
                    ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {
  final SavedAddress address;
  final VoidCallback onTap;

  const _AddressItem({
    required this.address,
    required this.onTap,
  });

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return Icons.home_rounded;
      case 'work':
        return Icons.business_rounded;
      case 'other':
        return Icons.location_on_rounded;
      default:
        return Icons.location_on_rounded;
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'home':
        return Colors.orange;
      case 'work':
        return Colors.blue;
      case 'other':
        return Colors.purple;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final typeColor = _getColorForType(address.title);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: address.isSelected 
              ? AppColors.primary.withValues(alpha: 0.05) 
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: address.isSelected 
                ? AppColors.primary 
                : Colors.grey[200]!,
            width: address.isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon with type indicator
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getIconForType(address.title),
                color: typeColor,
                size: 24.w,
              ),
            ),

            SizedBox(width: 12.w),

            // Address Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Type Badge
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: typeColor.withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: address.title.toUpperCase(),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w700,
                          color: typeColor,
                        ),
                      ),
                      if (address.isSelected) ...[
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                          size: 16.sp,
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 6.h),
                  CustomText(
                    text: address.flatNo != null && address.flatNo!.isNotEmpty
                        ? '${address.flatNo}, ${address.address}'
                        : address.address,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: Colors.grey[500],
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: CustomText(
                          text: address.city,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600]!,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  // if (address.directions != null && address.directions!.isNotEmpty) ...[
                  //   SizedBox(height: 4.h),
                  //   Row(
                  //     children: [
                  //       Icon(
                  //         Icons.info_outline,
                  //         size: 14.sp,
                  //         color: Colors.grey[400],
                  //       ),
                  //       SizedBox(width: 4.w),
                  //       Expanded(
                  //         child: CustomText(
                  //           text: address.directions!,
                  //           fontSize: 11.sp,
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.grey[500]!,
                  //           maxLines: 1,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ],
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Radio Button
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: address.isSelected ? AppColors.primary : Colors.grey[400]!,
                  width: 2,
                ),
                color: address.isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: address.isSelected
                  ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
