import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/tax_option_grid_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
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
      appBar: const AppBarComponent(
        StringConstants.selectYear,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 25),
            child: TextProgressBarComponent(
              title: "${StringConstants.step} 2/5",
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
        padding: const EdgeInsets.all(8.0),
        child: ButtonComponent(
          buttonText: StringConstants.next,
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.currentIncomeScreen);
          },
        ),
      ),
    );
  }
}
