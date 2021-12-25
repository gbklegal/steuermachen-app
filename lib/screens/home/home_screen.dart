import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      {
        "leadingAsset": AssetConstants.icDocument,
        "title": LocaleKeys.haveDoneTaxOnline.tr(),
        "action": RouteConstants.maritalStatusScreen
      },
      {
        "leadingAsset": AssetConstants.icLegalAction,
        "title": LocaleKeys.legalAction.tr(),
        "action": RouteConstants.selectDocumentForScreen
      },
      {
        "leadingAsset": AssetConstants.icPersons,
        "title": LocaleKeys.initialTaxAdvice.tr(),
        "action": RouteConstants.taxAdviceScreen
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showNotificationIcon: true,
        showBottomLine: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                ),
                color: ColorConstants.formFieldBackground),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
                ),
                Image.asset(
                  AssetConstants.tax,
                  height: 120,
                ),
                const SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.howWouldYouLikeToMoveForwardWithUs.tr(),
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 28),
                      ),
                      const SizedBox(height: 5),
                      Text(
                       LocaleKeys.selectCategory.tr(),
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var i = 0; i < content.length; i++)
                    InkWell(
                      onTap: () {
                        if (i == 1) {
                          Navigator.pushNamed(context, content[i]["action"],
                              arguments: {
                                "showNextBtn": true,
                                "nextRoute": RouteConstants.legalAction2Screen
                              });
                        } else {
                          Navigator.pushNamed(context, content[i]["action"]);
                        }
                      },
                      child: _HomeCards(
                        leadingAsset: content[i]["leadingAsset"],
                        title: content[i]["title"],
                      ),
                    )
                ],
              ),
            ),
          )
        ],
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
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
          decoration: BoxDecoration(
              color: ColorConstants.formFieldBackground,
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.black.withOpacity(0.3),
                  offset: const Offset(0, 2),
                  spreadRadius: 1,
                  blurRadius: 2,
                )
              ]),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 17, letterSpacing: -0.3),
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
          )),
    );
  }
}
