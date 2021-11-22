import 'package:flutter/material.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class LogoAuthComponent extends StatelessWidget {
  const LogoAuthComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AssetConstants.logo),
        Text(
          StringConstants.appName,
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
