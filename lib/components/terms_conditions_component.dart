import 'package:flutter/material.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/imprint_privacy_condition_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class TermsAndConditionComponent extends StatelessWidget {
  const TermsAndConditionComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Note: Release from confidentiality is urgently required for communication between steuermachen (GDF) and the commissioned tax office.",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    letterSpacing: -0.3),
              ),
              const SizedBox(
                height: 15,
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
        ),
        SizedBox(
          height: 90,
          child: Column(
            children: [
              ButtonComponent(
                buttonText: "Order now".toUpperCase(),
                color: ColorConstants.toxicGreen,
                onPressed: () {},
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
            child: Text(
              checkBoxTitle,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  letterSpacing: -0.3),
            ),
          ),
        ),
      ],
    );
  }
}