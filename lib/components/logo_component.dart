import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class LogoComponent extends StatelessWidget {
  const LogoComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetConstants.logo),
        const SizedBox(
          width: 8,
        ),
        Text(
          StringConstants.appName,
          // LocaleKeys.appName.tr(),
          textAlign: TextAlign.start,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ],
    );
  }
}
