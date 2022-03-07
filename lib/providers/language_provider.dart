import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String value = 'EN';

  changeLanguage(String newValue, BuildContext context) {
    value = newValue;
    if (newValue == "DU") {
      context.setLocale(const Locale('de'));
    } else {
      context.setLocale(const Locale('en'));
    }
    notifyListeners();
  }
}
