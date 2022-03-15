import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/imprint_privacy_condition_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Visibility(
          visible: widget.showCommissioning,
          child: const _CommissioningComponent(),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent(
                "Note: Release from confidentiality is urgently required for communication between steuermachen (GDF) and the commissioned tax office.",
                textAlign: TextAlign.left,
                style: FontStyles.fontMedium(
                    fontSize: 16, letterSpacing: -0.3, lineSpacing: 1.1)),
            const SizedBox(
              height: 10,
            ),
            _checkBox(context, "* I agree to the release from "),
            Transform.translate(
              offset: const Offset(0, -15),
              child: Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Text(
                  "non-disclosure ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      letterSpacing: -0.3,
                      color: ColorConstants.primary),
                ),
              ),
            ),
            _checkBox(context,
                "* I accept the terms and conditions and the information on data processing and the right of withdrawal from steuermachen."),
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

  Row _checkBox(BuildContext context, String checkBoxTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: false,
          onChanged: (bool? value) {},
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

class _CommissioningComponent extends StatelessWidget {
  const _CommissioningComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          "Commissioning *",
          textAlign: TextAlign.left,
          style: FontStyles.fontMedium(
              fontSize: 20, letterSpacing: -0.3, lineSpacing: 1.1),
        ),
        const SizedBox(
          height: 20,
        ),
        _radios(),
        const SizedBox(
          height: 18,
        ),
        _radios(),
        const SizedBox(
          height: 18,
        ),
      ],
    );
  }

  Container _radios() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(18),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 0.7,
                  )),
              padding: const EdgeInsets.all(2),
              child: Container(
                height: 12,
                width: 12,
                decoration: const BoxDecoration(
                  color: ColorConstants.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: TextComponent(
                    "Legal protection insurance is available, please carry out a cover request",
                    textAlign: TextAlign.left,
                    style: FontStyles.fontMedium(
                        fontSize: 16, letterSpacing: 0.3, lineSpacing: 1.1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
