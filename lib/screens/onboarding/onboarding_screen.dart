import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/language_dropdown_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/language_provider.dart';
import 'package:provider/provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int pageIndex = 0;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorConstants.white,
        height: MediaQuery.of(context).size.height,
        child: Consumer<LanguageProvider>(builder: (context, consumer, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 56, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      StringConstants.skip,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ColorConstants.black,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18),
                    ),
                    const LanguageDropdownComponent(),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Flexible(
                flex: 2,
                child: PageView(
                  controller: pageController,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index) {
                    setState(() {
                      pageIndex = index;
                    });
                  },
                  children: [
                    _bottomTitleAndText(
                        text: LocaleKeys.onboardingOneText.tr(),
                        title: LocaleKeys.onboardingOne.tr(),
                        assetName: AssetConstants.onboard1),
                    _bottomTitleAndText(
                        text: LocaleKeys.onboardingTwoText.tr(),
                        title: LocaleKeys.onboardingTwo.tr(),
                        assetName: AssetConstants.onboard2),
                    _bottomTitleAndText(
                        text: LocaleKeys.onboardingThreeText.tr(),
                        title: LocaleKeys.onboardingThree.tr(),
                        assetName: AssetConstants.onboard3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: _bottomTitleAndText(
                              text: LocaleKeys.onboardingFourText.tr(),
                              title: LocaleKeys.onboardingFour.tr(),
                              assetName: AssetConstants.onboard4),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, RouteConstants.getStartedScreen);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(bottom: 25, right: 15),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: ColorConstants.primary,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < 4; i++)
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
          Flexible(
            flex: 2,
            child: Image.asset(assetName, height: 256, width: 256),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: ColorConstants.green,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1,
                    fontSize: 48),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10, right: 50),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      color: ColorConstants.black,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontSize: 24),
                ),
              ),
            ],
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
