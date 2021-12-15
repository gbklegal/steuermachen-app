import 'package:provider/provider.dart';
import 'package:steuermachen/providers/auth_provider.dart';
import 'package:steuermachen/providers/forms_provider.dart';
import 'package:steuermachen/providers/language_provider.dart';
import 'package:steuermachen/providers/legal_advice_provider.dart';

providerList(context) {
  return [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => FormsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LegalAdviceProvider(),
    ),
  ];
}
