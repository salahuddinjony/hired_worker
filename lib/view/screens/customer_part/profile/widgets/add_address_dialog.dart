import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../controller/customer_profile_controller.dart';

class AddAddressBottomSheet extends StatefulWidget {
  final String address;
  final double? latitude;
  final double? longitude;

  const AddAddressBottomSheet({
    super.key,
    required this.address,
    this.latitude,
    this.longitude,
  });

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final CustomerProfileController controller = Get.find<CustomerProfileController>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();
  String selectedType = 'Home';

  @override
  void initState() {
    super.initState();
    addressController.text = widget.address;
  }

  @override
  void dispose() {
    addressController.dispose();
    flatController.dispose();
    directionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            20.h,
            20.w,
            MediaQuery.of(context).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // Title with icon
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withOpacity(0.8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  CustomText(
                    text: "Address Details".tr,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ],
              ),
              
              SizedBox(height: 24.h),

              // Address Type Selection Label
              CustomText(
                text: "Address Type".tr,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700]!,
              ),
              
              SizedBox(height: 12.h),

              // Address Type Selection
              Row(
                children: [
                  Expanded(child: _buildTypeChip('Home')),
                  SizedBox(width: 10.w),
                  Expanded(child: _buildTypeChip('Work')),
                  SizedBox(width: 10.w),
                  Expanded(child: _buildTypeChip('Other')),
                ],
              ),

              SizedBox(height: 24.h),

              // Address Field
              _buildTextField(
                controller: addressController,
                hint: 'Address / Building Name',
                icon: Icons.location_on_outlined,
              ),

              SizedBox(height: 16.h),

              // Flat / Villa No
              _buildTextField(
                controller: flatController,
                hint: 'Flat / Villa No.',
                icon: Icons.apartment_outlined,
              ),

              SizedBox(height: 16.h),

              // Directions (Optional)
              _buildTextField(
                controller: directionsController,
                hint: 'Directions (Optional)',
                icon: Icons.directions_outlined,
              ),

              SizedBox(height: 30.h),

              // Save Button
              CustomButton(
                onTap: () {
                  if (addressController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'Please enter an address',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  
                  controller.addNewAddress(
                    title: selectedType,
                    address: addressController.text,
                    flatNo: flatController.text,
                    directions: directionsController.text,
                    latitude: widget.latitude,
                    longitude: widget.longitude,
                  );
                  
                  Get.back();
                },
                title: "Save Address".tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(String label) {
    final isSelected = selectedType == label;
    
    IconData icon;
    Color color;
    switch (label.toLowerCase()) {
      case 'home':
        icon = Icons.home_rounded;
        color = Colors.orange;
        break;
      case 'work':
        icon = Icons.business_rounded;
        color = Colors.blue;
        break;
      case 'other':
        icon = Icons.location_on_rounded;
        color = Colors.purple;
        break;
      default:
        icon = Icons.location_on_rounded;
        color = AppColors.primary;
    }
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[500],
              size: 24.sp,
            ),
            SizedBox(height: 6.h),
            CustomText(
              text: label.tr,
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? color : Colors.grey[600]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: AppColors.primary,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
