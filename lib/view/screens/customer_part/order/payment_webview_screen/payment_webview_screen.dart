import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:servana/utils/app_colors/app_colors.dart';
import 'payment_webview_controller.dart';

class PaymentWebViewScreen extends StatelessWidget {
  const PaymentWebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentWebViewController>();

    return WillPopScope(
      onWillPop: () => controller.handleBackNavigation(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () {
              controller.showExitConfirmation();
            },
          ),
          title: Text(
            "Payment".tr,
            style: const TextStyle(
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => Stack(
            children: [
              if (controller.checkoutUrl != null &&
                  controller.checkoutUrl!.isNotEmpty)
                WebViewWidget(controller: controller.webViewController)
              else
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Invalid payment URL'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () => Get.back(),
                        child: Text('Go Back'.tr),
                      ),
                    ],
                  ),
                ),

              // Loading indicator
              if (controller.isLoading.value)
                Container(
                  color: Colors.white.withValues(alpha: .8),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
