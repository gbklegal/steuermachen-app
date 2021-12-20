import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/providers/language_provider.dart';

class LanguageDropdownComponent extends StatefulWidget {
  const LanguageDropdownComponent({Key? key}) : super(key: key);

  @override
  _LanguageDropdownComponentState createState() =>
      _LanguageDropdownComponentState();
}

class _LanguageDropdownComponentState extends State<LanguageDropdownComponent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, consumer, child) {
      return DropdownButton<String>(
        value: consumer.value,
        icon: SvgPicture.asset(
          AssetConstants.icDown,
          height: 8,
        ),
        iconSize: 18,
        style: const TextStyle(color: ColorConstants.toxicGreen, fontSize: 18),
        underline: const SizedBox(),
        onChanged: (String? newValue) {
          consumer.changeLanguage(newValue!, context);
        },
        items: <String>['English', 'Deutsch']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.9),
            ),
          );
        }).toList(),
      );
    });
  }
}
