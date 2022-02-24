import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/providers/auth/auth_provider.dart';
import 'package:steuermachen/components/logo_component.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserInPreference();
    super.initState();
  }

  void checkUserInPreference() {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    bool status = authProvider.checkUserInPreference();
    Future.delayed(const Duration(seconds: 3), () {
      if (status) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.bottomNavBarScreen, (val) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteConstants.onboardingScreen, (val) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          LogoComponent(),
          SizedBox(height: 15),
          SpinKitWave(
            color: ColorConstants.toxicGreen,
            size: 30,
            itemCount: 6,
            duration: Duration(milliseconds: 700),
          )
        ],
      ),
    );
  }
}
