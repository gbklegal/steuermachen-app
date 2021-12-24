import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_top_component.dart';
import 'package:steuermachen/wrappers/tax_tips_wrapper.dart';

class TaxTipsDetailScreen extends StatelessWidget {
  const TaxTipsDetailScreen({Key? key, required this.taxTipsContent})
      : super(key: key);
  final TaxTipsContent taxTipsContent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaxTipTopComponent(
                  title: taxTipsContent.title,
                  subtitle: taxTipsContent.subtitle,
                  publishedDate: taxTipsContent.publishedDate.toString(),
                  articleBy: taxTipsContent.articleBy,
                  image: taxTipsContent.image,
                  readTime: taxTipsContent.readTime,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text(
                    taxTipsContent.content!,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
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
