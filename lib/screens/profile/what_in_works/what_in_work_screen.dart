import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

import '../../../constants/strings/process_constants.dart';
import '../../../wrappers/tax_steps_wrapper.dart';

class WhatInWorkStepsComponent extends StatelessWidget {
  const WhatInWorkStepsComponent({Key? key, this.submittedTaxYears})
      : super(key: key);
  final QueryDocumentSnapshot<Map<String, dynamic>>? submittedTaxYears;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<TaxStepsWrapper> taxSteps = [];
    for (var item in submittedTaxYears?["steps"]) {
      taxSteps.add(TaxStepsWrapper.fromJson(item));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Container(
            decoration: const BoxDecoration(
              color: ColorConstants.white,
              // boxShadow: [
              //   BoxShadow(
              //       color: ColorConstants.mediumGrey,
              //       spreadRadius: 2,
              //       blurRadius: 2)
              // ],
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
                    percent: calculatePercent(taxSteps),
                    center: TextComponent(
                      "${(calculatePercent(taxSteps) * 100).toStringAsFixed(0)}%",
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
                      for (var i = 0; i < taxSteps.length; i++)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(taxSteps[i].status ==
                                        ProcessConstants.approved
                                    ? AssetConstants.icActiveCheck
                                    : AssetConstants.icInActiveCheck),
                                const SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (context.locale == const Locale('en'))
                                      TextComponent(
                                        taxSteps[i].titleEn,
                                        style: FontStyles.fontRegular(
                                            fontSize: 16),
                                      )
                                    else
                                      TextComponent(
                                        taxSteps[i].titleDe,
                                        style: FontStyles.fontRegular(
                                            fontSize: 16),
                                      ),
                                    TextComponent(
                                      taxSteps[i].updatedAt?.toString() ?? "----",
                                      style:
                                          FontStyles.fontRegular(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Visibility(
                              visible: i != taxSteps.length - 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Container(
                                  height: 20,
                                  width: 5,
                                  decoration: BoxDecoration(
                                      color:
                                          ColorConstants.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10)),
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
    );
  }

  double calculatePercent(List<TaxStepsWrapper> taxSteps) {
    double percentage = 0;
    int approvedCount = 0;
    for (var element in taxSteps) {
      if (element.status == ProcessConstants.approved) {
        approvedCount = approvedCount + 1;
      }
    }
    return percentage = (approvedCount / taxSteps.length);
  }
}
