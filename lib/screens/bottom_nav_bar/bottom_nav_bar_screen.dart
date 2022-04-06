import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/custom_icon_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/language_provider.dart';
import 'package:steuermachen/screens/faq/faq_screen.dart';
import 'package:steuermachen/screens/home/home_screen.dart';
import 'package:steuermachen/screens/tax_tips/tax_tips_screen.dart';

import '../../providers/profile/profile_provider.dart';
import '../../providers/tax_tips_provider.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;
  late TaxTipsProvider provider;
  late ProfileProvider profileProvider;
  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    provider = Provider.of<TaxTipsProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      provider.fetchTaxTips();
      profileProvider.getUserProfile();
    });

    super.initState();
  }

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    TaxTipsScreen(),
    FaqScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, consumer, child) {
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
          selectedLabelStyle: FontStyles.fontMedium(fontSize: 10),
          unselectedLabelStyle: FontStyles.fontRegular(fontSize: 10),
          onTap: (value) {
            // Respond to item press.
            // if (value == 2) {
            //   Navigator.pushNamed(context, RouteConstants.moreScreen);
            // } else {
            setState(() {
              _currentIndex = value;
            });
            // }
          },
          items: [
            BottomNavigationBarItem(
              label: LocaleKeys.overView.tr(),
              icon: CustomIcon(
                AssetConstants.icHome,
                size: 24,
              ),
            ),
            BottomNavigationBarItem(
              label: LocaleKeys.taxAdvisor.tr(),
              icon: CustomIcon(AssetConstants.icLightBulb),
            ),
            BottomNavigationBarItem(
              label: LocaleKeys.faq.tr(),
              icon: CustomIcon(AssetConstants.icQuestion),
            ),
          ],
        ),
      );
    });
  }
}
