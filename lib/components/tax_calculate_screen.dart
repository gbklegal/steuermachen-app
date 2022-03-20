import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/tax_calculator_provider.dart';
import 'package:steuermachen/providers/tax_file_provider.dart';

class TaxCalculatorComponent extends StatelessWidget {
  const TaxCalculatorComponent({
    Key? key,
    this.routeName = RouteConstants.calculatorScreen,
  }) : super(key: key);
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaxCalculatorProvider>(builder: (context, consumer, child) {
      return Column(
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            icon: SvgPicture.asset(
              AssetConstants.icDown,
              color: ColorConstants.black,
            ),
            
            value: consumer.selectedPrice,
            items: consumer.taxPrices
                .map((e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (val) {
              consumer.calculateTax(val!);
              if (val != "") {
                if (routeName == RouteConstants.currentIncomeScreen) {
                  Provider.of<TaxFileProvider>(context, listen: false)
                      .setIncome(val, consumer.calculatedPrice.toString(),
                          "promoCode");
                }
              }
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 15),
              child: Text(
                LocaleKeys.estimatedPrice.tr(),
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
          ),
          Container(
            height: 48,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    consumer.calculatedPrice == 0
                        ? 'x'
                        : consumer.calculatedPrice.toString() + ',00',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 24),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3, left: 5),
                    child: Text(
                      "Euros",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
