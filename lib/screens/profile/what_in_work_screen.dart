import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
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
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_sharp,
            color: ColorConstants.black,
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Container(
              decoration: const BoxDecoration(
                color: ColorConstants.white,
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.mediumGrey,
                      spreadRadius: 2,
                      blurRadius: 2)
                ],
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
                      animation: true,
                      lineHeight: 20.0,
                      animationDuration: 2000,
                      percent: 0.9,
                      center: TextComponent(
                        "90.0%",
                        style:
                            FontStyles.fontRegular(color: ColorConstants.white),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: ColorConstants.toxicGreen,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      children: [
                        for (var i = 0; i < 5; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(i < 2
                                      ? AssetConstants.icActiveCheck
                                      : AssetConstants.icInActiveCheck),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextComponent(
                                        "Tax return commissioned ",
                                        style: FontStyles.fontRegular(
                                            fontSize: 16),
                                      ),
                                      TextComponent(
                                        "08-02-2022",
                                        style: FontStyles.fontRegular(
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Visibility(
                                visible: i != 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Container(
                                    height: 20,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: ColorConstants.grey
                                            .withOpacity(0.3),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
