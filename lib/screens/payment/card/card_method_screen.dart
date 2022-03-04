import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CardPaymentMethodScreen extends StatelessWidget {
  const CardPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontStyle = FontStyles.fontRegular(fontSize: 14);
    const sizedBoxH12 = SizedBox(
      height: 12,
    );
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Column(
          children: [
            Image.asset(AssetConstants.paymentMethods),
            sizedBoxH12,
            TextFormField(
              // controller: consumer.firstNameController,
              decoration: InputDecoration(
                labelText: LocaleKeys.nameOnTheCard.tr() + "*",
                hintStyle: fontStyle,
              ),
              // validator: validateFieldEmpty,
            ),
            sizedBoxH12,
            TextFormField(
              // controller: consumer.firstNameController,
              decoration: InputDecoration(
                labelText: LocaleKeys.cardNumber.tr() + "*",
                hintStyle: fontStyle,
              ),
              // validator: validateFieldEmpty,
            ),
            sizedBoxH12,
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    // controller: consumer.firstNameController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.expiryDate.tr() + "*",
                      hintStyle: fontStyle,
                    ),
                    // validator: validateFieldEmpty,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Flexible(
                  child: TextFormField(
                    // controller: consumer.firstNameController,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.cv.tr() + "*",
                      hintStyle: fontStyle,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Image.asset(
                          AssetConstants.icCv,
                          height: 15,
                        ),
                      ),
                    ),

                    // validator: validateFieldEmpty,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          buttonText: LocaleKeys.continueWord.tr(),
          onPressed: () =>
              Navigator.pushNamed(context, RouteConstants.confirmBillingScreen),
        ),
      ),
    );
  }
}
