import 'dart:math';

import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/language_dropdown_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/language_provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List<MoreOptions> moreOptionsList = [];
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    moreOptionsList = [
      MoreOptions(
        leadingIcon: AssetConstants.icProfile,
        routeName: RouteConstants.profileScreen,
        title: LocaleKeys.profile,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icMoreDocument,
        routeName: RouteConstants.selectDocumentForScreen,
        title: LocaleKeys.document,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icFaq,
        routeName: RouteConstants.faqScreen,
        title: LocaleKeys.faq,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icEye,
        routeName: RouteConstants.howItWorksScreen,
        title: LocaleKeys.howItWorks,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icSustain,
        routeName: RouteConstants.sustainabilityScreen,
        title: LocaleKeys.sustainability,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icTaxTips,
        routeName: RouteConstants.taxTipsScreen,
        title: LocaleKeys.taxTips,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icSupport,
        routeName: RouteConstants.contactUsOptionScreen,
        title: LocaleKeys.support,
        trailingIcon: AssetConstants.icForward,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icLogout,
        routeName: RouteConstants.splashScreen,
        title: LocaleKeys.logout,
        trailingIcon: AssetConstants.icForward,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        "",
        showNotificationIcon: false,
        showBottomLine: false,
        backText: LocaleKeys.more.tr(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextComponent(
                      LocaleKeys.myAccount.tr(),
                      style: FontStyles.fontBold(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    TextComponent(user!.email!,
                        style: FontStyles.fontRegular(fontSize: 20),
                        overFlow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -15),
                child: const Padding(
                  padding: EdgeInsets.only(right: 15, top: 0),
                  child: LanguageDropdownComponent(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
                shrinkWrap: false,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  MoreOptions moreOptions = moreOptionsList[index];
                  return Column(
                    children: [
                      const Divider(
                        height: 1,
                        thickness: 0.8,
                      ),
                      InkWell(
                        onTap: () async {
                          if (moreOptions.routeName ==
                              RouteConstants.splashScreen) {
                            PopupLoader.showLoadingDialog(context);
                            await FirebaseAuth.instance.signOut();
                            PopupLoader.hideLoadingDialog(context);
                            Navigator.pushNamedAndRemoveUntil(context,
                                RouteConstants.splashScreen, (val) => false);
                          }
                          if (moreOptions.routeName ==
                              RouteConstants.selectDocumentForScreen) {
                            Navigator.pushNamed(context, moreOptions.routeName,
                                arguments: {"uploadBtn": true});
                          } else {
                            Navigator.pushNamed(context, moreOptions.routeName);
                          }
                        },
                        child: Consumer<LanguageProvider>(
                            builder: (context, consumer, child) {
                          return ListTile(
                            leading: Image.asset(
                              moreOptions.leadingIcon,
                              height: 20,
                              width: 20,
                              color: ColorConstants.toxicGreen,
                            ),
                            title: TextComponent(
                              moreOptions.title.tr(),
                              style: FontStyles.fontRegular(fontSize: 17),
                            ),
                            trailing:
                                SvgPicture.asset(moreOptions.trailingIcon),
                          );
                        }),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 0.8,
                      ),
                      if (index == 0) const SizedBox(height: 35),
                      if (index == 5) const SizedBox(height: 50),
                    ],
                  );
                },
                itemCount: 8),
          ),
        ],
      ),
    );
  }
}

class MoreOptions {
  final String title;
  final String routeName;
  final String leadingIcon;
  final String trailingIcon;

  MoreOptions(
      {required this.title,
      required this.routeName,
      required this.leadingIcon,
      required this.trailingIcon});
}
