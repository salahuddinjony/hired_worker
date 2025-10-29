import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servana/helper/image_handelar/image_handelar.dart';
import 'package:servana/utils/app_const/app_const.dart';
import 'package:servana/view/screens/customer_part/home/controller/home_controller.dart';
import 'package:servana/view/screens/customer_part/home/slider/model/banners_model.dart';
import '../../../../../../core/app_routes/app_routes.dart';

class BannerCarousel extends StatelessWidget {
  final HomeController controller;
  final List<BannerItem> banners;

  const BannerCarousel({
    Key? key,
    required this.controller,
    required this.banners,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 135,
          width: MediaQuery.sizeOf(context).width,
          child:
              banners.isEmpty
                  ? ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          controller.bannerList.isNotEmpty
                              ? ImageHandler.imagesHandle(
                                AppConstants.electrician,
                              ) 
                              : '', 
                      imageBuilder:
                          (context, imageProvider) => Container(
                            height: 135,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      placeholder:
                          (context, url) => Container(
                            height: 135,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.grey.withValues(alpha: .2),
                          ),
                      errorWidget:
                          (context, url, error) => Container(
                            height: 135,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.grey.withValues(alpha: .2),
                            child: const Icon(Icons.error),
                          ),
                    ),
                  )
                  : Stack(
                    children: [
                      PageView.builder(
                        controller: controller.bannerPageController,
                        itemCount: banners.length,
                        onPageChanged:
                            (index) =>
                                controller.currentBannerIndex.value = index,
                        itemBuilder:
                            (context, index) =>
                                BannerSlide(item: banners[index]),
                      ),

                      // Indicator Dots
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            banners.length,
                            (i) => Obx(() {
                              final current =
                                  controller.currentBannerIndex.value;
                              return GestureDetector(
                                onTap: () {
                                  if (controller.bannerList.isNotEmpty) {
                                    controller.bannerPageController
                                        .animateToPage(
                                          i,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut,
                                        );
                                    controller.currentBannerIndex.value = i;
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: current == i ? 12 : 8,
                                  height: current == i ? 12 : 8,
                                  decoration: BoxDecoration(
                                    color:
                                        current == i
                                            ? Colors.white
                                            : Colors.white70,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.black12),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ],
    );
  }
}

/// Single banner slide widget which shows the image and overlays the category/subcategory name.
class BannerSlide extends StatelessWidget {
  final BannerItem item;

  const BannerSlide({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? catName = item.category?.name;
    final String? subName = item.subCategory?.name;
    final String labelName = catName ?? subName ?? '';

    final targetId = item.category?.id ?? item.subCategory?.id;
    final targetName = item.category?.name ?? item.subCategory?.name ?? '';

    return GestureDetector(
      onTap: () {
        if (targetId != null && targetId.isNotEmpty) {
          Get.toNamed(
            AppRoutes.customerParSubCategoryItem,
            arguments: {'name': targetName, 'id': targetId},
          );
        }
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Stack(
          children: [
            // Background Image
            CachedNetworkImage(
              imageUrl: ImageHandler.imagesHandle(item.image),
              imageBuilder:
                  (context, imageProvider) => Container(
                    height: 135,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              placeholder:
                  (context, url) => Container(
                    height: 135,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.grey.withValues(alpha: .2),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    height: 135,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.grey.withValues(alpha: .2),
                    child: const Icon(Icons.error),
                  ),
            ),

            // Overlay label (category/subcategory name)
            // if (labelName.isNotEmpty)
            //   Positioned(
            //     left: 8,
            //     bottom: 8,
            //     child: Container(
            //       padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            //       decoration: BoxDecoration(
            //         color: Colors.black.withValues(alpha: .45),
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             labelName,
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 12.sp,
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
