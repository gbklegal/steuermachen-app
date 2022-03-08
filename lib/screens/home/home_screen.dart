import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/shadow_card_component.dart';
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
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 20),
                ),
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
                              leadingAsset: content[i].leadAsset,
                              title: content[i].title,
                            ),
                          ),
                        const SizedBox(
                          height: 40,
                        ),
                        const _CollectReceipts()
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

class _CollectReceipts extends StatelessWidget {
  const _CollectReceipts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteConstants.selectDocumentForScreen);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.primary, width: 1),
          borderRadius: const BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: ListTile(
          leading: SvgPicture.asset(
            AssetConstants.icReceipts,
            height: 18,
            color: ColorConstants.black,
          ),
          title: Text(
            LocaleKeys.collectReceipts.tr(),
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontWeight: FontWeight.w500, fontSize: 15, letterSpacing: -0.3),
          ),
          trailing: SvgPicture.asset(
            AssetConstants.icForward,
            height: 12,
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
