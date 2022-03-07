import 'package:easy_localization/src/public_ext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/app_bar/custom_appbar_component.dart';
import 'package:steuermachen/components/language_dropdown_component.dart';
import 'package:steuermachen/components/logo_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/language_provider.dart';

class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  List<ProfileMenuOptions> profileMenuOptionsList = [];
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    profileMenuOptionsList = [
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icProfile,
        routeName: RouteConstants.profileScreen,
        title: LocaleKeys.profile,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icMoreDocument,
        routeName: RouteConstants.selectDocumentForScreen,
        title: LocaleKeys.document,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icFaq,
        routeName: RouteConstants.faqScreen,
        title: LocaleKeys.faq,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icEye,
        routeName: RouteConstants.howItWorksScreen,
        title: LocaleKeys.howItWorks,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icSustain,
        routeName: RouteConstants.sustainabilityScreen,
        title: LocaleKeys.sustainability,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icTaxTips,
        routeName: RouteConstants.taxTipsScreen,
        title: LocaleKeys.taxTips,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icSupport,
        routeName: RouteConstants.contactUsOptionScreen,
        title: LocaleKeys.support,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icLogout,
        routeName: RouteConstants.splashScreen,
        title: LocaleKeys.logout,
        trailingIcon: AssetConstants.icForward,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(builder: (context, consumer, child) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const CustomAppBarComponent(
                backIconTitle: LocaleKeys.profile,
              ),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ProfileMenuOptions moreOptions = profileMenuOptionsList[index];
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
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RouteConstants.splashScreen,
                                    (val) => false);
                              }
                              if (moreOptions.routeName ==
                                  RouteConstants.selectDocumentForScreen) {
                                Navigator.pushNamed(
                                    context, moreOptions.routeName,
                                    arguments: {"uploadBtn": true});
                              } else {
                                Navigator.pushNamed(
                                    context, moreOptions.routeName);
                              }
                            },
                            child: ListTile(
                              // leading: Image.asset(
                              //   moreOptions.leadingIcon,
                              //   height: 20,
                              //   width: 20,
                              //   color: ColorConstants.toxicGreen,
                              // ),
                              title: TextComponent(
                                moreOptions.title.tr(),
                                style: FontStyles.fontRegular(fontSize: 17),
                              ),
                              trailing:
                                  SvgPicture.asset(moreOptions.trailingIcon),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: 8),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class ProfileMenuOptions {
  final String title;
  final String routeName;
  final String leadingIcon;
  final String trailingIcon;

  ProfileMenuOptions(
      {required this.title,
      required this.routeName,
      required this.leadingIcon,
      required this.trailingIcon});
}


//  if (moreOptions.routeName ==
//                                   RouteConstants.splashScreen) {
//                                 PopupLoader.showLoadingDialog(context);
//                                 await FirebaseAuth.instance.signOut();
//                                 PopupLoader.hideLoadingDialog(context);
//                                 Navigator.pushNamedAndRemoveUntil(
//                                     context,
//                                     RouteConstants.splashScreen,
//                                     (val) => false);
//                               }
//                               if (moreOptions.routeName ==
//                                   RouteConstants.selectDocumentForScreen) {
//                                 Navigator.pushNamed(
//                                     context, moreOptions.routeName,
//                                     arguments: {"uploadBtn": true});
//                               } else {
//                                 Navigator.pushNamed(
//                                     context, moreOptions.routeName);
//                               }