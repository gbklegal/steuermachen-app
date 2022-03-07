import 'package:flutter/material.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/screens/auth/forgot_password_screen.dart';
import 'package:steuermachen/screens/auth/signin_screen.dart';
import 'package:steuermachen/screens/auth/signup_screen.dart';
import 'package:steuermachen/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:steuermachen/screens/bottom_nav_bar/more_screen.dart';
import 'package:steuermachen/screens/calculator/calculator_screen.dart';
import 'package:steuermachen/screens/contact_us/chat/chat_screen.dart';
import 'package:steuermachen/screens/contact_us/contact_us_form_screen.dart';
import 'package:steuermachen/screens/contact_us/contact_us_options_screen.dart';
import 'package:steuermachen/screens/document/select_document_for_upload_screen.dart';
import 'package:steuermachen/screens/document/uploaded_document_screen.dart';
import 'package:steuermachen/screens/faq/faq_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_done_order_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_info_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_final_submission_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_upload_document_screen.dart';
import 'package:steuermachen/screens/file_tax/tax_file_current_income_screen.dart';
import 'package:steuermachen/screens/file_tax/tax_file_marital_status_screen.dart';
import 'package:steuermachen/screens/auth/verify_account_screen.dart';
import 'package:steuermachen/screens/file_tax/tax_file_year_screen.dart';
import 'package:steuermachen/screens/get_started/get_started_screen.dart';
import 'package:steuermachen/screens/how_it_works/how_it_works_screen.dart';
import 'package:steuermachen/screens/legal_action/legal_action2_screen.dart';
import 'package:steuermachen/screens/onboarding/onboarding_screen.dart';
import 'package:steuermachen/screens/payment/billing/add_new_billing_address_screen.dart';
import 'package:steuermachen/screens/payment/confirm_bill_screen.dart';
import 'package:steuermachen/screens/payment/billing/select_billing_address_screen.dart';
import 'package:steuermachen/screens/payment/card/card_method_screen.dart';
import 'package:steuermachen/screens/payment/payment_terms_condition_screen.dart';
import 'package:steuermachen/screens/profile/complete_profile_screen.dart';
import 'package:steuermachen/screens/profile/order_overview_screen.dart';
import 'package:steuermachen/screens/profile/profile_%20menu_screen.dart';
import 'package:steuermachen/screens/profile/profile_screen.dart';
import 'package:steuermachen/screens/splash_screen.dart';
import 'package:steuermachen/screens/sustainability/sustainability_screen.dart';
import 'package:steuermachen/screens/tax/declaration_tax/declaration_tax_screen.dart';
import 'package:steuermachen/screens/tax/easy_tax/easy_tax_component/tax_advice_form_screen.dart';
import 'package:steuermachen/screens/tax/easy_tax/easy_tax_screen.dart';
import 'package:steuermachen/screens/tax/finance_court/finance_court_screen.dart';
import 'package:steuermachen/screens/tax/quick_tax/quick_tax_screen.dart';
import 'package:steuermachen/screens/tax/safe_tax/safe_tax_screen.dart';
import 'package:steuermachen/screens/tax/select_safe_or_quick_tax_screen.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_screen.dart';

onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RouteConstants.splashScreen:
      return MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      );
    case RouteConstants.onboardingScreen:
      return MaterialPageRoute(
        builder: (_) => const OnBoardingScreen(),
      );
    case RouteConstants.getStartedScreen:
      return MaterialPageRoute(
        builder: (_) => const GetStartedScreen(),
      );
    case RouteConstants.signInScreen:
      return MaterialPageRoute(
        builder: (_) => const SignInScreen(),
      );
    case RouteConstants.forgotPasswordScreen:
      return MaterialPageRoute(
        builder: (_) => const ForgotPasswordScreen(),
      );
    case RouteConstants.signupScreen:
      return MaterialPageRoute(
        builder: (_) => const SignupScreen(),
      );
    case RouteConstants.maritalStatusScreen:
      return MaterialPageRoute(
          builder: (context) => const TaxFileMaritalStatusScreen());
    case RouteConstants.verifyAccountScreen:
      return MaterialPageRoute(
        builder: (_) => const VerifyAccountScreen(),
      );
    case RouteConstants.selectDocumentForScreen:
      if (settings.arguments != null) {
        Map obj = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (_) => SelectDocumentForScreen(
            showNextBtn: obj["showNextBtn"] ?? false,
            onNextBtnRoute: obj["nextRoute"] ?? "",
            uploadBtnNow: obj["uploadBtn"] ?? false,
            showRoundBody: obj["roundBody"] ?? true,
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => const SelectDocumentForScreen(),
      );
    case RouteConstants.selectYearScreen:
      return MaterialPageRoute(
        builder: (_) => const TaxFileYearScreen(),
      );
    case RouteConstants.currentIncomeScreen:
      return MaterialPageRoute(
        builder: (_) => const TaxFileCurrentIncomeScreen(),
      );
    case RouteConstants.fileTaxInfoScreen:
      return MaterialPageRoute(
        builder: (_) => const FileTaxInfoScreen(),
      );
    case RouteConstants.fileTaxUploadDocScreen:
      return MaterialPageRoute(
        builder: (_) => const FileTaxUploadDocumentScreen(),
      );
    case RouteConstants.fileTaxFinalSubmissionScreen:
      return MaterialPageRoute(
        builder: (_) => const FileTaxFinalSubmissionScreen(),
      );
    case RouteConstants.fileTaxDoneOrderScreen:
      return MaterialPageRoute(
        builder: (_) => const FileTaxDoneOrderScreen(),
      );
    case RouteConstants.bottomNavBarScreen:
      return MaterialPageRoute(
        builder: (_) => const BottomNavBarScreen(),
      );
    case RouteConstants.selectSafeAndQuickTaxScreen:
      return MaterialPageRoute(
        builder: (_) => const SelectSafeAndQuickTaxScreen(),
      );
    case RouteConstants.quickTaxScreen:
      return MaterialPageRoute(
        builder: (_) => const QuickTaxScreen(),
      );
    case RouteConstants.safeTaxScreen:
      return MaterialPageRoute(
        builder: (_) => const SafeTaxScreen(),
      );
    case RouteConstants.declarationTaxScreen:
      return MaterialPageRoute(
        builder: (_) => const DeclarationTaxScreen(),
      );
    case RouteConstants.easyTaxScreen:
      return MaterialPageRoute(
        builder: (_) => const EasyTaxScreen(),
      );
    case RouteConstants.financeCourtScreen:
      return MaterialPageRoute(
        builder: (_) => const FinanceCourtScreen(),
      );
    case RouteConstants.contactUsOptionScreen:
      return MaterialPageRoute(
        builder: (_) => const ContactUsOptionScreen(),
      );
    case RouteConstants.chatScreen:
      return MaterialPageRoute(
        builder: (_) => const ChatScreen(),
      );
    case RouteConstants.uploadedDocumentScreen:
      return MaterialPageRoute(
        builder: (_) => const UploadedDocumentScreen(),
      );
    case RouteConstants.howItWorksScreen:
      return MaterialPageRoute(
        builder: (_) => const HowItWorksScreen(),
      );
    case RouteConstants.faqScreen:
      return MaterialPageRoute(
        builder: (_) => const FaqScreen(),
      );
    case RouteConstants.contactUsFormScreen:
      return MaterialPageRoute(
        builder: (_) => const ContactUsFormScreen(),
      );
    case RouteConstants.sustainabilityScreen:
      return MaterialPageRoute(
        builder: (_) => const SustainabilityScreen(),
      );
    case RouteConstants.taxTipsScreen:
      return MaterialPageRoute(
        builder: (_) => const TaxTipsScreen(),
      );
    case RouteConstants.cardPaymentMethodScreen:
      return MaterialPageRoute(
        builder: (_) => const CardPaymentMethodScreen(),
      );
    case RouteConstants.selectBillingAddressScreen:
      return MaterialPageRoute(
        builder: (_) => const SelectBillingAddressScreen(),
      );
    case RouteConstants.addNewBillingAddressScreen:
      return MaterialPageRoute(
        builder: (_) => const AddNewBillingAddressScreen(),
      );
    case RouteConstants.confirmBillingScreen:
      return MaterialPageRoute(
        builder: (_) => const ConfirmBillingScreen(),
      );
    case RouteConstants.paymentTermsConditionScreen:
      return MaterialPageRoute(
        builder: (_) => const PaymentTermsConditionScreen(),
      );
    // case RouteConstants.taxTipsDetailScreen:
    //   return MaterialPageRoute(
    //     builder: (_) => const TaxTipsDetailScreen(),
    //   );
    case RouteConstants.legalAction2Screen:
      return MaterialPageRoute(
        builder: (_) => const LegalAction2Screen(),
      );
    // case RouteConstants.taxAdviceScreen:
    //   return MaterialPageRoute(
    //     builder: (_) => const TaxAdviceScreen(),
    //   );
    case RouteConstants.taxAdviceFormScreen:
      return MaterialPageRoute(
        builder: (_) => const TaxAdviceFormScreen(),
      );
    case RouteConstants.profileScreen:
      return MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      );
    case RouteConstants.completeProfileScreen:
      return MaterialPageRoute(
        builder: (_) => const CompleteProfileScreen(),
      );
    case RouteConstants.calculatorScreen:
      return MaterialPageRoute(
        builder: (_) => const CalculatorScreen(),
      );
    case RouteConstants.moreScreen:
      return MaterialPageRoute(
        builder: (_) => const MoreScreen(),
      );
    case RouteConstants.profileMenuScreen:
      return MaterialPageRoute(
        builder: (_) => const ProfileMenuScreen(),
      );
    case RouteConstants.orderOverviewScreen:
      return MaterialPageRoute(
        builder: (_) => const OrderOverviewScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Invalid route"),
          ),
        ),
      );
  }
}
