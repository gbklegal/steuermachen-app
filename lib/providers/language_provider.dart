import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String value = 'English';

  changeLanguage(String newValue, BuildContext context) {
    value = newValue;
    if (newValue == "Deutsch") {
      context.setLocale(const Locale('de'));
    } else {
      context.setLocale(const Locale('en'));
    }
    notifyListeners();
  }
}
