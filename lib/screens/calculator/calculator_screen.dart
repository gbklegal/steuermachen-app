import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
          ),
          Image.asset(AssetConstants.tax),
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 35, right: 15, bottom: 20),
            child: Text(
              StringConstants.whatIsYourAnnualIncomeGoal,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text(StringConstants.email),
            ),
          ),
        ],
      ),
    );
  }
}
