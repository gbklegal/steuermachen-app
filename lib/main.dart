import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/routes/app_routes.dart';
import 'package:steuermachen/screens/onboarding/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Steuermachen',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      onGenerateRoute: (settings) {
        return onGenerateRoutes(settings);
      },
      home: const OnBoardingScreen(),
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
          borderSide: const BorderSide(color: ColorConstants.formFieldBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: ColorConstants.formFieldBackground),
        ),
        fillColor: ColorConstants.formFieldBackground
        );
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
    return const TextTheme(
      headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(
          fontSize: 36.0,
          fontFamily: 'helvetica',
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal),
      bodyText1: TextStyle(
          fontSize: 16.0, fontFamily: 'helvetica', color: ColorConstants.black),
      bodyText2: TextStyle(
        fontSize: 14.0,
        fontFamily: 'helvetica',
      ),
      button: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: ColorConstants.white),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
