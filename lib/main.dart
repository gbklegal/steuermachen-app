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
        textTheme: TextTheme(
          headline1:
              const TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: const TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal),
          bodyText1: const TextStyle(fontSize: 16.0),
          bodyText2: const TextStyle(fontSize: 14.0),
          button: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: ColorConstants.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0.8,
            backgroundColor: ColorConstants.primary,
            // minimumSize: Size(MediaQuery.of(context).size.width, 48),
          ),
        ));
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
