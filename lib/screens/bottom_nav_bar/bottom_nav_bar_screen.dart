import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/screens/bottom_nav_bar/calculator_screen.dart';
import 'package:steuermachen/screens/bottom_nav_bar/home_screen.dart';
import 'package:steuermachen/screens/bottom_nav_bar/more_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CalculatorScreen(),
    MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorConstants.duckEggBlue,
        currentIndex: _currentIndex,
        selectedItemColor: ColorConstants.toxicGreen,
        unselectedItemColor: ColorConstants.greyBottomBar,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        selectedLabelStyle: FontStyles.fontBold(fontSize: 14),
        unselectedLabelStyle: FontStyles.fontRegular(fontSize: 14),
        onTap: (value) {
          // Respond to item press.
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: StringConstants.home,
            icon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: StringConstants.calc,
            icon: Icon(Icons.music_note),
          ),
          BottomNavigationBarItem(
            label: StringConstants.more,
            icon: Icon(Icons.library_books),
          ),
        ],
      ),
    );
  }
}
