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
        "title": "Have done tax online",
        "action": RouteConstants.maritalStatusScreen
      },
      {
        "leadingAsset": AssetConstants.icLegalAction,
        "title": "Legal Action",
        "action": RouteConstants.legalAction2Screen
      },
      {
        "leadingAsset": AssetConstants.icPersons,
        "title": "Intial Tax Advice",
        "action": RouteConstants.taxAdviceScreen
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarComponent(
        LocaleKeys.appName.tr(),
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
                Image.asset(AssetConstants.homeLaptop),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 30),
                  child: Text(
                    StringConstants.howWouldYouLikeToMoveForwardWithUs,
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 28),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 15, bottom: 20),
                  child: Text(
                    "Select catogorie suitable to you",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w400, fontSize: 20),
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
                        Navigator.pushNamed(context, content[i]["action"]);
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
                              .headline5!
                              .copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 20),
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
