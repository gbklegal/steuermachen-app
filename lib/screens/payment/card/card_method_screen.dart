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
import 'package:sumup/sumup.dart';

class CardPaymentMethodScreen extends StatelessWidget {
  const CardPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String affiliateKey = '544e0f03-28e7-46a1-881e-a1a7158abc33';
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
          onPressed: () async {
            await Sumup.init(affiliateKey);
            
            SumupPluginResponse a = await Sumup.login();
            print(a);
            var payment = SumupPayment(
              title: 'Test payment',
              total: 1.2,
              currency: 'EUR',
              saleItemsCount: 0,
              skipSuccessScreen: false,
              tip: .0,
            );

            var request = SumupPaymentRequest(payment, info: {
              'AccountId': 'taxi0334',
              'From': 'Paris',
              'To': 'Berlin',
            });
            var x = await Sumup.checkout(request);
            print(x);
            // Navigator.pushNamed(context, RouteConstants.confirmBillingScreen);
          },
        ),
      ),
    );
  }
}
