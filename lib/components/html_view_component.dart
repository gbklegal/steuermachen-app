import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocalHtmlWebViewComponent extends StatefulWidget {
  final String html;

  const LocalHtmlWebViewComponent({Key? key, required this.html})
      : super(key: key);
  @override
  _LocalHtmlWebViewComponentState createState() =>
      _LocalHtmlWebViewComponentState();
}

class _LocalHtmlWebViewComponentState extends State<LocalHtmlWebViewComponent> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? _webViewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: WebView(
        initialUrl: '',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          _webViewController = webViewController;
          loadAsset();
        },
        // onPageFinished: _handleLoad,
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: FloatingActionButton(
            onPressed: () async {
              if (await _webViewController!.canGoBack()) {
                _webViewController?.goBack();
              }
            },
            child: SvgPicture.asset(
              AssetConstants.icBackNav,
              color: ColorConstants.white,
              height: 15,
            ),
          ),
        ),
      ),
    );
  }

  loadAsset() async {
    _webViewController?.loadUrl(Uri.dataFromString(
      """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <body style='"margin: 0; padding: 0;'>
        <div> ${widget.html}  </div>
      </body>
    </html>""",
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }
}
