import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/codegen_loader.g.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/initialize_provider.dart';
import 'package:steuermachen/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steuermachen/screens/splash_screen.dart';

// flutter pub run easy_localization:generate -S "assets/languages" -O "lib/languages"
// flutter pub run easy_localization:generate -S "assets/languages" -O "lib/languages" -o "locale_keys.g.dart" -f keys
late FirebaseAuth auth;
late FirebaseFirestore firestore;
initializeFirestore() {
  FirebaseApp secondaryApp = Firebase.app();
  firestore = FirebaseFirestore.instanceFor(app: secondaryApp);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  initializeFirestore();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  auth = FirebaseAuth.instance;
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
      providers: providerList(context),
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
        home: const SplashScreen(),
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
    underlineInputBorder({Color? color = ColorConstants.veryLightPurple}) =>
        UnderlineInputBorder(
          borderSide: BorderSide(color: color!, width: 0.3),
        );
    return InputDecorationTheme(
        labelStyle: GoogleFonts.raleway(
          fontSize: 14.0,
          fontStyle: FontStyle.normal,
          color: ColorConstants.veryLightPurple,
        ),
        floatingLabelStyle: GoogleFonts.raleway(
          fontSize: 15.0,
          fontStyle: FontStyle.normal,
          color: ColorConstants.blue,
        ),
        enabledBorder: underlineInputBorder(color: ColorConstants.blue),
        focusedBorder: underlineInputBorder(color: ColorConstants.blue),
        border: underlineInputBorder(color: ColorConstants.blue),
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
        textStyle: GoogleFonts.raleway(
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
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
      headline5: GoogleFonts.raleway(
          fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
      bodyText1: GoogleFonts.raleway(
          fontSize: 16.0,
          color: ColorConstants.black,
          fontStyle: FontStyle.normal),
      bodyText2:
          GoogleFonts.raleway(fontSize: 14.0, color: ColorConstants.black),
      button: GoogleFonts.raleway(
          fontSize: 16.0,
          color: ColorConstants.white,
          fontWeight: FontWeight.normal),
    );
  }
}
