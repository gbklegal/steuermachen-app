import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/textformfield_icon_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/providers/tax/finance_court/finance_court_provider.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';

class FinanceLawComponent extends StatelessWidget {
  const FinanceLawComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceCourtProvider>(builder: (context, consumer, child) {
      if (context.locale == const Locale('en')) {
        return _mainBody(consumer.financeLawWrapper.en);
      } else {
        return _mainBody(consumer.financeLawWrapper.du);
      }
    });
  }

  Future<void> _selectDate(BuildContext context, DateTime selectedDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = picked;
    }
  }

  Consumer _mainBody(FinanceViewData _data) {
    return Consumer<FinanceCourtProvider>(builder: (context, consumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextComponent(
            _data.title,
            style: FontStyles.fontBold(fontSize: 18),
          ),
          const SizedBox(
            height: 5,
          ),
          TextComponent(
            _data.subtitle,
            style: FontStyles.fontMedium(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 12,
          ),
          for (var i = 0; i < _data.options.length; i++)
            CheckboxListTile(
                title: TextComponent(
                  _data.options[i].title,
                  style: FontStyles.fontRegular(),
                ),
                value: _data.options[i].isSelect,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onChanged: (newValue) {
                  consumer.changeSubjectLawCheckBoxState(_data, i);
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero),
          const SizedBox(
            height: 12,
          ),
          TextComponent(
            _data.thirdTitle,
            style: FontStyles.fontMedium(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () async {
              await _selectDate(context, consumer.selectedDate);
            },
            child: TextFormField(
              decoration: InputDecoration(
                  label:
                      Text(consumer.formatDate.format(consumer.selectedDate)),
                  contentPadding: const EdgeInsets.only(left: 0),
                  suffixIcon: TextFormFieldIcons(
                    assetName: AssetConstants.icCalendar,
                    padding: 12,
                    icColor: ColorConstants.black,
                  ),
                  enabled: false),
            ),
          )
        ],
      );
    });
  }
}
