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
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.onlineShop,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.document,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.faq,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.howDoesWork,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.sustain,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.taxTip,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.support,
        trailingIcon: AssetConstants.removePic,
      ),
      MoreOptions(
        leadingIcon: AssetConstants.removePic,
        routeName: RouteConstants.currentIncomeScreen,
        title: StringConstants.logout,
        trailingIcon: AssetConstants.removePic,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: false,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          MoreOptions moreOptions = moreOptionsList[index];
          return ListTile(
            leading: SvgPicture.asset(moreOptions.leadingIcon),
            title: TextComponent(
              moreOptions.title,
              style: FontStyles.fontRegular(fontSize: 20),
            ),
            trailing: SvgPicture.asset(moreOptions.trailingIcon),
          );
        },
        separatorBuilder: (context, index) {
          if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Divider(),
            );
          } else if (index == 6) {
            return Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Divider(),
            );
          } else {
            return Divider();
          }
        },
        itemCount: 8);
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
