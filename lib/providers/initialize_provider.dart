import 'package:provider/provider.dart';
import 'package:steuermachen/providers/auth_provider.dart';
import 'package:steuermachen/providers/forms_provider.dart';
import 'package:steuermachen/providers/language_provider.dart';
import 'package:steuermachen/providers/document_provider.dart';
import 'package:steuermachen/providers/quick_tax_provider.dart';
import 'package:steuermachen/providers/tax_calculator_provider.dart';
import 'package:steuermachen/providers/tax_file_provider.dart';

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
      create: (context) => DocumentsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TaxFileProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TaxCalculatorProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => QuickTaxProvider(),
    ),
  ];
}
