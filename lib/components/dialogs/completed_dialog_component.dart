
import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CompletedDialogComponent extends StatelessWidget {
  const CompletedDialogComponent({
    Key? key,
    this.showBackBtn = false,
  }) : super(key: key);
  final bool? showBackBtn;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.start,
      content: Container(
        color: ColorConstants.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AssetConstants.done),
            const SizedBox(height: 10),
            const TextComponent(LocaleKeys.thankYou),
            const TextComponent(LocaleKeys.weWillBeInTouchShortly),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4, top: 10),
                    child: ButtonComponent(
                      btnHeight: 55,
                      buttonText: LocaleKeys.goToHome,
                      textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: ColorConstants.white),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            RouteConstants.bottomNavBarScreen, (val) => false);
                      },
                    ),
                  ),
                ),
                showBackBtn!
                    ? Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4, top: 10),
                          child: ButtonComponent(
                            btnHeight: 55,
                            buttonText: LocaleKeys.back,
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: ColorConstants.white),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
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
