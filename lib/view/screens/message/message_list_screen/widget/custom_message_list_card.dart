import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/helper/time_converter/time_converter.dart';
import '../../../../../utils/app_colors/app_colors.dart';
import '../../../../components/custom_netwrok_image/custom_network_image.dart';
import '../../../../components/custom_text/custom_text.dart';

class CustomMessageListCard extends StatelessWidget {
  const CustomMessageListCard({
    super.key,
    this.name,
    this.lastTime,
    this.lastMessage,
    this.image,
  });

  final String? name;
  final String? lastTime;
  final String? lastMessage;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        color: AppColors.white,
        elevation: .1,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNetworkImage(
                imageUrl:
                    ImageHandler.imagesHandle(image),
                height: 45,
                width: 45,
                boxShape: BoxShape.circle,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: name ?? "Justina",
                          fontSize: 16.w,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        CustomText(
                          text:
                              DateConverter.formatTimeAgo(lastTime!),
                          fontSize: 12.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black_07,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    CustomText(
                      text:
                          lastMessage ??
                          "No message yet, let's start a conversation",
                      fontSize: 14.w,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black_04,
                      maxLines: 5,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
