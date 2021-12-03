import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/codegen_loader.g.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/language_provider.dart';
import 'package:steuermachen/routes/app_routes.dart';
import 'package:steuermachen/screens/onboarding/onboarding_screen.dart';

// flutter pub run easy_localization:generate -S "assets/languages" -O "lib/languages"
// flutter pub run easy_localization:generate -S "assets/languages" -O "lib/languages" -o "locale_keys.g.dart" -f keys
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('de'),
      ],
      path: 'assets/languages',
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider())
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: LocaleKeys.appName,
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        onGenerateRoute: (settings) {
          return onGenerateRoutes(settings);
        },
        home: const OnBoardingScreen(),
      ),
    );
  }

  ThemeData appTheme() {
    return ThemeData(
      primarySwatch: ColorConstants.kPrimaryColor,
      scaffoldBackgroundColor: ColorConstants.body,
      textTheme: _textTheme(),
      elevatedButtonTheme: _elevatedBtnTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
        labelStyle: TextStyle(
          fontSize: 20.0,
          fontFamily: 'helvetica',
          fontStyle: FontStyle.normal,
          color: ColorConstants.black.withOpacity(0.4),
        ),
        border: InputBorder.none,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: ColorConstants.formFieldBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: ColorConstants.formFieldBackground),
        ),
        fillColor: ColorConstants.formFieldBackground);
  }

  ElevatedButtonThemeData _elevatedBtnTheme() {
    return ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.8,
        backgroundColor: ColorConstants.primary,
        textStyle: const TextStyle(
            fontSize: 18.0,
            fontFamily: 'helvetica',
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal),
      ),
    );
  }

  TextTheme _textTheme() {
    return TextTheme(
      headline1:
          GoogleFonts.raleway(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: GoogleFonts.raleway(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
      bodyText1:
          GoogleFonts.raleway(fontSize: 16.0, color: ColorConstants.black),
      bodyText2: GoogleFonts.raleway(
        fontSize: 14.0,
      ),
      button: GoogleFonts.raleway(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: ColorConstants.white),
    );
  }
}
