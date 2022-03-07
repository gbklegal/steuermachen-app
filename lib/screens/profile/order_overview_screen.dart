import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class OrderOverviewScreen extends StatelessWidget {
  const OrderOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: SvgPicture.asset(
                    AssetConstants.icCross,
                    color: ColorConstants.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                AssetConstants.exclamation,
                height: 120,
              ),
              const SizedBox(
                height: 20,
              ),
              TextComponent(
                LocaleKeys.youHaveNoOrderSomething,
                style: FontStyles.fontMedium(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const ButtonComponent(
                buttonText: LocaleKeys.orderNow,
                color: ColorConstants.toxicGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
