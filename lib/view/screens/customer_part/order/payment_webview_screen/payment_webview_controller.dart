import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewController extends GetxController {
  late final WebViewController webViewController;
  final RxBool isLoading = true.obs;
  String? checkoutUrl;

  @override
  void onInit() {
    super.onInit();

    // Get the checkout URL from arguments
    checkoutUrl = Get.arguments as String?;

    // Initialize WebView controller
    initializeWebView();
  }

  void initializeWebView() {
    webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (String url) {
                isLoading.value = true;
                debugPrint('Page started loading: $url');
              },
              onPageFinished: (String url) {
                isLoading.value = false;
                debugPrint('Page finished loading: $url');

                // Check if payment is completed (customize based on your payment provider)
                if (url.contains('success') ||
                    url.contains('payment-complete')) {
                  // Payment successful
                  Get.back(result: 'success');
                } else if (url.contains('cancel') || url.contains('failed')) {
                  // Payment cancelled or failed
                  Get.back(result: 'cancelled');
                }
              },
              onWebResourceError: (WebResourceError error) {
                debugPrint('WebView error: ${error.description}');
              },
            ),
          );

    // Load the checkout URL
    if (checkoutUrl != null && checkoutUrl!.isNotEmpty) {
      webViewController.loadRequest(Uri.parse(checkoutUrl!));
    }
  }

  Future<bool> handleBackNavigation() async {
    // Check if webview can go back
    if (await webViewController.canGoBack()) {
      webViewController.goBack();
      return false;
    }
    return true;
  }

  void showExitConfirmation() {
    Get.dialog(
      AlertDialog(
        title: Text('Cancel Payment?'.tr),
        content: Text('Are you sure you want to cancel the payment?'.tr),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('No'.tr, style: const TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(result: 'cancelled'); // Close webview
            },
            child: Text('Yes'.tr, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}
