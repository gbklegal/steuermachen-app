import 'dart:async';

import 'package:flutter/material.dart';
import 'package:steuermachen/components/language_dropdown_component.dart';
import 'package:steuermachen/components/logo_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/language_provider.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/utils/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Timer timer;
  int pageIndex = 0;
  final pageController = PageController(initialPage: 0);
  List<OnboardingDataModel> onboardingData = [
    OnboardingDataModel(
        text1: LocaleKeys.onboardingOne,
        text2: LocaleKeys.onboardingTitle,
        imagePath: AssetConstants.onboard1),
    OnboardingDataModel(
        text1: LocaleKeys.onboardingTwo,
        text2: "",
        imagePath: AssetConstants.onboard2),
    OnboardingDataModel(
        text1: LocaleKeys.onboardingThree,
        text2: "",
        imagePath: AssetConstants.onboard3),
    OnboardingDataModel(
        text1: LocaleKeys.onboardingFour,
        text2: "",
        imagePath: AssetConstants.onboard4)
  ];
  @override
  void initState() {
    timer = _timer();
    super.initState();
  }

  Timer _timer() {
    return Timer.periodic(const Duration(seconds: 3), (val) {
      setState(() {
        int? currentPage = int.parse(pageController.page!.toStringAsFixed(0));
        pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInToLinear);
        if (currentPage == 3) {
          pageController.jumpToPage(0);
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: SafeArea(
        child: GestureDetector(
          onTapDown: (val) {
            timer.cancel();
          },
          onTapUp: (val) {
            timer = _timer();
          },
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
                        const EdgeInsets.only(left: 18, right: 18, bottom: 39),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteConstants.getStartedScreen,
                                (val) => false);
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
                    padding: const EdgeInsets.only(
                      bottom: 20,
                    ),
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
        children: [
          Image.asset(assetName, height: 264, width: 264),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: text != "",
                  child: TextComponent(
                    text,
                    // textAlign: TextAlign.center,
                    style: FontStyles.fontBold(
                        color: ColorConstants.black,
                        letterSpacing: 0.2,
                        fontSize: 36),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextComponent(
                  title,
                  // textAlign: TextAlign.center,
                  style: FontStyles.fontBold(
                      color: ColorConstants.black,
                      letterSpacing: 0.2,
                      fontSize: text == "" ? 36 : 24),
                ),
              ],
            ),
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
