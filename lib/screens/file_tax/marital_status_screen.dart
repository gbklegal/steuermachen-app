import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_file_tax_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/style/font_styles_constants.dart';
import 'package:steuermachen/screens/file_tax/marital_status_model.dart';

class MaritalStatusScreen extends StatefulWidget {
  const MaritalStatusScreen({Key? key}) : super(key: key);

  @override
  _MaritalStatusScreenState createState() => _MaritalStatusScreenState();
}

class _MaritalStatusScreenState extends State<MaritalStatusScreen> {
  late List<MaritalStatusModel> maritalStatusModelList = [];

  @override
  void initState() {
    super.initState();
    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icGoogle,
      isSelected: true,
      title: StringConstants.student,
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icGoogle,
      isSelected: false,
      title: StringConstants.married,
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icGoogle,
      isSelected: false,
      title: StringConstants.divorced,
    ));

    maritalStatusModelList.add(MaritalStatusModel(
      image: AssetConstants.icGoogle,
      isSelected: false,
      title: StringConstants.widowed,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(AppConstants.toolbarSize),
        child: AppBarComponent(
          StringConstants.areSingle,
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: TextProgressBarComponent(
              title: "${StringConstants.step} 1/5",
              progress: 0.2,
            ),
          ),
          Expanded(
            child: Center(
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return _itemMaritalStatus(index);
                  }),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(8.0),
        child: ButtonComponent(
          buttonText: StringConstants.next,
        ),
      ),
    );
  }

  Widget _itemMaritalStatus(int index) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Container(
            width: 109.296,
            height: 100.337,
            decoration: maritalStatusModelList[index].isSelected!
                ? _selectedBoxDeco()
                : _unSelectedBoxDeco(),
            child: SvgPicture.asset(
              maritalStatusModelList[index].image!,
              // color: ColorConstants.mediumGrey,
            ),
          ),
          onTap: () {
            _setFalseAllList();
            maritalStatusModelList[index].isSelected = true;
            setState(() {});
          },
        ),
        const SizedBox(
          height: 8,
        ),
        TextComponent(
          maritalStatusModelList[index].title!,
          style: FontStyles.fontRegular(fontSize: 20),
        )
      ],
    );
  }

  void _setFalseAllList() {
    for (var f in maritalStatusModelList) {
      f.isSelected = false;
    }
  }

  BoxDecoration _selectedBoxDeco() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorConstants.green,
        boxShadow: [
           const BoxShadow(
              color: Color(0x3f000000),
              offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 0)
        ]);
  }

  BoxDecoration _unSelectedBoxDeco() {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorConstants.white,
        border: Border.all(width: 2, color: Colors.black));
  }
}
