import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/web_view_component.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class ImprintPrivacyConditionsComponent extends StatelessWidget {
  const ImprintPrivacyConditionsComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<_DataMode> data = [
      _DataMode(LocaleKeys.imprint.tr(), "https://steuermachen.de/impressum/"),
      _DataMode(LocaleKeys.privacyPolicy.tr(),
          "https://steuermachen.de/datenschutz/"),
      _DataMode(LocaleKeys.conditions.tr(), "https://steuermachen.de/agb/"),
    ];
    text(val) => TextComponent(
          val,
          style: FontStyles.fontMedium(fontSize: 15),
        );
    return Flexible(
      fit: FlexFit.tight,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var item in data)
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewComponent(url: item.url),
                    ),
                  );
                },
                child: text(
                    "${item.name} ${item.name == LocaleKeys.conditions.tr() ? "" : "| "}"),
              ),
          ],
        ),
      ),
    );
  }
}

class _DataMode {
  final String name, url;

  _DataMode(this.name, this.url);
}
