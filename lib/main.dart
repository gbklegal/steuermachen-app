import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/theme/app_theme.dart';
import 'package:steuermachen/data/repositories/remote/documents_repository.dart';
import 'package:steuermachen/data/repositories/remote/safe_and_declaration_tax_repository.dart';
import 'package:steuermachen/languages/codegen_loader.g.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/initialize_provider.dart';
import 'package:steuermachen/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steuermachen/screens/splash_screen.dart';
import 'package:steuermachen/services/navigation_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/services/shared_preferences_service.dart';

import 'services/networks/dio_api_services.dart';

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
  setupDepedencies();
  await serviceLocatorInstance<DioClientNetwork>().initializeDioClientNetwork();
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

final serviceLocatorInstance = GetIt.instance;
void setupDepedencies() {
  serviceLocatorInstance
      .registerSingleton<DioClientNetwork>(DioClientNetwork());
  serviceLocatorInstance.registerLazySingleton(() => DioApiServices());
  serviceLocatorInstance.registerLazySingleton(() => DocumentsRepository());
  serviceLocatorInstance.registerLazySingleton(() => SafeAndDeclarationTaxRepository());
  // serviceLocatorInstance.registerLazySingleton(() => ProfileRepository());
  serviceLocatorInstance.registerLazySingleton(() => NavigationService());
  serviceLocatorInstance
      .registerLazySingleton(() => SharedPreferencesService());
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
}
