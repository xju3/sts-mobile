import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  final String url;
  final String title;

  const WebPage({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0XFFDFD3C3),
      ),
      body: WebViewWidget(
          controller: WebViewController()
            ..setJavaScriptMode(
              JavaScriptMode.unrestricted,
            )
            ..loadRequest(Uri.parse(widget.url))),
    );
  }
}
