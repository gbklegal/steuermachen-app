import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/payment/confirm_billing_component.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/tax/easy_tax/easy_tax_provider.dart';
import 'package:steuermachen/screens/tax/easy_tax/easy_tax_component/initial_easy_tax_component.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_wrapper.dart';

class EasyTaxQuestionsViewComponent extends StatefulWidget {
  const EasyTaxQuestionsViewComponent({
    Key? key,
    required this.easyTaxData,
  }) : super(key: key);
  final List<EasyTaxData> easyTaxData;

  @override
  State<EasyTaxQuestionsViewComponent> createState() =>
      _EasyTaxQuestionsViewComponentState();
}

class _EasyTaxQuestionsViewComponentState
    extends State<EasyTaxQuestionsViewComponent> {
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
        for (var i = 0; i < widget.easyTaxData.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextProgressBarComponent(
                title:
                    "${LocaleKeys.step.tr()} ${i + 1}/${widget.easyTaxData.length}",
                progress: (i + 1) / widget.easyTaxData.length,
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: widget.easyTaxData[i].title != "",
                child: Text(
                  widget.easyTaxData[i].title,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
              Expanded(
                child: Consumer<EasyTaxProvider>(
                    builder: (context, consumer, child) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        children: [
                          if (widget.easyTaxData[i].optionType ==
                              OptionConstants.initialScreen)
                            InitialEasyTaxComponent(
                              data: widget.easyTaxData[i].content!,
                              onPressed: (val) {
                                consumer.setSubscriptionPrice(val);
                                Utils.animateToNextPage(pageController, i);
                              },
                            )
                          else if (widget.easyTaxData[i].optionType ==
                              OptionConstants.userForm)
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: UserFormComponent(),
                            )
                          else if (widget.easyTaxData[i].optionType ==
                              OptionConstants.paymentMethods)
                            PaymentMethodsComponent(
                              amount: widget.easyTaxData[0].content!.price,
                              decisionTap: () {
                                Utils.animateToNextPage(pageController, i);
                              },
                            )
                          else if (widget.easyTaxData[i].optionType ==
                              OptionConstants.confirmBilling)
                            ConfirmBillingComponent(
                              amount:
                                  "${widget.easyTaxData[0].content!.price.toString()} ${widget.easyTaxData[0].content!.currencySymbol}",
                              onTapOrder: () =>
                                  Utils.animateToNextPage(pageController, i),
                            )
                          else if (widget.easyTaxData[i].optionType ==
                              OptionConstants.termsCondition)
                            TermsAndConditionComponent(
                              onPressedOrderNow: (value) async {
                                await _submitData(consumer);
                              },
                            )
                        ],
                      ),
                    ),
                  );
                }),
              ),
              if (widget.easyTaxData[i].showBottomNav)
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: BackResetForwardBtnComponent(
                    onTapBack: () {
                      Utils.animateToPreviousPage(pageController, i);
                    },
                    onTapReset: () => Utils.animateToPreviousPage(
                        pageController,
                        widget.easyTaxData.length - widget.easyTaxData.length),
                    onTapContinue: () => _onTapContinue(i),
                  ),
                )
            ],
          ),
      ],
    );
  }

  _onTapContinue(int i) async {
    if (widget.easyTaxData[i].optionType == OptionConstants.userForm) {
      bool status = await Utils.submitProfile(context);
      if (status) {
        Utils.animateToNextPage(pageController, i);
      }
    } else {
      Utils.animateToNextPage(pageController, i);
    }
  }

  _submitData(EasyTaxProvider consumer) async {
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res = await consumer.submitEasyTaxData(context);
    PopupLoader.hideLoadingDialog(context);
    if (res.status!) {
      Utils.completedDialog(context);
    } else {
      ToastComponent.showToast(res.message!);
    }
  }
}
