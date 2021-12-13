import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/tax_option_grid_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/screens/file_tax/marital_status_model.dart';

class TaxFileMaritalStatusScreen extends StatefulWidget {
  const TaxFileMaritalStatusScreen({Key? key}) : super(key: key);

  @override
  _TaxFileMaritalStatusScreenState createState() =>
      _TaxFileMaritalStatusScreenState();
}

class _TaxFileMaritalStatusScreenState
    extends State<TaxFileMaritalStatusScreen> {
  late List<MaritalStatusModel> maritalStatusModelList = [];

  @override
  void initState() {
    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icStickman,
      isSelected: true,
      title: StringConstants.student,
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icWeddingRings,
      isSelected: false,
      title: StringConstants.married,
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icBroken,
      isSelected: false,
      title: StringConstants.divorced,
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icWidowed,
      isSelected: false,
      title: StringConstants.widowed,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.areSingle,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 25),
            child: TextProgressBarComponent(
              title: "${StringConstants.step} 1/5",
              progress: 0.2,
            ),
          ),
          TaxOptionGridComponent(
            maritalStatusModelList: maritalStatusModelList,
          ),
          /*  Expanded(
            child: Center(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio:
                          ((_size.width / 2.5) / (_size.height / 5)),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 12),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return _itemMaritalStatus(index);
                  }),
            ),
          ), */
        ],
      ),
      bottomNavigationBar: Padding(
         padding: AppConstants.bottomBtnPadding,
        child: ButtonComponent(
          btnHeight: 56,
          buttonText: StringConstants.next.toUpperCase(),
          textStyle:
              FontStyles.fontRegular(color: ColorConstants.white, fontSize: 18),
          onPressed: () {
            Navigator.pushNamed(context, RouteConstants.selectYearScreen);
          },
        ),
      ),
    );
  }
}
