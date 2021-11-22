import 'package:flutter/material.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/screens/auth/signin_screen.dart';
import 'package:steuermachen/screens/auth/signup_screen.dart';
import 'package:steuermachen/screens/file_tax/marital_status_screen.dart';
import 'package:steuermachen/screens/auth/verify_account_screen.dart';
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
      return MaterialPageRoute(builder: (_) => const MaritalStatusScreen());
    case RouteConstants.verifyAccountScreen:
      return MaterialPageRoute(
        builder: (_) => const VerifyAccountScreen(),
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
