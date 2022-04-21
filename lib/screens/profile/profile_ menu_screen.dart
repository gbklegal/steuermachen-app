import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/custom_appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/imprint_privacy_condition_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/auth/auth_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

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
        title: LocaleKeys.personalData,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icMoreDocument,
        // routeName: RouteConstants.selectDocumentForScreen,
        routeName: RouteConstants.orderOverviewScreen,
        title: LocaleKeys.orderOverview,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icFaq,
        // routeName: RouteConstants.faqScreen,
        routeName: RouteConstants.whatInWorkYearSelectionScreen,
        title: LocaleKeys.checkWhatInWorks,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icSupport,
        routeName: RouteConstants.contactUsOptionScreen,
        title: LocaleKeys.chatContact,
        trailingIcon: AssetConstants.icForward,
      ),
      ProfileMenuOptions(
        leadingIcon: AssetConstants.icSupport,
        routeName: RouteConstants.quickTaxScreen,
        title: LocaleKeys.quickCheckForYourRefund,
        trailingIcon: AssetConstants.icForward,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.bodyLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              const CustomAppBarComponent(
                backIconTitle: LocaleKeys.profile,
              ),
              const SizedBox(height: 25),
              for (var i = 0; i < profileMenuOptionsList.length; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                        color: ColorConstants.white,
                        boxShadow: [
                          BoxShadow(
                              color: ColorConstants.mediumGrey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: InkWell(
                      onTap: () async {
                        if (profileMenuOptionsList[i].routeName ==
                            RouteConstants.splashScreen) {
                          PopupLoader.showLoadingDialog(context);
                          await FirebaseAuth.instance.signOut();
                          PopupLoader.hideLoadingDialog(context);
                          Navigator.pushNamedAndRemoveUntil(context,
                              RouteConstants.splashScreen, (val) => false);
                        }
                        if (profileMenuOptionsList[i].routeName ==
                            RouteConstants.documentOverviewScreen) {
                          Navigator.pushNamed(
                              context, profileMenuOptionsList[i].routeName,
                              arguments: {"uploadBtn": true});
                        } else {
                          Navigator.pushNamed(
                              context, profileMenuOptionsList[i].routeName);
                        }
                      },
                      child: ListTile(
                        title: TextComponent(
                          profileMenuOptionsList[i].title,
                          style: FontStyles.fontMedium(fontSize: 15),
                        ),
                        trailing: SvgPicture.asset(
                          profileMenuOptionsList[i].trailingIcon,
                          height: 13,
                          width: 15,
                          color: ColorConstants.black.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                child: ButtonComponent(
                  buttonText: LocaleKeys.logout,
                  color: ColorConstants.primary,
                  onPressed: () async {
                    PopupLoader.showLoadingDialog(context);
                    await FirebaseAuth.instance.signOut();
                    PopupLoader.hideLoadingDialog(context);
                    Navigator.pushNamedAndRemoveUntil(
                        context, RouteConstants.splashScreen, (val) => false);
                  },
                ),
              ),
              SizedBox(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        showAlertDialog(context);
                      },
                      child: TextComponent(
                        LocaleKeys.deletingAnAccount,
                        style: FontStyles.fontMedium(fontSize: 15),
                      ),
                    ),
                    const ImprintPrivacyConditionsComponent(),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child:  Text(LocaleKeys.deleteAcc.tr()),
      onPressed: () async {
        AuthProvider _auth = Provider.of(context, listen: false);
        PopupLoader.showLoadingDialog(context);
        bool res = await _auth.deleteAccount();
        PopupLoader.hideLoadingDialog(context);
        Navigator.pop(context);
        if (res) {
          Navigator.pushNamedAndRemoveUntil(
              context, RouteConstants.splashScreen, (val) => false);
        } else {
          ToastComponent.showToast(LocaleKeys.somethingWentWrong.tr());
        }
      },
    );
    Widget cancelButton = TextButton(
      child: Text(LocaleKeys.abort.tr()),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      content: Text(LocaleKeys.deleteAccountMessage.tr()),
      actions: [
        cancelButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ProfileMenuOptions {
  final String title;
  final String routeName;
  final String? leadingIcon;
  final String trailingIcon;

  ProfileMenuOptions(
      {required this.title,
      required this.routeName,
      this.leadingIcon,
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
