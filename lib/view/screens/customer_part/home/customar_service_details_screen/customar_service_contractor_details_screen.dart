import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:servana/view/components/custom_text/custom_text.dart';
import '../../../../components/custom_button/custom_button.dart';

class CustomarServiceContractorDetailsScreen extends StatelessWidget {
  const CustomarServiceContractorDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Details"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Service Contractor",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Name : Thomas",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "50\$/hr",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            CustomText(
              top: 4,
              text: "Category : Electrician ( Fan installation )",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              bottom: 20,
            ),
            CustomText(
              text: "Requirement Question",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            CustomText(
              text: "Question : Do you have existing wiring ?",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            CustomText(
              top: 4,
              text: "Answer : Yes",
              fontSize: 16.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              bottom: 20,
            ),
            CustomText(
              text: "Materials",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Ceiling Fan - 1  ",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "100\$/hr",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Wire - 10m",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "50\$/hr",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(height: 6,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Switchboard - 1",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                CustomText(
                  text: "50\$/hr",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            CustomText(
              top: 20,
              text: "Booking Type",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
            Row(
              children: [
                Radio(value: true, groupValue: (true), onChanged: (value){}),
                CustomText(
                  text: "One Time",
                  fontSize: 16.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            CustomText(
              top: 20,
              text: "Durations",
              fontSize: 18.w,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            Divider(thickness: .3, color: AppColors.black_02),
             SizedBox(height: 8,),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 CustomText(
                   text: "09 : 00 Am - 12 : 00 Pm",
                   fontSize: 16.w,
                   fontWeight: FontWeight.w500,
                   color: AppColors.black,
                 ),
                 CustomText(
                   text: "(4 Hours)",
                   fontSize: 16.w,
                   fontWeight: FontWeight.w500,
                   color: AppColors.black,
                 ),
               ],
             )

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 40, right: 20, left: 20,),
        child: CustomButton(onTap: (){
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (_) => CheckoutPopup(),
          );
        },title: "Continue",),
      ),
    );
  }
}


class CheckoutPopup extends StatelessWidget {
  const CheckoutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40), // padding
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Total Amount Info',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Divider(height: 30, thickness: 1),
          _buildRow(
            label: 'Electrician',
            subLabel: 'AC Repair',
            amount: '200.00\$',
            isBold: false,
          ),
          Divider(height: 30, thickness: 1),
          _buildRow(
            label: 'Total Materials (03)',
            amount: '250.00\$',
            isBold: true,
          ),
          Divider(height: 30, thickness: 1),
          _buildRow(
            label: 'Total Amount',
            amount: '450.00\$',
            isBold: true,
            withColon: true,
          ),
          SizedBox(height: 30),
          CustomButton(onTap: (){
            Get.back();
          }, title: "Checkout",),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String label,
    String? subLabel,
    required String amount,
    bool isBold = false,
    bool withColon = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                withColon ? '$label :' : label,
                style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: isBold ? 16 : 14,
                ),
              ),
              if (subLabel != null)
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    subLabel,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ),
            ],
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        )
      ],
    );
  }
}