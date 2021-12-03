import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TaxFileCurrentIncomeScreen extends StatefulWidget {
  const TaxFileCurrentIncomeScreen({Key? key}) : super(key: key);

  @override
  _TaxFileCurrentIncomeScreenState createState() =>
      _TaxFileCurrentIncomeScreenState();
}

class _TaxFileCurrentIncomeScreenState
    extends State<TaxFileCurrentIncomeScreen> {
  RangeLabels labels = const RangeLabels('1', "100");
  RangeValues values = const RangeValues(1, 100);
  SfRangeValues _values = SfRangeValues(40.0, 80.0);
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
              SfRangeSlider(
                min: 0.0,
                max: 100.0,
                values: _values,
                interval: 20,
                showTicks: false,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 1,
                onChanged: (SfRangeValues values) {
                  setState(() {
                    _values = values;
                  });
                },
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 15),
                  child: Text(
                    StringConstants.estimatedPrice,
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
                  padding: const EdgeInsets.all(13.0),
                  child: Center(
                      child: Text(
                    "122euros",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                  )),
                ),
              ),
              // RangeSlider(
              //     divisions: 10,
              //     activeColor: ColorConstants.primary,
              //     inactiveColor: ColorConstants.primary,
              //     min: 1,
              //     max: 100,
              //     values: values,
              //     labels: labels,
              //     onChanged: (value) {
              //       print("START: ${value.start}, End: ${value.end}");
              //       setState(() {
              //         values = value;
              //         labels = RangeLabels(
              //             "${value.start.toInt().toString()}\$",
              //             "${value.start.toInt().toString()}\$");
              //       });
              //     }),

              const SizedBox(
                height: 24,
              ),
              TextComponent(
                StringConstants.promoCode,
                style: FontStyles.fontMedium(fontSize: 18),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  filled: false,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: ColorConstants.green,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: const BorderSide(
                      color: ColorConstants.green,
                    ),
                  ),
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
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
        child: ButtonComponent(
          buttonText: StringConstants.next.toUpperCase(),
          textStyle:
              FontStyles.fontRegular(color: ColorConstants.white, fontSize: 18),
          btnHeight: 60,
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.fileTaxInfoScreen);
          },
        ),
      ),
    );
  }
}
