import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/tax_option_grid_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/screens/file_tax/marital_status_model.dart';

class TaxFileYearScreen extends StatefulWidget {
  const TaxFileYearScreen({Key? key}) : super(key: key);

  @override
  State<TaxFileYearScreen> createState() => _TaxFileYearScreenState();
}

class _TaxFileYearScreenState extends State<TaxFileYearScreen> {
  late List<MaritalStatusModel> maritalStatusModelList = [];

  @override
  void initState() {
    maritalStatusModelList.add(MaritalStatusModel(
      isSelected: true,
      title: "2017",
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      isSelected: false,
      title: "2018",
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      isSelected: false,
      title: "2019",
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      isSelected: false,
      title: "2020",
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        LocaleKeys.selectYear.tr(),
        showPersonIcon: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
            child: TextProgressBarComponent(
              title: "${LocaleKeys.step.tr()} 2/5",
              progress: 0.4,
            ),
          ),
          TaxOptionGridComponent(
            maritalStatusModelList: maritalStatusModelList,
            showYears: true,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: LocaleKeys.next.tr().toUpperCase(),
          textStyle:
              FontStyles.fontRegular(color: ColorConstants.white, fontSize: 18),
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.currentIncomeScreen);
          },
        ),
      ),
    );
  }
}
