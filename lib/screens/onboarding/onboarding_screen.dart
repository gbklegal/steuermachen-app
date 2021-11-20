import 'package:flutter/material.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

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
        color: ColorConstants.black.withOpacity(0.4),
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 56, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringConstants.skip,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: ColorConstants.white,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1,
                        fontSize: 18),
                  ),
                  // DropdownButton<String>(
                  //   underline: const SizedBox(),
                  //   onChanged: (val){},
                  //   value: null,
                  //   items: const [
                  //     DropdownMenuItem(
                  //       child: Text("English"),
                  //     ),
                  //     DropdownMenuItem(
                  //       child: Text("Deutsch"),
                  //     ),
                  //   ],
                  // )
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
                  _bottomTitleAndText(
                      text: StringConstants.onboardingText_1,
                      title: StringConstants.onboarding_1),
                  _bottomTitleAndText(
                      text: StringConstants.onboardingText_2,
                      title: StringConstants.onboarding_2),
                  _bottomTitleAndText(
                      text: StringConstants.onboardingText_3,
                      title: StringConstants.onboarding_3),
                  _bottomTitleAndText(
                      text: StringConstants.onboardingText_4,
                      title: StringConstants.onboarding_4),
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
        ),
      ),
    );
  }

  Padding _bottomTitleAndText({required String title, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
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
              style: TextStyle(
                  color: ColorConstants.white,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontSize: 24),
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
