import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/view/screens/contractor_part/home/controller/recent_all_service_controller.dart';
import 'package:servana/view/screens/contractor_part/home/home_screen/widget/custom_service_card.dart';

import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../../utils/helper_methods/helper_methods.dart';
import '../../../../components/custom_royel_appbar/custom_royel_appbar.dart';
import '../model/booking_model.dart';

class RecentAllServiceScreen extends StatelessWidget {
  const RecentAllServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RecentAllServiceController controller =
        Get.find<RecentAllServiceController>();

    return Scaffold(
      appBar: CustomRoyelAppbar(leftIcon: true, titleName: "Recent Service".tr),
      body: Obx(() {
        if (controller.status.value.isLoading) {
          return Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        } else if (controller.status.value.isEmpty) {
          return Center(child: Text('No data found'));
        } else if (controller.status.value.isError) {
          return Center(child: Text(controller.status.value.errorMessage!));
        } else {
          return Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.recentServiceList.length + 1,
              itemBuilder: (context, index) {
                if (index < controller.recentServiceList.length) {
                  BookingModelData data = controller.recentServiceList[index];

                  return CustomServiceCard(
                    title: getSubCategoryName(data),
                    updateDate: data.updatedAt!,
                    hourlyRate: data.rateHourly.toString(),
                    rating:
                        data.contractorId?.contractor?.ratings.toString() ??
                        " - ",
                    status: data.status ?? " - ",
                    image: data.contractorId?.img,
                  );
                } else if (controller.status.value.isLoadingMore) {
                  return Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          );
        }
      }),
    );
  }
}
