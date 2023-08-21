import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class GamePage extends StatelessWidget {
  final Map<String, dynamic> materi; 
  const GamePage({super.key,required this.materi });

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

    controller.loadRequest(Uri.parse(materi['link_game']));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WebViewWidget(controller: controller),
    );
  }
}
