import 'package:provider/provider.dart';
import 'package:steuermachen/providers/auth_provider.dart';
import 'package:steuermachen/providers/language_provider.dart';

providerList(context) {
  return [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
    ),
  ];
}
