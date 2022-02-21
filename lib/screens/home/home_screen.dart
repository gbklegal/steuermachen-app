import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/utils/string_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_CardItemsModel> content = [
      _CardItemsModel(
          leadAsset: AssetConstants.icDocument,
          title: LocaleKeys.haveDoneTaxOnline.tr(),
          action: RouteConstants.maritalStatusScreen),
      _CardItemsModel(
          leadAsset: AssetConstants.icLegalAction,
          title: LocaleKeys.legalAction.tr(),
          action: RouteConstants.selectDocumentForScreen),
      _CardItemsModel(
          leadAsset: AssetConstants.icPersons,
          title: LocaleKeys.initialTaxAdvice.tr(),
          action: RouteConstants.taxAdviceScreen),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showPersonIcon: true,
        showBottomLine: false,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: Image.asset(
                      AssetConstants.tax,
                      height: 120,
                    ),
                  ),
                ),
                Text(
                  LocaleKeys.hello.tr().onlyFirstInCaps + " OSAMA",
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.howCanWeHelpYou.tr(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < content.length; i++)
                          InkWell(
                            onTap: () {
                              if (i == 1) {
                                Navigator.pushNamed(
                                    context, content[i].action, arguments: {
                                  "showNextBtn": true,
                                  "nextRoute": RouteConstants.legalAction2Screen
                                });
                              } else {
                                Navigator.pushNamed(
                                    context, content[i].action);
                              }
                            },
                            child: _HomeCards(
                              leadingAsset: content[i].leadAsset,
                              title: content[i].title,
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeCards extends StatelessWidget {
  const _HomeCards({
    Key? key,
    required this.leadingAsset,
    required this.title,
  }) : super(key: key);
  final String leadingAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
                color: ColorConstants.veryLightPurple.withOpacity(0.4),
                offset: const Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 1)
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(leadingAsset),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            letterSpacing: -0.3),
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(
                AssetConstants.icExclamation,
                color: ColorConstants.charcoalGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardItemsModel {
  final String leadAsset, title, action;

  _CardItemsModel(
      {required this.leadAsset, required this.title, required this.action});
}
