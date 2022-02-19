import 'package:flutter/material.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class LogoComponent extends StatelessWidget {
  const LogoComponent({Key? key, this.fontSize = 24}) : super(key: key);
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AssetConstants.logo,
          height: fontSize != 24 ? fontSize : null,
        ),
        const SizedBox(
          width: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: TextComponent(
            StringConstants.appName,
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.w700, fontSize: fontSize),
          ),
        ),
      ],
    );
  }
}
