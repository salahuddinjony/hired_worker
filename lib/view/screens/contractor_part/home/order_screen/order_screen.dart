import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/components/custom_nav_bar/navbar.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_tab_selected/custom_tab_bar.dart';
import 'controller/order_controller.dart';
import 'widget/custom_delivered_service_card.dart';
import 'widget/custom_service_request_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderController = Get.find<OrderController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Request"),
      body: Column(
        children: [
          //========================================= TAB BAR ================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomTabBar(
              tabs: orderController.nameList,
              selectedIndex: orderController.currentIndex.value,
              onTabSelected: (value) {
                orderController.currentIndex.value = value;
                setState(() {});
                orderController.update();
              },
              selectedColor: AppColors.primary,
              unselectedColor: AppColors.black_04,
            ),
          ),
          SizedBox(height: 20.h),
          if(orderController.currentIndex.value==0)
          Expanded(child: ListView(
            children: List.generate(4, (value){
              return CustomServiceRequestCard();
            })
          )),
          if(orderController.currentIndex.value==1)
            Expanded(child: ListView(
                children: List.generate(2, (value){
                  return CustomDeliveredServiceCard();
                })
            )),
        ],
      ),
      bottomNavigationBar: Navbar(currentIndex: 1),
    );
  }
}
