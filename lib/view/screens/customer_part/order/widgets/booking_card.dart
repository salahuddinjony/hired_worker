import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/helper/shared_prefe/shared_prefe.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/extension/extension.dart';
import 'package:servana/view/screens/customer_part/home/customar_qa_screen/booking_controller/contractor_booking_controller.dart';
import '../model/customer_order_model.dart';

typedef BookingTapCallback = void Function(BookingResult booking);

class BookingCard extends StatelessWidget {
  final BookingResult booking;
  final controller;
  final bool isCompleted;
  final VoidCallback? onTap;

  BookingCard({Key? key, required this.booking, this.onTap, this.controller})
    : isCompleted = (booking.status ?? '').toLowerCase() == 'completed',
      super(key: key);

  // Create a unique loading state for this booking
  final RxBool isLoadingConversation = false.obs;

  @override
  Widget build(BuildContext context) {
    final status = (booking.status ?? '').toLowerCase();
    
    // Define colors based on status
    Color borderColor;
    Color statusBgColor;
    Color statusTextColor;
    
    switch (status) {
      case 'completed':
        borderColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: .15);
        statusTextColor = Colors.green.shade700;
        break;
      case 'accepted':
        borderColor = Colors.blue;
        statusBgColor = Colors.blue.withValues(alpha: .15);
        statusTextColor = Colors.blue.shade700;
        break;
      case 'ongoing':
      case 'on-going':
        borderColor = Colors.purple;
        statusBgColor = Colors.purple.withValues(alpha: .15);
        statusTextColor = Colors.purple.shade700;
        break;
      case 'pending':
        borderColor = Colors.amber;
        statusBgColor = Colors.amber.withValues(alpha: .15);
        statusTextColor = Colors.amber.shade800;
        break;
      case 'rejected':
      case 'cancelled':
        borderColor = Colors.red;
        statusBgColor = Colors.red.withValues(alpha: .15);
        statusTextColor = Colors.red.shade700;
        break;
      default:
        borderColor = const Color(0xffCDB3CD);
        statusBgColor = const Color(0xffCDB3CD).withValues(alpha: .25);
        statusTextColor = AppColors.primary;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: borderColor.withValues(alpha: .25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: borderColor.withValues(alpha: .15),
                        child: const CustomImage(imageSrc: AppIcons.cleaner),
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: booking.subCategoryId?.name ?? 'Service',
                            fontSize: 16.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                            bottom: 4.h,
                          ),
                          CustomText(
                            text: '#${booking.bookingId ?? ''}',
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff6F767E),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_sharp),
                ],
              ),
              const Divider(thickness: .6, color: AppColors.white),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Status".tr,
                    fontSize: 14.w,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff6F767E),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: CustomText(
                      text: booking.status ?? '',
                      fontSize: 14.w,
                      fontWeight: FontWeight.w600,
                      color: statusTextColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                children: [
                  const CustomImage(imageSrc: AppIcons.calenderIcon),
                  SizedBox(width: 12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text:
                            '${booking.startTime ?? ''} - ${booking.endTime ?? ''}, ${(booking.bookingDate != null && booking.bookingDate!.isNotEmpty) ? DateTime.parse(booking.bookingDate!).formatDate() : ''}',
                        fontSize: 16.w,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                        bottom: 4.h,
                      ),
                      CustomText(
                        text: 'Schedule'.tr,
                        fontSize: 12.w,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff6F767E),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 26,
                          child: CustomImage(imageSrc: AppIcons.girlVactor),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text:
                                    booking.contractorId != null
                                        ? '${booking.contractorId?.fullName.safeCap() ?? ''}'
                                        : 'Not Assigned',
                                fontSize: 16.w,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                                bottom: 4.h,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              CustomText(
                                text: 'Service provider'.tr,
                                fontSize: 12.w,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff6F767E),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffCDB3CD),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        if (booking.status?.toLowerCase() != 'pending') {
                          debugPrint('Navigate to message screen');

                          // Set loading state for this specific card
                          isLoadingConversation.value = true;

                          try {
                            final loggedUserId =
                                await SharePrefsHelper.getString(
                                  AppConstants.userId,
                                );
                            final loggedUserRole =
                                await SharePrefsHelper.getString(
                                  AppConstants.role,
                                );

                            final conversationId = await controller
                                .createOrRetrieveConversation(
                                  senderId: loggedUserId,
                                  receiverId: booking.contractorId?.id ?? '',
                                );

                            if (conversationId != null &&
                                conversationId.isNotEmpty) {
                              Get.toNamed(
                                AppRoutes.chatScreen,
                                arguments: {
                                  'receiverName':
                                      booking.contractorId?.fullName ??
                                      'Service Provider',
                                  'receiverImage':
                                      booking.contractorId?.img ?? '',
                                  'conversationId': conversationId,
                                  'userId': loggedUserId,
                                  'receiverId': booking.contractorId?.id,
                                  'userRole': loggedUserRole,
                                  'isCustomer': loggedUserRole == 'customer',
                                },
                              );
                            } else {
                              debugPrint(
                                'Error: Conversation ID is null or empty',
                              );
                            }
                          } finally {
                            // Reset loading state
                            isLoadingConversation.value = false;
                          }
                        } else {
                          final controller =
                              Get.find<ContractorBookingController>();
                          Get.toNamed(
                            AppRoutes.customarMaterialsScreen,
                            arguments: {
                              'contractorId': booking.contractorId?.id,
                              'subcategoryId': booking.subCategoryId?.id ?? '',
                              'materials': booking.material,
                              'controller': controller,
                              'contractorName': booking.contractorId?.fullName,
                              'categoryName': "",
                              'subCategoryName': booking.subCategoryId?.name ?? '',
                              // Pass booking schedule data for updates
                              'bookingType': booking.bookingType ?? 'oneTime',
                              'duration': booking.duration?.toString() ?? '1',
                              'startTime': booking.startTime ?? '',
                              'endTime': booking.endTime ?? '',
                              'selectedDates':
                                  booking.day is List
                                      ? (booking.day as List)
                                          .map((e) => e.toString())
                                          .toList()
                                      : booking.day is String
                                      ? [booking.day as String]
                                      : [],
                              'hourlyRate': booking.rateHourly ?? 0,
                              'bookingId':booking.id,
                              'isUpdate': true, // Indicate this is an update
                            },
                          );
                        }
                      },
                      child: Obx(
                        () => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            isLoadingConversation.value
                                ? SizedBox(
                                  width: 18.w,
                                  height: 18.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.primary,
                                  ),
                                )
                                : Icon(
                                  booking.status?.toLowerCase() == 'pending'
                                      ? Icons.edit
                                      : Icons.message,
                                  color: AppColors.primary,
                                  size: 18.w,
                                ),
                            SizedBox(width: 6.w),
                            CustomText(
                              text:
                                  booking.status?.toLowerCase() == 'pending'
                                      ? 'Update'.tr
                                      : 'Message'.tr,
                              fontSize: 14.w,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
