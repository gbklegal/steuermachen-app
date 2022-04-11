import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/collect_receipt_component.dart';
import 'package:steuermachen/components/shadow_card_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/utils/string_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<_CardItemsModel> content = [
      _CardItemsModel(
          leadAsset: AssetConstants.icDocument,
          title: LocaleKeys.getYourTaxReturnDoneNow.tr(),
          action: RouteConstants.selectSafeAndQuickTaxScreen),
      _CardItemsModel(
          leadAsset: AssetConstants.icLegalAction,
          title: LocaleKeys.taxEasyInitialTaxAdvice.tr(),
          action: RouteConstants.easyTaxScreen),
      _CardItemsModel(
          leadAsset: AssetConstants.icPersons,
          title: LocaleKeys.objectionRejection.tr(),
          action: RouteConstants.financeCourtScreen),
      _CardItemsModel(
          leadAsset: AssetConstants.icLegalAction,
          title: LocaleKeys.yourProfile.tr(),
          action: RouteConstants.profileMenuScreen),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: false,
        showPersonIcon: false,
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
                Consumer<ProfileProvider>(builder: (context, consumer, child) {
                  return Text(
                    LocaleKeys.hello.tr().onlyFirstInCaps +
                        " ${consumer.userData?.firstName ?? ""}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                  );
                }),
                const SizedBox(height: 5),
                Text(
                  LocaleKeys.howCanWeHelpYou.tr(),
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.none,
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
                                Navigator.pushNamed(context, content[i].action);
                              }
                            },
                            child: ShadowCardComponent(
                              bgColor: i == 0
                                  ? ColorConstants.primary
                                  : ColorConstants.white,
                              fontColor: i == 0
                                  ? ColorConstants.white
                                  : ColorConstants.black,
                              iconColor: i == 0
                                  ? ColorConstants.white
                                  : ColorConstants.black,
                              leadingAsset: content[i].leadAsset,
                              title: content[i].title,
                              fontSize: 13.3,
                              trailingAsset: AssetConstants.icForward,
                            ),
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                        const CollectReceiptsComponent()
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
