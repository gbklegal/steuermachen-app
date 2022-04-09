import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumpup_access_token_wrapper.dart';

class CardPaymentMethodScreen extends StatelessWidget {
  const CardPaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PaymentGateWayProvider provider =
        Provider.of<PaymentGateWayProvider>(context, listen: false);
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
            ApiResponse accessTokenRes = await provider.fetchAccessToken();
            if (accessTokenRes.status == Status.error) {
              ToastComponent.showToast(accessTokenRes.message!);
            } else {
              SumpupAccessTokenWrapper accessTokenWrapper =
                  accessTokenRes.data as SumpupAccessTokenWrapper;
              ApiResponse createCheckoutRes = await provider.createCheckout(
                  accessTokenWrapper.accessToken, 10);
              print(createCheckoutRes);
            }
            // Navigator.pushNamed(context, RouteConstants.confirmBillingScreen);
          },
        ),
      ),
    );
  }
}
