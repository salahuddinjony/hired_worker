import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'custom_review_list.dart';

class ReviewsList extends StatelessWidget {
  final List reviewItems;
  final bool isLoading;

  const ReviewsList({Key? key, required this.reviewItems, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: SizedBox(height: 48, width: 48, child: CircularProgressIndicator()));
    if (reviewItems.isEmpty) return Center(child: Text("No reviews available".tr, style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: AppColors.black_08)));

    final outer = reviewItems.first;
    final innerReviews = outer.reviews;
    if (innerReviews.isEmpty) return Center(child: Text("No reviews available".tr, style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: AppColors.black_08)));

    return Column(children: List.generate(innerReviews.length, (index) => CustomReviewList(reviewData: innerReviews[index])));
  }
}
