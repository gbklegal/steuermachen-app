import 'package:flutter/material.dart';
import 'package:steuermachen/components/language_dropdown_component.dart';
import 'package:steuermachen/components/logo_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/language_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;
  final pageController = PageController(initialPage: 0);
  List<OnboardingDataModel> onboardingData = [
    OnboardingDataModel(
        text1: LocaleKeys.onboardingOne,
        text2: LocaleKeys.onboardingTitle,
        imagePath: AssetConstants.onboard1),
    OnboardingDataModel(
        text1: LocaleKeys.onboardingTwo,
        text2: LocaleKeys.onboardingTitle,
        imagePath: AssetConstants.onboard2),
    OnboardingDataModel(
        text1: LocaleKeys.onboardingThree,
        text2: LocaleKeys.onboardingTitle,
        imagePath: AssetConstants.onboard3),
    OnboardingDataModel(
        text1: LocaleKeys.onboardingFour,
        text2: LocaleKeys.onboardingTitle,
        imagePath: AssetConstants.onboard4)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child:
              Consumer<LanguageProvider>(builder: (context, consumer, child) {
            return Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18, right: 18, bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteConstants.getStartedScreen, (val) => false);
                        },
                        child: const TextComponent(
                          LocaleKeys.skip,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorConstants.black,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1,
                              fontSize: 17),
                        ),
                      ),
                      const LogoComponent(
                        fontSize: 17,
                      ),
                      const LanguageDropdownComponent(),
                    ],
                  ),
                ),
                Flexible(
                  child: PageView(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index) {
                      setState(() {
                        pageIndex = index;
                      });
                    },
                    children: [
                      for (var item in onboardingData)
                        _bottomTitleAndText(
                            title: item.text1,
                            text: item.text2,
                            assetName: item.imagePath),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < onboardingData.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: _indicatorDotsWidget(
                            color: pageIndex == i
                                ? ColorConstants.primary
                                : ColorConstants.mediumGrey,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Padding _bottomTitleAndText(
      {required String title,
      required String text,
      required String assetName}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorConstants.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                letterSpacing: 1,
                fontSize: 20),
          ),
          Flexible(
            child: Image.asset(assetName, height: 196, width: 196),
          ),
          TextComponent(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: ColorConstants.black,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 24),
          ),
        ],
      ),
    );
  }

  Container _indicatorDotsWidget({required Color color}) {
    return Container(
      height: 14,
      width: 14,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    );
  }
}

class OnboardingDataModel {
  final String text1, text2, imagePath;

  OnboardingDataModel(
      {required this.text1, required this.text2, required this.imagePath});
}
