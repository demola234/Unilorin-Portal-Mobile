import 'package:flutter/material.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../core/utils/customs/custom_nav_bar.dart';

class NewsOverview extends StatefulWidget {
  String url;

  NewsOverview({Key? key, required this.url}) : super(key: key);

  @override
  State<NewsOverview> createState() => _NewsOverviewState();
}

class _NewsOverviewState extends State<NewsOverview> {
  bool isLoading = true;
  WebViewController? webViewController;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: CustomNavBar(title: "News"),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                webViewController = webViewController;
              },
              onPageFinished: (String url) {
                setState(() {
                  isLoading = false;
                });

                // Removes header and footer from page
                webViewController!
                    .runJavascriptReturningResult("javascript:(function() { " +
                        "var footer = document.getElementsByTagName('footer-widget')[0];" +
                        "footer.parentNode.removeChild(head);" +
                        "var footer = document.getElementsByTagName('footer')[0];" +
                        "footer.parentNode.removeChild(footer);" +
                        "})()")
                    .then((value) =>
                        debugPrint('Page finished loading Javascript'))
                    .catchError((onError) => debugPrint('$onError'));
              },
            ),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        color: ProbitasColor.ProbitasSecondary),
                  )
                : Stack(),
          ],
        ));
  }
}
