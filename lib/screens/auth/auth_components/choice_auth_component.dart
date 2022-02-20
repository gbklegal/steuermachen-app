import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class ChoiceTextAuthComponent extends StatelessWidget {
  const ChoiceTextAuthComponent({Key? key, required this.text})
      : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1, bottom: 22),
      child: Column(
        children: [
          Text(
            LocaleKeys.or.tr().toLowerCase(),
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ColorConstants.black.withOpacity(0.6),
                  fontSize: 14,
                ),
          ),
          TextComponent(
            text,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: ColorConstants.black.withOpacity(0.6),
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }
}
