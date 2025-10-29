import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_button/custom_button.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:servana/view/screens/authentication/controller/auth_controller.dart';
import 'package:servana/view/screens/contractor_part/complete_your_profile/controller/map_controller.dart';
import '../controller/customer_profile_controller.dart';

class AddAddressBottomSheet extends StatefulWidget {
  final String address;
  final String? locationId;
  final double? latitude;
  final double? longitude;
  final String? street;
  final String? unit;
  final String? directions;
  final bool isUpdate;
  final String? name;
  final bool isFromProfile;
  final bool isSignUp;

  const AddAddressBottomSheet({
    super.key,
    required this.address,
    this.latitude,
    this.locationId,
    this.longitude,
    this.street,
    this.unit,
    this.directions,
    this.isUpdate = false,
    this.isFromProfile = false,
    this.isSignUp = false,
    this.name,
  });

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final CustomerProfileController controller =
      Get.find<CustomerProfileController>();
  final AuthController authController = Get.find<AuthController>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();
  String selectedType = 'Home';
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    addressController.text = widget.address;
    streetController.text = widget.street ?? '';
    unitController.text = widget.unit ?? '';
    directionsController.text = widget.directions ?? '';
    selectedType = widget.name ?? 'Home';
    latitude = widget.latitude;
    longitude = widget.longitude;
  }

  @override
  void dispose() {
    addressController.dispose();
    streetController.dispose();
    unitController.dispose();
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
                    text:
                        widget.isUpdate
                            ? "Update Address".tr
                            : "Address Details".tr,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),

                  const Spacer(),
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
                isUpdate: widget.isSignUp || widget.isUpdate,
                controller: addressController,
                hint: 'Address / Building Name',
                icon: Icons.location_on_outlined,
              ),

              SizedBox(height: 16.h),

              // Street Name
              CustomText(
                text: "Street Name".tr,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700]!,
              ),
              SizedBox(height: 12.h),
              _buildTextField(
                controller: streetController,
                hint: 'Street Name',

                icon: Icons.edit_road,
              ),

              SizedBox(height: 16.h),

              // Unit / House No
              _buildTextField(
                controller: unitController,
                hint: 'Unit / House No.',
                icon: Icons.home_work_outlined,
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
                onTap: () async {
                  print('🔴 BUTTON CLICKED - START');
                  debugPrint('=== Save Address Button Tapped ===');
                  debugPrint('Address: ${addressController.text}');
                  debugPrint('Street: ${streetController.text}');
                  debugPrint('Unit/House: ${unitController.text}');
                  debugPrint('Directions: ${directionsController.text}');
                  debugPrint('Type: $selectedType');
                  debugPrint('Latitude: $latitude');
                  debugPrint('Longitude: $longitude');

                  if (addressController.text.isEmpty) {
                    debugPrint('Error: Address is empty');
                    Get.snackbar(
                      'Error',
                      'Please enter an address',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      margin: const EdgeInsets.all(16),
                      borderRadius: 8,
                    );
                    return;
                  }

                  try {
                    if (widget.isUpdate && widget.isSignUp == false) {
                      debugPrint('Updating existing address...');
                      await controller.patchAddress(
                        locationId: widget.locationId ?? '',
                        address: addressController.text,
                        coordinates: [
                          if (latitude != null) latitude!,
                          if (longitude != null) longitude!,
                        ],
                        street:
                            streetController.text.isNotEmpty
                                ? streetController.text
                                : null,
                        unit:
                            unitController.text.isNotEmpty
                                ? unitController.text
                                : null,
                        directions:
                            directionsController.text.isNotEmpty
                                ? directionsController.text
                                : null,
                        name: selectedType,
                      );
                      debugPrint('Address updated successfully!');
                      return;
                    }
                    if(widget.isSignUp){
                      debugPrint('Saving address during sign-up...');
                      authController.updateAddressFromMap({
                        'address': addressController.text,
                        'latitude': latitude,
                        'longitude': longitude,
                        'street': streetController.text.isNotEmpty
                            ? streetController.text
                            : null,
                        'unit': unitController.text.isNotEmpty
                            ? unitController.text
                            : null,
                        'direction': directionsController.text.isNotEmpty
                            ? directionsController.text
                            : null,
                      });
                      debugPrint('Address saved to AuthController during sign-up!');
                      Navigator.of(context).pop();
                      return;
                    }

                    debugPrint('Calling addNewAddress...');

                    controller.addNewAddress(
                      title: selectedType,
                      address:
                          (streetController.text.isNotEmpty
                              ? '${streetController.text}, '
                              : '') +
                          addressController.text,
                      unit:
                          unitController.text.isNotEmpty
                              ? unitController.text
                              : null,
                      street:
                          streetController.text.isNotEmpty
                              ? streetController.text
                              : null,
                      directions:
                          directionsController.text.isNotEmpty
                              ? directionsController.text
                              : null,
                      latitude: latitude,
                      longitude: longitude,
                      isFromProfile: widget.isFromProfile,
                    );

                    debugPrint('Address saved successfully!');
                    debugPrint('Closing add address bottom sheet...');

                    // Close current bottom sheet using both methods
                    Navigator.of(context).pop();
                    debugPrint('✅ Navigator.pop() called');

                    // Small delay for clean animation
                    await Future.delayed(const Duration(milliseconds: 500));

                    debugPrint('Opening saved addresses bottom sheet...');
                    // Open saved addresses list
                    controller.showAddressBottomSheet();
                    debugPrint('✅ showAddressBottomSheet() called');
                  } catch (e) {
                    debugPrint('❌ Error saving address: $e');
                    Get.snackbar(
                      'Error',
                      'Failed to save address: $e',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                title:widget.isSignUp? "Continue".tr:
                    widget.isUpdate ? "Update Address".tr : "Save Address".tr, 
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
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.grey[100],
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
    bool isUpdate = false,
    required TextEditingController controller,
    required String hint,
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!, width: 1),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            GestureDetector(
              onTap: () async {
                if (isUpdate) {
                  debugPrint('Edit icon tapped - to open map screen ');
                  if (!Get.isRegistered<MapController>()) {
                    Get.put(MapController());
                  }

                  final result = await Get.toNamed(
                    '/SeletedMapScreen',
                    arguments: {'returnData': true},
                  );

                  // If location is selected, update address, latitude, longitude
                  if (result != null && result is Map<String, dynamic>) {
                    final address = result['address'] ?? '';
                    final lat = result['latitude'];
                    final lng = result['longitude'];
                    setState(() {
                      addressController.text = address;
                      latitude =
                          lat is double ? lat : double.tryParse(lat.toString());
                      longitude =
                          lng is double ? lng : double.tryParse(lng.toString());
                    });
                  }
                } else {
                  debugPrint('Icon tapped - no action defined yet.');
                  return null;
                }
              },
              child: Icon(icon, color: AppColors.primary, size: 20.sp),
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
