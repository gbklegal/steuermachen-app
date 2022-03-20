import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/shadow_card_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class PaymentMethodsComponent extends StatelessWidget {
  const PaymentMethodsComponent({Key? key, required this.decisionTap})
      : super(key: key);
  final void Function() decisionTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          LocaleKeys.choosePaymentMethod,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () => Navigator.pushNamed(
                context, RouteConstants.cardPaymentMethodScreen),
            child: ShadowCardComponent(
              height: 60,
              fontSize: 17,
              leadingAsset: AssetConstants.icCreditCard,
              title: LocaleKeys.creditCard.tr(),
              trailingAsset: AssetConstants.icForward,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () async {
              var status = await Navigator.pushNamed(
                  context, RouteConstants.selectBillingAddressScreen);
              if (status != null) {
                decisionTap();
              }
            },
            child: ShadowCardComponent(
              height: 60,
              fontSize: 17,
              leadingAsset: AssetConstants.icBill,
              title: LocaleKeys.bill.tr(),
              trailingAsset: AssetConstants.icForward,
            ),
          ),
        ),
        const SizedBox(
          height: 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextComponent(
              LocaleKeys.total.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            TextComponent(
              "129 euros",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        )
      ],
    );
  }
}
