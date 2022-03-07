import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class WhatInWorkScreen extends StatelessWidget {
  const WhatInWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new_sharp,
          color: ColorConstants.black,
        ),
        title: Transform.translate(
          offset: const Offset(-13, -2),
          child: TextComponent(
            LocaleKeys.checkWhatInWorks,
            style: FontStyles.fontMedium(
                fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ColorConstants.formFieldBackground,
            ),
            child: Column(
              children: [
                Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: ColorConstants.formFieldBackground,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: TextComponent(
                    "Estimated reimbursement :   -----",
                    style: FontStyles.fontMedium(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: true,
                    lineHeight: 20.0,
                    animationDuration: 2000,
                    percent: 0.9,
                    center: const TextComponent("90.0%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
