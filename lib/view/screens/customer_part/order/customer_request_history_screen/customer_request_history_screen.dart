import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/core/app_routes/app_routes.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/utils/app_icons/app_icons.dart';
import 'package:servana/view/components/custom_image/custom_image.dart';
import 'package:servana/view/components/custom_nav_bar/customer_navbar.dart';
import 'package:servana/view/components/custom_netwrok_image/custom_network_image.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';

import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import '../controller/customer_order_controller.dart';

class CustomerRequestHistoryScreen extends StatefulWidget {
  const CustomerRequestHistoryScreen({super.key});

  @override
  State<CustomerRequestHistoryScreen> createState() => _CustomerRequestHistoryScreenState();
}

class _CustomerRequestHistoryScreenState extends State<CustomerRequestHistoryScreen> {
  final customerOrderController = Get.find<CustomerOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(      extendBody: true,

      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "History Status".tr,),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTabBar(
              tabs: customerOrderController.nameList,
              selectedIndex: customerOrderController.currentIndex.value,
              onTabSelected: (value) {
                customerOrderController.currentIndex.value = value;
                setState(() {});
              },
              selectedColor: AppColors.primary,
              unselectedColor: AppColors.primary,
            ),
           if(customerOrderController.currentIndex.value==0)
             Expanded(child: ListView(
               children: [
                 SizedBox(height: 20,),
                 GestureDetector(
                   onTap: (){
                     Get.toNamed(AppRoutes.requestHistoryServiceDetailsPage);
                   },
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Row(
                         children: [
                           CircleAvatar(
                             radius: 26,
                             backgroundColor: Color(0xffCDB3CD),
                             child: CustomImage(imageSrc: AppIcons.cleaner),
                           ),
                           SizedBox(width: 12.w),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               CustomText(
                                 text: "House Cleaning",
                                 fontSize: 16.w,
                                 fontWeight: FontWeight.w700,
                                 color: AppColors.black,
                                 bottom: 4.h,
                               ),
                               CustomText(
                                 text: "Reference Code: #D-571224",
                                 fontSize: 12.w,
                                 fontWeight: FontWeight.w500,
                                 color: Color(0xff6F767E),
                               ),
                             ],
                           ),
                         ],
                       ),
                       Icon(Icons.arrow_forward_sharp)
                     ],
                   ),
                 ),
                 Divider(thickness: .6, color: AppColors.white),
                 SizedBox(height: 10.h),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     CustomText(
                       text: "Status".tr,
                       fontSize: 14.w,
                       fontWeight: FontWeight.w500,
                       color: Color(0xff6F767E),
                     ),
                     Container(
                       padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                       decoration: BoxDecoration(
                         color: Color(0xffCDB3CD),
                         borderRadius: BorderRadius.circular(7),
                       ),
                       child: CustomText(
                         text: "Pending".tr,
                         fontSize: 14.w,
                         fontWeight: FontWeight.w600,
                         color: AppColors.primary,
                       ),
                     ),
                   ],
                 ),
                 SizedBox(height: 10.h),
                 Row(
                   children: [
                     CustomImage(imageSrc: AppIcons.calenderIcon),
                     SizedBox(width: 12.w),
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         CustomText(
                           text: "8:00-9:00 AM,  09 Dec",
                           fontSize: 16.w,
                           fontWeight: FontWeight.w700,
                           color: AppColors.black,
                           bottom: 4.h,
                         ),
                         CustomText(
                           text: "Schedule".tr,
                           fontSize: 12.w,
                           fontWeight: FontWeight.w500,
                           color: Color(0xff6F767E),
                         ),
                       ],
                     ),
                   ],
                 ),
                 SizedBox(height: 10.h),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Row(
                       children: [
                         CircleAvatar(
                           //  foregroundColor: AppColors.red,
                           radius: 26,
                           //  backgroundColor: Color(0xffCDB3CD),
                           child: CustomImage(imageSrc: AppIcons.girlVactor),
                         ),
                         SizedBox(width: 12.w),
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             CustomText(
                               text: "Sindenayu",
                               fontSize: 16.w,
                               fontWeight: FontWeight.w700,
                               color: AppColors.black,
                               bottom: 4.h,
                             ),
                             CustomText(
                               text: "Service provider".tr,
                               fontSize: 12.w,
                               fontWeight: FontWeight.w500,
                               color: Color(0xff6F767E),
                             ),
                           ],
                         ),
                       ],
                     ),
                     Row(
                       children: [
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                           decoration: BoxDecoration(
                             color: Color(0xffCDB3CD),
                             borderRadius: BorderRadius.circular(7),
                           ),
                           child: CustomText(
                             text: "Update".tr,
                             fontSize: 14.w,
                             fontWeight: FontWeight.w600,
                             color: AppColors.primary,
                           ),
                         ),
                         SizedBox(width: 6,),
                         Container(
                           padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                           decoration: BoxDecoration(
                             color: Colors.transparent,
                             border: Border.all(color: AppColors.primary,width: .6),
                             borderRadius: BorderRadius.circular(7),
                           ),
                           child: CustomText(
                             text: "Cancel".tr,
                             fontSize: 14.w,
                             fontWeight: FontWeight.w600,
                             color: AppColors.primary,
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
                 SizedBox(height: 10.h),
                 Divider(thickness: .6, color: AppColors.white),
               ],
             )),
            if(customerOrderController.currentIndex.value==1)
              Expanded(child: ListView(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: Color(0xffCDB3CD),
                            child: CustomImage(imageSrc: AppIcons.cleaner),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "House Cleaning",
                                fontSize: 16.w,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                                bottom: 4.h,
                              ),
                              CustomText(
                                text: "Reference Code: #D-571224",
                                fontSize: 12.w,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff6F767E),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_sharp)
                    ],
                  ),
                  Divider(thickness: .6, color: AppColors.white),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Status".tr,
                        fontSize: 14.w,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff6F767E),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.withValues(alpha: .3),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: CustomText(
                          text: "Confirmed".tr,
                          fontSize: 14.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      CustomImage(imageSrc: AppIcons.calenderIcon),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "8:00-9:00 AM,  09 Dec",
                            fontSize: 16.w,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                            bottom: 4.h,
                          ),
                          CustomText(
                            text: "Schedule".tr,
                            fontSize: 12.w,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6F767E),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomNetworkImage(imageUrl: AppConstants.girlsPhoto, height: 35, width: 35,boxShape: BoxShape.circle,),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: "Sindenayu",
                                fontSize: 16.w,
                                fontWeight: FontWeight.w700,
                                color: AppColors.black,
                                bottom: 4.h,
                              ),
                              CustomText(
                                text: "Service provider".tr,
                                fontSize: 12.w,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff6F767E),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xffCDB3CD),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: CustomImage(imageSrc: AppIcons.call)
                          ),
                          SizedBox(width: 6,),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                              decoration: BoxDecoration(
                                color: Color(0xffCDB3CD),
                                borderRadius: BorderRadius.circular(7),
                              ), child: CustomImage(imageSrc: AppIcons.message)
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                ],
              ))
          ],
        ),
      ),
      bottomNavigationBar: CustomerNavbar(currentIndex: 1),
    );
  }
}
