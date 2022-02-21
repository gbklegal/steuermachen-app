import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class AppBarWithSideCornerCircleAndRoundBody extends StatelessWidget {
  const AppBarWithSideCornerCircleAndRoundBody({
    Key? key,
    required this.body,
    this.showNotificationIcon = false,
  }) : super(key: key);
  final Widget body;
  final bool? showNotificationIcon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarComponent(
        "",
        // LocaleKeys.appName.tr(),
        // imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBottomLine: false,
        showPersonIcon: showNotificationIcon,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(AssetConstants.topRightRoundCircle),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorConstants.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: ColorConstants.black.withOpacity(0.05),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                child: body,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
