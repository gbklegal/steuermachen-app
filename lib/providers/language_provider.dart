import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String value = 'EN';

  changeLanguage(String newValue, BuildContext context) {
    value = newValue;
    if (newValue == "DE") {
      context.setLocale(const Locale('de'));
    } else {
      context.setLocale(const Locale('en'));
    }
    notifyListeners();
  }
}
