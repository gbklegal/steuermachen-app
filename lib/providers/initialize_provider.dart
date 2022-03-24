import 'package:provider/provider.dart';
import 'package:steuermachen/providers/auth/auth_provider.dart';
import 'package:steuermachen/providers/contact/contact_us_provider.dart';
import 'package:steuermachen/providers/forms_provider.dart';
import 'package:steuermachen/providers/language_provider.dart';
import 'package:steuermachen/providers/document/document_provider.dart';
import 'package:steuermachen/providers/payment_method_provider.dart';
import 'package:steuermachen/providers/profile/profile_provider.dart';
import 'package:steuermachen/providers/signature/signature_provider.dart';
import 'package:steuermachen/providers/tax/current_year_tax/current_year_tax_provider.dart';
import 'package:steuermachen/providers/tax/declaration_tax/declaration_tax_provider.dart';
import 'package:steuermachen/providers/tax/easy_tax/easy_tax_provider.dart';
import 'package:steuermachen/providers/tax/finance_court/finance_court_provider.dart';
import 'package:steuermachen/providers/tax/quick_tax/quick_tax_provider.dart';
import 'package:steuermachen/providers/tax/safe_tax/safe_tax_provider.dart';
import 'package:steuermachen/providers/tax_calculator_provider.dart';
import 'package:steuermachen/providers/tax_file_provider.dart';
import 'package:steuermachen/providers/tax_tips_provider.dart';
import 'package:steuermachen/providers/terms_and_condition_provider.dart';

providerList(context) {
  return [
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => LanguageProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
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
    ChangeNotifierProvider(
      create: (context) => SafeTaxProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => EasyTaxProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => DeclarationTaxProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => FinanceCourtProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => SignatureProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => ContactUsProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => CurrentYearTaxProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TermsAndConditionProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PaymentMethodProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => TaxTipsProvider(),
    ),
  ];
}
