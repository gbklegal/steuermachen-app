import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/imprint_privacy_condition_component.dart';
import 'package:steuermachen/components/radio_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class TermsAndConditionComponent extends StatefulWidget {
  const TermsAndConditionComponent(
      {Key? key, this.showCommissioning = false, this.onPressedOrderNow})
      : super(key: key);
  final bool showCommissioning;
  final void Function()? onPressedOrderNow;

  @override
  State<TermsAndConditionComponent> createState() =>
      _TermsAndConditionComponentState();
}

class _TermsAndConditionComponentState
    extends State<TermsAndConditionComponent> {
  bool? commissioningRadio;
  bool? termsAndConditionCheck;
  final List<_TermsAndContionChecksData> commissioning = [
    _TermsAndContionChecksData(
        title: LocaleKeys.commissioningRadioTitle1, isSelected: false),
    _TermsAndContionChecksData(
        title: LocaleKeys.commissioningRadioTitle2, isSelected: false),
  ];
  final List<_TermsAndContionChecksData> termsAndConditionChecks = [
    _TermsAndContionChecksData(
        title: LocaleKeys.termsAndConditionCheck1, isSelected: false),
    _TermsAndContionChecksData(
        title: LocaleKeys.termsAndConditionCheck2, isSelected: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: widget.showCommissioning,
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
              for (var i = 0; i < commissioning.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RadioComponent(
                    title: commissioning[i].title,
                    isSelected: commissioning[i].isSelected,
                    onTap: () {
                      for (var item in commissioning) {
                        item.isSelected = false;
                      }
                      setState(() {
                        commissioning[i].isSelected = true;
                      });
                    },
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
            for (var i = 0; i < termsAndConditionChecks.length; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _checkBox(context, termsAndConditionChecks[i].title,
                      termsAndConditionChecks[i].isSelected, (value) {
                    setState(() {
                      termsAndConditionChecks[i].isSelected =
                          !termsAndConditionChecks[i].isSelected;
                    });
                  }),
                  Visibility(
                    visible: i == 0,
                    child: Transform.translate(
                      offset: const Offset(0, -15),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                AssetConstants.trustShops,
                height: 50,
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.showCommissioning ? 50 : 100,
        ),
        SizedBox(
          height: 90,
          child: Column(
            children: [
              ButtonComponent(
                buttonText: "Order now",
                onPressed: widget.onPressedOrderNow,
              ),
              const ImprintPrivacyConditionsComponent(),
            ],
          ),
        )
      ],
    );
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
          child: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(checkBoxTitle,
                style: FontStyles.fontMedium(
                    fontSize: 16, letterSpacing: -0.3, lineSpacing: 1.1)),
          ),
        ),
      ],
    );
  }
}

class _TermsAndContionChecksData {
  late String title;
  late bool isSelected;
  _TermsAndContionChecksData({required this.title, required this.isSelected});
}
