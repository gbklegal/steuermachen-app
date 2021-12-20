import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/tax_calculate_screen.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
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
                      LocaleKeys.whatIsYourAnnualIncomeGoal.tr(),
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
                      child:  Text(
                        LocaleKeys.orderNow.tr(),
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
