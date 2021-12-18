import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/tax_calculator_provider.dart';
import 'package:steuermachen/providers/tax_file_provider.dart';

class TaxCalculatorComponent extends StatelessWidget {
  const TaxCalculatorComponent(
      {Key? key, this.routeName = RouteConstants.calculatorScreen})
      : super(key: key);
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Consumer<TaxCalculatorProvider>(builder: (context, consumer, child) {
      return Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontSize: 16.0,
                fontFamily: 'helvetica',
                fontStyle: FontStyle.normal,
                color: ColorConstants.black.withOpacity(0.4),
              ),
              label:  Text(LocaleKeys.annualIncom.tr()),
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: ColorConstants.black.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: ColorConstants.black.withOpacity(0.5),
                ),
              ),
            ),
            onChanged: (val) {
              if (val != "") {
                consumer.calculateTax(int.parse(val));
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
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Center(
                  child: Text(
                "${consumer.calculatedPrice} euros",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 25),
              )),
            ),
          ),
        ],
      );
    });
  }
}
