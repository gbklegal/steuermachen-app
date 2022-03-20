import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/payment/confirm_billing_component.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/signature_component.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/signature/signature_provider.dart';
import 'package:steuermachen/providers/tax/declaration_tax/declaration_tax_provider.dart';
import 'package:steuermachen/screens/tax/declaration_tax/declaration_tax_components/declaration_tax_calculation_component.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_view_wrapper.dart';

class DeclarationQuestionsViewComponent extends StatefulWidget {
  const DeclarationQuestionsViewComponent({
    Key? key,
    required this.declarationTaxData,
  }) : super(key: key);
  final List<DeclarationTaxViewData> declarationTaxData;

  @override
  State<DeclarationQuestionsViewComponent> createState() =>
      _DeclarationQuestionsViewComponentState();
}

class _DeclarationQuestionsViewComponentState
    extends State<DeclarationQuestionsViewComponent> {
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
              Visibility(
                visible: widget.declarationTaxData[i].title != "",
                child: Text(
                  widget.declarationTaxData[i].title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Consumer<DeclarationTaxProvider>(
                      builder: (context, consumer, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        children: [
                          if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.singleSelect)
                            for (var x = 0;
                                x < widget.declarationTaxData[i].options.length;
                                x++)
                              _optionsWidget(consumer, i, x)
                          else if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.grossIncome)
                            const DeclarationTaxCalculationComponent()
                          else if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.userForm)
                            const UserFormComponent()
                          else if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.signature)
                            const SignatureComponent()
                          else if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.paymentMethods)
                            PaymentMethodsComponent(
                              decisionTap: () {
                                Utils.animateToNextPage(pageController, i);
                              },
                            )
                          else if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.confirmBilling)
                            ConfirmBillingComponent(
                              onTapOrder: () =>
                                  Utils.animateToNextPage(pageController, i),
                            )
                          else if (widget.declarationTaxData[i].optionType ==
                              OptionConstants.termsCondition)
                            TermsAndConditionComponent(
                              onPressedOrderNow: (value) async {
                                await _submitData(consumer);
                              },
                            )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              if (widget.declarationTaxData[i].showBottomNav) _bottomBtns(i)
            ],
          ),
      ],
    );
  }

  Padding _bottomBtns(int i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: BackResetForwardBtnComponent(
        showContinueBtn: widget.declarationTaxData[i].optionType !=
            OptionConstants.singleSelect,
        onTapBack: () {
          Utils.animateToPreviousPage(pageController, i);
        },
        onTapContinue: () async {
          if (widget.declarationTaxData[i].optionType ==
              OptionConstants.userForm) {
            bool status = await Utils.submitProfile(context);
            if (status) {
              Utils.animateToNextPage(pageController, i);
            }
          }
          if (widget.declarationTaxData[i].optionType ==
              OptionConstants.signature) {
            bool status =
                await Provider.of<SignatureProvider>(context, listen: false)
                    .checkSignatureIsPresent();
            if (status) {
              Utils.animateToNextPage(pageController, i);
            }
          }
          //Pending for promo code
          // if (widget.declarationTaxData[i].optionType ==
          //     OptionConstants.grossIncome) {
          //   bool status =
          //       await Provider.of<TaxCalculatorProvider>(context, listen: false);
          //   if (status) {
          //     Utils.animateToNextPage(pageController, i);
          //   }
          // }
          else {
            Utils.animateToNextPage(pageController, i);
          }
        },
      ),
    );
  }

  SelectionCardComponent _optionsWidget(
      DeclarationTaxProvider consumer, int i, int x) {
    return SelectionCardComponent(
      title: widget.declarationTaxData[i].options[x],
      imagePath: widget.declarationTaxData[i].optionImgPath.isNotEmpty
          ? widget.declarationTaxData[i].optionImgPath[x]
          : null,
      onTap: () {
        int year = DateTime.now().year;
        if (year.toString() == widget.declarationTaxData[i].options[x]) {
          Navigator.pushNamed(context, RouteConstants.currentYearTaxScreen);
        } else {
          if (i == 0) {
            consumer.setTaxYear(widget.declarationTaxData[i].options[x]);
          } else if (i == 1) {
            consumer.setMartialStatus(widget.declarationTaxData[i].options[x]);
          }
          Utils.animateToNextPage(pageController, i);
        }
      },
    );
  }

  _submitData(DeclarationTaxProvider consumer) async {
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res =
        await consumer.submitDeclarationTaxData(context);
    PopupLoader.hideLoadingDialog(context);
    if (res.status!) {
      Utils.completedDialog(context);
    } else {
      ToastComponent.showToast(res.message!);
    }
  }
}
