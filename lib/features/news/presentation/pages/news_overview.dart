import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class MessageOverview extends StatefulWidget {
  String url;
  MessageOverview({Key? key, required this.url}) : super(key: key);

  @override
  State<MessageOverview> createState() => _MessageOverviewState();
}

class _MessageOverviewState extends State<MessageOverview> {
  WebViewController? webViewController;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomNavBar(title: "News"),
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
