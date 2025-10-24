import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WithdrawScreen extends StatefulWidget {
  final String url;

  const WithdrawScreen({super.key, required this.url});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) async {
            debugPrint('page finished: $url');

            try {
              final htmlContent = await _controller.runJavaScriptReturningResult(
                "document.body.innerText",
              );

              final text = htmlContent.toString().toLowerCase();
              debugPrint('xxx Page text: $text');

              if (url.contains('servana.com.au/complete') ||
                  text.contains('thanks for adding information to set up you account')) {
                Get.back(result: true);
              } else if (url.contains('fail') ||
                  url.contains('incomplete') ||
                  url.contains('cancel') ||
                  url.contains('unfinished')) {
                Get.back(result: false);
              }
            } catch (e) {
              debugPrint('JS read error: $e');
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller)),
    );
  }
}
