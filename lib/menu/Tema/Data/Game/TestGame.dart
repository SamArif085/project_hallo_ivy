import 'package:flutter/material.dart';
import 'package:project_hallo_ivy/login.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameTest extends StatelessWidget {
  final UserData userData;
  final LinkGame dataGame;

  const GameTest({super.key, required this.userData, required this.dataGame});

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.greenAccent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    controller.loadRequest(Uri.parse(dataGame.linkGame));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebViewWidget(controller: controller),
    );
  }
}
