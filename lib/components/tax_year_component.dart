
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class TaxYearComponent extends StatelessWidget {
  const TaxYearComponent({
    Key? key,
    required this.year, this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  final String year;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap:onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextComponent(
                "${LocaleKeys.taxYear.tr()} $year",
                style: FontStyles.fontMedium(fontSize: 16),
              ),
              SvgPicture.asset(
                AssetConstants.icForward,
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
