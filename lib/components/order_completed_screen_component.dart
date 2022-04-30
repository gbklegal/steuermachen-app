import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class OrderCompletedScreenComponent extends StatelessWidget {
  const OrderCompletedScreenComponent(
      {Key? key, this.showBackBtn = true, this.title, this.text})
      : super(key: key);
  final bool? showBackBtn;
  final String? title, text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          color: ColorConstants.white,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.done,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(height: 25),
                TextComponent(
                  title ?? LocaleKeys.thankYou,
                  style: FontStyles.fontMedium(fontSize: 15),
                ),
                const SizedBox(height: 15),
                TextComponent(
                  text ?? LocaleKeys.emailReceive,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    true
                        ? Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: ColorConstants.black),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: ButtonComponent(
                                btnHeight: 55,
                                color: ColorConstants.white,
                                buttonText: LocaleKeys.uploadReceipts,
                                textStyle: FontStyles.fontMedium(
                                    fontSize: 16, color: ColorConstants.black),
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      RouteConstants.bottomNavBarScreen,
                                      (val) => false);
                                  Navigator.pushNamed(context,
                                      RouteConstants.documentOverviewScreen);
                                },
                              ),
                            ),
                          )
                        // ignore: dead_code
                        : const SizedBox(),
                    const SizedBox(
                      width: 15,
                    ),
                    Flexible(
                      child: ButtonComponent(
                        btnHeight: 55,
                        buttonText: LocaleKeys.goToProfile,
                        textStyle: FontStyles.fontMedium(
                            fontSize: 16, color: ColorConstants.white),
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteConstants.bottomNavBarScreen,
                              (val) => false);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
