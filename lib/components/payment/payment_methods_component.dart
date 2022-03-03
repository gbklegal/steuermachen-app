import 'package:flutter/material.dart';
import 'package:steuermachen/components/shadow_card_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';

class PaymentMethodsComponent extends StatelessWidget {
  const PaymentMethodsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose pay method",
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
              leadingAsset: AssetConstants.icDocument,
              title: "Credit card",
              trailingAsset: AssetConstants.icForward,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: InkWell(
            onTap: () => Navigator.pushNamed(
                context, RouteConstants.selectBillingAddressScreen),
            child: ShadowCardComponent(
              height: 60,
              fontSize: 17,
              leadingAsset: AssetConstants.icPdf,
              title: "bill",
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
            Text(
              "Total",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
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
