import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CompletedDialogComponent extends StatelessWidget {
  const CompletedDialogComponent({
    Key? key,
    this.showBackBtn = false,
    this.title,
    this.text,
    this.showChatBtn = false,
  }) : super(key: key);
  final bool? showBackBtn;
  final bool showChatBtn;
  final String? title, text;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      content: Container(
        color: ColorConstants.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AssetConstants.done,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 25),
            TextComponent(
              title ?? LocaleKeys.thankYou,
              style: FontStyles.fontMedium(fontSize: 15),
            ),
            const SizedBox(height: 15),
            TextComponent(
              text ?? LocaleKeys.emailReceive,
              textAlign: TextAlign.center,
              style: FontStyles.fontRegular(fontSize: 14),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Flexible(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorConstants.black),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: ButtonComponent(
                      btnHeight: 48,
                      color: ColorConstants.white,
                      buttonText: showChatBtn
                          ? LocaleKeys.chat
                          : LocaleKeys.uploadReceipts,
                      textStyle: FontStyles.fontMedium(
                          fontSize: 14, color: ColorConstants.black),
                      onPressed: () {
                        if (showChatBtn) {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteConstants.bottomNavBarScreen,
                              (val) => false);
                          Navigator.pushNamed(
                              context, RouteConstants.chatScreen);
                        } else {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteConstants.bottomNavBarScreen,
                              (val) => false);
                          Navigator.pushNamed(
                              context, RouteConstants.documentOverviewScreen);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: ButtonComponent(
                    btnHeight: 48,
                    buttonText: LocaleKeys.goToProfile,
                    textStyle: FontStyles.fontMedium(
                        fontSize: 13, color: ColorConstants.white),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          RouteConstants.bottomNavBarScreen, (val) => false);
                    },
                  ),
                ),
                showBackBtn!
                    ? Flexible(
                        child: ButtonComponent(
                          btnHeight: 48,
                          buttonText: LocaleKeys.back,
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstants.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      )
                    // ignore: dead_code
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
