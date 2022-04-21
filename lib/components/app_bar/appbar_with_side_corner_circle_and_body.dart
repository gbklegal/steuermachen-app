import 'package:flutter/material.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';

class AppBarWithSideCornerCircleAndRoundBody extends StatelessWidget {
  const AppBarWithSideCornerCircleAndRoundBody({
    Key? key,
    required this.body,
    this.showNotificationIcon = false,
    this.showCircle = false,
    this.showBackButton = true,
    this.overrideBackPressed,
  }) : super(key: key);
  final Widget body;
  final bool? showNotificationIcon;
  final bool showCircle;
  final bool? showBackButton;
  final dynamic Function()? overrideBackPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBottomLine: false,
        showPersonIcon: showNotificationIcon,
        showBackButton: showBackButton,
        overrideBackPressed: overrideBackPressed,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: ColorConstants.black.withOpacity(0.1),
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
    );
  }
}
