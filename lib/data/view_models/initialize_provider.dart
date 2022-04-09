import 'package:provider/provider.dart';
import 'package:steuermachen/data/view_models/auth/auth_provider.dart';
import 'package:steuermachen/data/view_models/contact/contact_us_provider.dart';
import 'package:steuermachen/data/view_models/forms_provider.dart';
import 'package:steuermachen/data/view_models/language_provider.dart';
import 'package:steuermachen/data/view_models/document/document_view_model.dart';
import 'package:steuermachen/data/view_models/payment_method_provider.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/data/view_models/tax/current_year_tax/current_year_tax_provider.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/data/view_models/tax/easy_tax/easy_tax_provider.dart';
import 'package:steuermachen/data/view_models/tax/finance_court/finance_court_provider.dart';
import 'package:steuermachen/data/view_models/tax/quick_tax/quick_tax_provider.dart';
import 'package:steuermachen/data/view_models/tax/safe_tax/safe_tax_provider.dart';
import 'package:steuermachen/data/view_models/tax_calculator_provider.dart';
import 'package:steuermachen/data/view_models/tax_file_provider.dart';
import 'package:steuermachen/data/view_models/tax_tips_provider.dart';
import 'package:steuermachen/data/view_models/terms_and_condition_provider.dart';

import 'payment_gateway/payment_gateway_provider.dart';

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
      create: (context) => DocumentsViewModel(),
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
      create: (context) => DeclarationTaxViewModel(),
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
    ChangeNotifierProvider(
      create: (context) => PaymentGateWayProvider(),
    ),
  ];
}
