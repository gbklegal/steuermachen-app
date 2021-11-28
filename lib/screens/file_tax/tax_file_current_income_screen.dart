import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class TaxFileCurrentIncomeScreen extends StatefulWidget {
  const TaxFileCurrentIncomeScreen({Key? key}) : super(key: key);

  @override
  _TaxFileCurrentIncomeScreenState createState() =>
      _TaxFileCurrentIncomeScreenState();
}

class _TaxFileCurrentIncomeScreenState
    extends State<TaxFileCurrentIncomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.curStatus,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 38),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextProgressBarComponent(
                title: "${StringConstants.step} 3/5",
                progress: 0.6,
              ),
              const SizedBox(
                height: 62,
              ),
              TextComponent(
                StringConstants.grossAnnualIncome,
                style: FontStyles.fontBold(fontSize: 24),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: StringConstants.annualIncom,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextComponent(
                StringConstants.estimatedPrice,
                style: FontStyles.fontMedium(fontSize: 18),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    // label: Text(StringConstants.email),
                    hintText: StringConstants.email),
              ),
              const SizedBox(
                height: 48,
              ),
              TextComponent(
                StringConstants.promoCode,
                style: FontStyles.fontMedium(fontSize: 18),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "",
                ),
              ),
              const SizedBox(height: 12),
              TextComponent(
                StringConstants.applyNow,
                style: FontStyles.fontMedium(
                    fontSize: 18,
                    underLine: true,
                    color: ColorConstants.toxicGreen),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonComponent(
          buttonText: StringConstants.next,
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.fileTaxInfoScreen);
          },
        ),
      ),
    );
  }
}
