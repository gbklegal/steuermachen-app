import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/textformfield_icon_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';

class FinanceLawComponent extends StatelessWidget {
  final FinanceLawViewWrapper financeViewData;
  const FinanceLawComponent({
    Key? key,
    required this.financeViewData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (context.locale == const Locale('en')) {
      return _mainBody(financeViewData.en);
    } else {
      return _mainBody(financeViewData.du);
    }
  }

  Column _mainBody(FinanceViewData _data) {
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
          style:
              FontStyles.fontMedium(fontSize: 18, fontWeight: FontWeight.w600),
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
              onChanged: (newValue) {},
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero),
        const SizedBox(
          height: 12,
        ),
          TextComponent(
          _data.thirdTitle,
          style:
              FontStyles.fontMedium(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextFormField(
           decoration: InputDecoration(
              label: const Text("dd/mm/yyyy"),
              contentPadding: const EdgeInsets.only(left: 0),
              suffixIcon: TextFormFieldIcons(
                assetName: AssetConstants.icCalendar,
                padding: 12,
                icColor: ColorConstants.black,
              ),
              enabled: false
            ),
        )
      ],
    );
  }
}
