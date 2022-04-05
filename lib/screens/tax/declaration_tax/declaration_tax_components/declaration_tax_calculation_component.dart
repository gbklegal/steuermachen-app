import 'package:flutter/material.dart';
import 'package:steuermachen/components/tax_calculate_screen.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class DeclarationTaxCalculationComponent extends StatelessWidget {
  const DeclarationTaxCalculationComponent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // final provider =
    //     Provider.of<DeclarationTaxProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TaxCalculatorComponent(
          routeName: RouteConstants.currentIncomeScreen,
        ),
        SizedBox(
          height: 24,
        ),
        PromoCodeComponent(),
      ],
    );
  }
}

class PromoCodeComponent extends StatelessWidget {
  const PromoCodeComponent({
    Key? key,
    this.onTapApplyNow,
  }) : super(key: key);
  final void Function()? onTapApplyNow;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent(
          LocaleKeys.promoCode,
          style: FontStyles.fontMedium(fontSize: 18),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 48,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: "",
              filled: false,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: ColorConstants.green,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: const BorderSide(
                  color: ColorConstants.green,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: onTapApplyNow,
          child: TextComponent(
            LocaleKeys.applyNow,
            style: FontStyles.fontMedium(
                fontSize: 17,
                underLine: true,
                color: ColorConstants.toxicGreen),
          ),
        ),
      ],
    );
  }
}
