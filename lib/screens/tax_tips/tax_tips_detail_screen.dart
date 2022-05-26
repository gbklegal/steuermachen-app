import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/wrappers/faq_wp_wrapper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TaxTipsDetailScreen extends StatefulWidget {
  const TaxTipsDetailScreen({Key? key, required this.taxTipsContent})
      : super(key: key);
  final TaxTipsWrapper taxTipsContent;

  @override
  State<TaxTipsDetailScreen> createState() => _TaxTipsDetailScreenState();
}

class _TaxTipsDetailScreenState extends State<TaxTipsDetailScreen> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? _webViewController;
  int _stackToView = 1;
  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // log(widget.taxTipsContent.content!.rendered.toString());
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        // overrideBackPressed: () async {
        //   if (await _webViewController!.canGoBack()) {
        //     _webViewController?.goBack();
        //   } else {
        //     Navigator.pop(context);
        //   }
        // },
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: IndexedStack(
                index: _stackToView,
                children: [
                  WebView(
                    initialUrl: widget.taxTipsContent.link! +
                        "?frame_mode=app",
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                      _webViewController = webViewController;
                    },
                    onProgress: (progress) {
                      if (progress > 30) {
                        //remove the element with class name
                        _controller.future.then((webviewController) => webviewController
                            .runJavascript("javascript:(function() { " +
                                "var head = document.getElementsByTagName('header')[0];" +
                                "head.parentNode.removeChild(head);" +
                                "var headSection = document.getElementById('header-section');" +
                                "headSection.parentNode.removeChild(headSection);" +
                                "var footer = document.getElementsByTagName('footer')[0];" +
                                "footer.parentNode.removeChild(footer);" +
                                "var comments = document.getElementsByClassName('comment-respond')[0];" +
                                "comments.parentNode.removeChild(comments);" +
                                "var search = document.getElementById('search-2');" +
                                "search.parentNode.removeChild(search);" +
                                "var a=document.getElementsByTagName('a');" +
                                "a.href='http://www.stackoverflow.com';" +
                                "document.getElementsByTagName('body').style.marginTop='-40px'"
                                    "})()")
                            .then((value) => debugPrint('Page finished running Javascript'))
                            .catchError((onError) => debugPrint('$onError')));
                      }
                    },
                    onPageFinished: _handleLoad,
                  ),
                  const LoadingComponent(),
                ],
              )),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: Row(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(right: 15),
            //   child: FloatingActionButton(
            //     onPressed: () async {
            //       if (await _webViewController!.canGoBack()) {
            //         _webViewController?.goBack();
            //       }
            //     },
            //     child: SvgPicture.asset(
            //       AssetConstants.icBackNav,
            //       color: ColorConstants.white,
            //       height: 15,
            //     ),
            //   ),
            // ),
            Flexible(
              child: ElevatedButton(
                style: ElevatedButtonTheme.of(context).style?.copyWith(
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 56),
                      ),
                    ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context,
                      RouteConstants.bottomNavBarScreen, (val) => false);
                },
                child: Text(
                  LocaleKeys.orderNow.tr(),
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
