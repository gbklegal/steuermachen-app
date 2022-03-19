
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/screens/tax/declaration_tax/declaration_tax_components/declaration_tax_calculation_component.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/declaration_tax_view_wrapper.dart';

class DeclarationQuestionsViewComponent extends StatefulWidget {
  const DeclarationQuestionsViewComponent({
    Key? key,
    required this.declarationTaxData,
  }) : super(key: key);
  final List<DeclarationTaxViewData> declarationTaxData;

  @override
  State<DeclarationQuestionsViewComponent> createState() => _DeclarationQuestionsViewComponentState();
}

class _DeclarationQuestionsViewComponentState extends State<DeclarationQuestionsViewComponent> {
  final pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      children: [
        for (var i = 0; i < widget.declarationTaxData.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextProgressBarComponent(
                title:
                    "${LocaleKeys.step.tr()} ${i + 1}/${widget.declarationTaxData.length}",
                progress: (i + 1) / widget.declarationTaxData.length,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.declarationTaxData[i].title,
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: [
                        if (widget.declarationTaxData[i].optionType ==
                            OptionConstants.singleSelect)
                          for (var x = 0;
                              x < widget.declarationTaxData[i].options.length;
                              x++)
                            _optionsWidget(i, x)
                        else if (widget.declarationTaxData[i].optionType ==
                            OptionConstants.grossIncome)
                          const DeclarationTaxCalculationComponent()
                        else if (widget.declarationTaxData[i].optionType ==
                            OptionConstants.userForm)
                          const UserFormComponent()
                        else if (widget.declarationTaxData[i].optionType ==
                            OptionConstants.paymentMethods)
                          const PaymentMethodsComponent()
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.declarationTaxData[i].showBottomNav)
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: BackResetForwardBtnComponent(
                    onTapBack: () {
                         Utils.animateToPreviousPage(pageController, i);
                    },
                    onTapContinue: () {
                        Utils.animateToNextPage(pageController, i);
                    },
                  ),
                )
            ],
          ),
      ],
    );
  }

  InkWell _optionsWidget(int i, int x) {
    return InkWell(
      onTap: () {
        int year = DateTime.now().year;
        if (year.toString() == widget.declarationTaxData[i].options[x]) {
          Navigator.pushNamed(context, RouteConstants.currentYearTaxScreen);
        } else {
           Utils.animateToNextPage(pageController, i);
        }
      },
      child: SelectionCardComponent(
        title: widget.declarationTaxData[i].options[x],
        imagePath: widget.declarationTaxData[i].optionImgPath.isNotEmpty
            ? widget.declarationTaxData[i].optionImgPath[x]
            : null,
      ),
    );
  }
}
