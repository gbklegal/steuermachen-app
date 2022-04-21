import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/imprint_privacy_condition_component.dart';
import 'package:steuermachen/components/radio_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/terms_and_condition_provider.dart';

class TermsAndConditionComponent extends StatelessWidget {
  const TermsAndConditionComponent(
      {Key? key, this.showCommissioning = false, this.onPressedOrderNow})
      : super(key: key);
  final bool showCommissioning;
  final void Function(bool value)? onPressedOrderNow;

  @override
  Widget build(BuildContext context) {
    final TermsAndConditionProvider provider =
        Provider.of<TermsAndConditionProvider>(context, listen: false);
    for (var e in provider.termsAndConditionChecks) {
      e.isSelected = false;
    }
    return Consumer<TermsAndConditionProvider>(
        builder: (context, consumer, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: showCommissioning
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Visibility(
            visible: showCommissioning,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextComponent(
                  LocaleKeys.commissioning,
                  textAlign: TextAlign.left,
                  style: FontStyles.fontMedium(
                      fontSize: 20, letterSpacing: -0.3, lineSpacing: 1.1),
                ),
                const SizedBox(
                  height: 20,
                ),
                for (var i = 0; i < consumer.commissioning.length; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: RadioComponent(
                      title: consumer.commissioning[i].title,
                      isSelected: consumer.commissioning[i].isSelected,
                      onTap: () => consumer.changeCommissionCheckState(i),
                    ),
                  ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextComponent(LocaleKeys.termsAndConditionNote,
                  textAlign: TextAlign.left,
                  style: FontStyles.fontMedium(
                      fontSize: 16, letterSpacing: -0.3, lineSpacing: 1.1)),
              const SizedBox(
                height: 10,
              ),
              for (var i = 0; i < consumer.termsAndConditionChecks.length; i++)
                Transform.translate(
                  offset: const Offset(-14, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: Offset(
                            0,
                            consumer.termsAndConditionChecks.length - 1 == i
                                ? -10
                                : 0),
                        child: _checkBox(
                            context,
                            consumer.termsAndConditionChecks[i].title,
                            consumer.termsAndConditionChecks[i].isSelected,
                            (va) => consumer
                                .changeTermsAndConditionCheckedState(i)),
                      ),
                      Visibility(
                        visible: i == 0,
                        child: Transform.translate(
                          offset: const Offset(-6, -22),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60),
                            child: TextComponent(
                              LocaleKeys.termsAndConditionCheckNonDisclosure,
                              style: FontStyles.fontMedium(
                                  fontSize: 15, color: ColorConstants.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Transform.translate(
                offset: const Offset(-10, 0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    AssetConstants.trustShops,
                    height: 50,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: showCommissioning ? 50 : 100,
          ),
          SizedBox(
            height: 90,
            child: Column(
              children: [
                ButtonComponent(
                    buttonText: LocaleKeys.orderNow.tr(),
                    color: ColorConstants.toxicGreen,
                    onPressed: () {
                      if (consumer.validateChecks(showCommissioning)) {
                        onPressedOrderNow!(true);
                      }
                    }),
                const ImprintPrivacyConditionsComponent(),
              ],
            ),
          )
        ],
      );
    });
  }

  Row _checkBox(BuildContext context, String checkBoxTitle, bool isSelected,
      void Function(bool?)? onChanged) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: isSelected,
          onChanged: onChanged,
        ),
        const SizedBox(
          width: 2,
        ),
        Flexible(
          child: Transform.translate(
            offset: const Offset(-5, 0),
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextComponent(checkBoxTitle,
                  style: FontStyles.fontMedium(
                      fontSize: 16, letterSpacing: -0.3, lineSpacing: 1.1)),
            ),
          ),
        ),
      ],
    );
  }
}
