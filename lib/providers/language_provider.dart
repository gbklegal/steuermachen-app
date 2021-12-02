import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  String value = 'en';

  changeLanguage(String newValue, BuildContext context) {
    value = newValue;
    context.setLocale(Locale(newValue));
    notifyListeners();
  }
}
