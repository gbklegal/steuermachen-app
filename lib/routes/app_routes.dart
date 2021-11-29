import 'package:flutter/material.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/screens/auth/signin_screen.dart';
import 'package:steuermachen/screens/auth/signup_screen.dart';
import 'package:steuermachen/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:steuermachen/screens/document/select_document_for_upload_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_info_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_final_submission_screen.dart';
import 'package:steuermachen/screens/file_tax/file_tax_upload_document_screen.dart';
import 'package:steuermachen/screens/file_tax/tax_file_current_income_screen.dart';
import 'package:steuermachen/screens/file_tax/tax_file_marital_status_screen.dart';
import 'package:steuermachen/screens/auth/verify_account_screen.dart';
import 'package:steuermachen/screens/file_tax/tax_file_year_screen.dart';
import 'package:steuermachen/screens/get_started/get_started_screen.dart';
import 'package:steuermachen/screens/onboarding/onboarding_screen.dart';

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
      return MaterialPageRoute(builder: (context) => const TaxFileMaritalStatusScreen());
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
        builder: (_) =>  FileTaxInfoScreen(),
      );
    case RouteConstants.fileTaxUploadDocScreen:
      return MaterialPageRoute(
        builder: (_) =>  const FileTaxUploadDocumentScreen(),
      );
    case RouteConstants.fileTaxFinalSubmissionScreen:
      return MaterialPageRoute(
        builder: (_) =>  const FileTaxFinalSubmissionScreen(),
      );
    case RouteConstants.bottomNavBarScreen:
      return MaterialPageRoute(
        builder: (_) =>  const BottomNavBarScreen(),
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
