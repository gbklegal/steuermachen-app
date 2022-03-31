import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_top_component.dart';
import 'package:steuermachen/wrappers/faq_wp_wrapper.dart';

class TaxTipsDetailScreen extends StatelessWidget {
  const TaxTipsDetailScreen({Key? key, required this.taxTipsContent})
      : super(key: key);
  final TaxTipsWrapper taxTipsContent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaxTipTopComponent(
                  title: taxTipsContent.title!.rendered,
                  subtitle:
                      taxTipsContent.embedded!.wpFeaturedmedia![0].altText,
                  publishedDate: taxTipsContent
                      .embedded!.wpFeaturedmedia![0].date
                      .toString(),
                  articleBy: taxTipsContent.embedded!.author![0].name,
                  image: taxTipsContent.embedded!.wpFeaturedmedia![0].sourceUrl,
                  readTime: "",
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    child: Html(
                      data: taxTipsContent.content!.rendered.toString(),
                      // onMathError: (String parsedTex, String error,
                      //     String errorWithType) {
                      //   //your logic here. A Widget must be returned from this function:
                      //   return Text(error);
                      //   //you can also try and fix the parsing yourself:
                      //   // return Math.tex(correctedParsedTex);
                      // },
                    )

                    // Text(
                    //   taxTipsContent.content!.rendered.toString(),
                    //   style: Theme.of(context).textTheme.bodyText2,
                    // ),
                    ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ElevatedButton(
          style: ElevatedButtonTheme.of(context).style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 56),
                ),
              ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteConstants.bottomNavBarScreen, (val) => false);
          },
          child: Text(
            LocaleKeys.applyNow.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
