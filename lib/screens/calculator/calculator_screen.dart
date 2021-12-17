import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/tax_calculate_screen.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<int> prices = [89, 99, 129, 169, 189, 229, 299, 319, 369, 429];
  late int calculatedPrice = 0;
  void calculateTax(int bje) {
    int priceIndex = 0;
    // gross annual income
    if (bje <= 8000) {
      priceIndex = 0;
    } else if (bje >= 8001 && bje <= 16000) {
      priceIndex = 1;
    } else if (bje >= 16001 && bje <= 25000) {
      priceIndex = 2;
    } else if (bje >= 25001 && bje <= 37000) {
      priceIndex = 3;
    } else if (bje >= 37001 && bje <= 50000) {
      priceIndex = 4;
    } else if (bje >= 50001 && bje <= 80000) {
      priceIndex = 5;
    } else if (bje >= 80001 && bje <= 110000) {
      priceIndex = 6;
    } else if (bje >= 110001 && bje <= 150000) {
      priceIndex = 7;
    } else if (bje >= 150001 && bje <= 200000) {
      priceIndex = 8;
    } else if (bje >= 200001 && bje <= 250000) {
      priceIndex = 9;
    } else {
      calculatedPrice = 0;
    }

    calculatedPrice = prices[priceIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        // LocaleKeys.appName.tr(),
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showBottomLine: false,
        showNotificationIcon: false,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetConstants.tax),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, top: 35, right: 15, bottom: 20),
                    child: Text(
                      StringConstants.whatIsYourAnnualIncomeGoal,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TaxCalculatorComponent(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: ElevatedButton(
                      style: ElevatedButtonTheme.of(context).style?.copyWith(
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 56),
                            ),
                          ),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteConstants.bottomNavBarScreen, (val) => false);
                      },
                      child: const Text(
                        StringConstants.orderNow,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
