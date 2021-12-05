import 'package:flutter/material.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/screens/auth/signin_screen.dart';
import 'package:steuermachen/screens/auth/signup_screen.dart';
import 'package:steuermachen/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:steuermachen/screens/calculator/calculator_screen.dart';
import 'package:steuermachen/screens/contact_us/contact_us_form_screen.dart';
import 'package:steuermachen/screens/contact_us/contact_us_options_screen.dart';
import 'package:steuermachen/screens/document/select_document_for_upload_screen.dart';
import 'package:steuermachen/screens/document/uploaded_document_screen.dart';
import 'package:steuermachen/screens/faq/faq_screen.dart';
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
import 'package:steuermachen/screens/profile/profile_screen.dart';
import 'package:steuermachen/screens/sustainability/sustainability_screen.dart';
import 'package:steuermachen/screens/tax_advice/tax_advice_screen.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_detail_screen.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_screen.dart';

onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
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
        builder: (_) => FileTaxInfoScreen(),
      );
    case RouteConstants.fileTaxUploadDocScreen:
      return MaterialPageRoute(
        builder: (_) => const FileTaxUploadDocumentScreen(),
      );
    case RouteConstants.fileTaxFinalSubmissionScreen:
      return MaterialPageRoute(
        builder: (_) => const FileTaxFinalSubmissionScreen(),
      );
    case RouteConstants.bottomNavBarScreen:
      return MaterialPageRoute(
        builder: (_) => const BottomNavBarScreen(),
      );
    case RouteConstants.contactUsOptionScreen:
      return MaterialPageRoute(
        builder: (_) => const ContactUsOptionScreen(),
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
    case RouteConstants.taxTipsDetailScreen:
      return MaterialPageRoute(
        builder: (_) => const TaxTipsDetailScreen(),
      );
    case RouteConstants.legalAction2Screen:
      return MaterialPageRoute(
        builder: (_) => const LegalAction2Screen(),
      );
    case RouteConstants.taxAdviceScreen:
      return MaterialPageRoute(
        builder: (_) => const TaxAdviceScreen(),
      );
    case RouteConstants.profileScreen:
      return MaterialPageRoute(
        builder: (_) => const ProfileScreen(),
      );
    case RouteConstants.calculatorScreen:
      return MaterialPageRoute(
        builder: (_) => const CalculatorScreen(),
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
