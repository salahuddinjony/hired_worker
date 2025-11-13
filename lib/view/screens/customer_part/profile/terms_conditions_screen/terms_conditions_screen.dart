import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:servana/global/general_controller/general_controller.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'package:servana/view/components/custom_loader/custom_loader.dart';
import 'package:servana/view/components/custom_royel_appbar/custom_royel_appbar.dart';
import 'package:flutter_html/flutter_html.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GeneralController generalController = Get.find<GeneralController>();

    String cleanHtml(String html) {
      // Remove empty tags and excessive <br> tags
      String cleaned = html.replaceAll(
        RegExp(r'<(p|div|br)[^>]*>(\s|&nbsp;)*<\/\1>'),
        '',
      );
      cleaned = cleaned.replaceAll(RegExp(r'(<br\s*\/?>\s*){2,}'), '<br>');
      return cleaned;
    }

    return Scaffold(
      appBar: CustomRoyelAppbar(
        leftIcon: true,
        titleName: "Terms & Conditions".tr,
      ),
      body: Obx(() {
        if (generalController.terms.value.isEmpty) {
          return const Center(child: CustomLoader());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Html(
                data: cleanHtml(generalController.terms.value),
                style: {
                  "body": Style(
                    fontSize: FontSize(18.w),
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.justify,
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "p": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
                  "div": Style(
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "br": Style(margin: Margins.zero, padding: HtmlPaddings.zero),
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
