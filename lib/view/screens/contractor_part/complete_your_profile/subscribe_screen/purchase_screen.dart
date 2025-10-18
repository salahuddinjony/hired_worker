import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../core/app_routes/app_routes.dart';
import '../../../../../helper/shared_prefe/shared_prefe.dart';
import '../../../../../utils/app_strings/app_strings.dart';

class PurchaseScreen extends StatefulWidget {
  final String url;

  const PurchaseScreen({super.key, required this.url});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) async {
            if (url.contains('success')) {
              await SharePrefsHelper.setBool(AppStrings.isProfileComplete, true);
              Navigator.pop(context);
              _showSuccessDialog();
            }
            if (url.contains('cancel')) {
              Get.toNamed(AppRoutes.subscribeScreen);
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  void _showSuccessDialog() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => AlertDialog(
        title: const Center(child: Text("Payment Successful")),
        content: const Text(
          "Your payment was completed successfully!",
          textAlign: TextAlign.center,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Get.offAllNamed(AppRoutes.thanksScreen);
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: WebViewWidget(controller: _controller)));
  }
}