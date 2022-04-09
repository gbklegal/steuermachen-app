import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/tax_calculate_screen.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/tax_calculator_provider.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaxCalculatorProvider>(context, listen: false).calculatedPrice =
        0;
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
        showPersonIcon: false,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus &&
                    currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus!.unfocus();
                }
              },
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
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 28),
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
                          if (FirebaseAuth.instance.currentUser != null) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteConstants.bottomNavBarScreen,
                                (val) => false);
                          } else {
                            Navigator.popAndPushNamed(
                                context, RouteConstants.signInScreen);
                          }
                        },
                        child: Text(
                          LocaleKeys.orderNow.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
