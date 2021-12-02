import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  List<MoreOptions> moreOptionsList = [];
  @override
  void initState() {
    super.initState();
    moreOptionsList = [
      MoreOptions(
        leadingIcon: AssetConstants.icProfile,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.profile,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icMoreDocument,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.document,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icFaq,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.faq,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icEye,
        routeName: RouteConstants.howItWorksScreen,
        title: StringConstants.howDoesWork,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icSustain,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.sustain,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icFaxTips,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.taxTip,
        trailingIcon: AssetConstants.removePic,
    ),
      MoreOptions(
        leadingIcon: AssetConstants.icSupport,
        routeName: RouteConstants.contactUsOptionScreen,
        title: StringConstants.support,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.icLogout,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.logout,
        trailingIcon: AssetConstants.removePic,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  StringConstants.myAccount,
                  style: FontStyles.fontBold(fontSize: 20),
                ),
                const SizedBox(height: 8),
                TextComponent(
                  "osama.asif20@gmail.com",
                  style: FontStyles.fontRegular(fontSize: 20),
                ),
              ],
            ),
          ),
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
                        onTap: () {
                          Navigator.pushNamed(context, moreOptions.routeName);
                        },
                        child: ListTile(
                          leading: Image.asset(moreOptions.leadingIcon),
                          title: TextComponent(
                            moreOptions.title,
                            style: FontStyles.fontRegular(fontSize: 20),
                          ),
                          trailing: SvgPicture.asset(moreOptions.trailingIcon),
                        ),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 0.8,
                      ),
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
