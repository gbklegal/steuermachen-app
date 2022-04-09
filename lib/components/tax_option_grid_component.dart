import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/constants/styles/widget_styles.dart';
import 'package:steuermachen/data/view_models/tax_file_provider.dart';
import 'package:steuermachen/screens/file_tax/marital_status_model.dart';

class TaxOptionGridComponent extends StatefulWidget {
  final List<MaritalStatusModel> maritalStatusModelList;
  //UI little bit change on below flag
  final bool showYears;
  const TaxOptionGridComponent(
      {Key? key, required this.maritalStatusModelList, this.showYears = false})
      : super(key: key);

  @override
  _TaxOptionGridComponentState createState() => _TaxOptionGridComponentState();
}

class _TaxOptionGridComponentState extends State<TaxOptionGridComponent> {
  late List<MaritalStatusModel> maritalStatusModelList = [];
  late Size _size;

  @override
  void initState() {
    maritalStatusModelList = widget.maritalStatusModelList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: ((_size.width / 2.5) / (_size.height / 5)),
                  crossAxisSpacing: 0,
                  mainAxisExtent: 180,
                  mainAxisSpacing: 0),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return _itemMaritalStatus(index);
              }),
        ),
      ),
    );
  }

  Widget _itemMaritalStatus(int index) {
    return Column(
      children: <Widget>[
        Consumer<TaxFileProvider>(builder: (context, consumer, child) {
          return InkWell(
            child: Container(
              width: 109.296,
              height: 100.337,
              decoration: maritalStatusModelList[index].isSelected!
                  ? _selectedBoxDeco()
                  : _unSelectedBoxDeco(),
              child: _buildContainerChild(index),
            ),
            onTap: () {
              if (widget.showYears) {
                consumer.setYear(maritalStatusModelList[index].title!);
              } else {
                consumer.setMartialStatus(maritalStatusModelList[index].title!);
              }
              _setFalseAllList();
              maritalStatusModelList[index].isSelected = true;
              setState(() {});
            },
          );
        }),
        !widget.showYears
            ? Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextComponent(
                    maritalStatusModelList[index].title!,
                    style: FontStyles.fontRegular(fontSize: 17),
                  )
                ],
              )
            : WidgetStyles.sizeBoxZero(),
      ],
    );
  }

  Widget _buildContainerChild(int index) {
    MaritalStatusModel maritalStatusModel = maritalStatusModelList[index];
    return widget.showYears
        ? Center(
            child: TextComponent(
              maritalStatusModelList[index].title!,
              style: FontStyles.fontMedium(fontSize: 24),
            ),
          )
        : Image.asset(
            maritalStatusModel.image!,
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
        boxShadow: const [
          BoxShadow(
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
