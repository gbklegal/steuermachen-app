import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class SelectSafeAndQuickTaxScreen extends StatelessWidget {
  const SelectSafeAndQuickTaxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 22);
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            sizedBox,
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 25),
              child: Image.asset(
                AssetConstants.tax,
                height: 120,
              ),
            ),
            TextComponent(
              LocaleKeys.howWouldYouLikeToProceed.tr(),
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            sizedBox,
            ButtonComponent(
                buttonText: LocaleKeys.taxReturnAtAGuaranteedfixedPrice.tr(),
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteConstants.declarationTaxScreen);
                }),
            sizedBox,
            TextComponent(
              LocaleKeys.or.tr().toLowerCase(),
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
            ),
            sizedBox,
            ButtonComponent(
              buttonText: LocaleKeys.safeTax.tr(),
              color: ColorConstants.toxicGreen,
              textStyle: Theme.of(context)
                  .textTheme
                  .button!
                  .copyWith(color: ColorConstants.black),
              onPressed: () {
                Navigator.pushNamed(context, RouteConstants.safeTaxScreen);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextComponent(
                LocaleKeys.inCaseOf20Percent,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorConstants.black.withOpacity(0.7),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
