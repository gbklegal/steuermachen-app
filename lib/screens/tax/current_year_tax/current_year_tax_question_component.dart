import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/payment/confirm_billing_component.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/current_year_view_wrapper.dart';

class CurrentYearTaxViewComponent extends StatefulWidget {
  const CurrentYearTaxViewComponent({
    Key? key,
    required this.currentYearTaxData,
  }) : super(key: key);
  final CurrentYearViewData currentYearTaxData;

  @override
  State<CurrentYearTaxViewComponent> createState() =>
      _CurrentYearTaxViewState();
}

class _CurrentYearTaxViewState extends State<CurrentYearTaxViewComponent> {
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
        _initialView(context),
        PaymentMethodsComponent(
          amount: widget.currentYearTaxData.price.toString(),
          decisionTap: () {
            Utils.animateToNextPage(pageController, pageIndex);
          },
        ),
        ConfirmBillingComponent(
          amount: "${widget.currentYearTaxData.price}0 euros",
          onTapOrder: () => Utils.animateToNextPage(pageController, pageIndex),
        ),
        Consumer<DeclarationTaxViewModel>(builder: (context, consumer, child) {
          return TermsAndConditionComponent(
            onPressedOrderNow: (value) async {
              await _submitData(consumer);
            },
          );
        })
      ],
    );
  }

  Column _initialView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          widget.currentYearTaxData.title,
          textAlign: TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          color: ColorConstants.black.withOpacity(0.49),
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.currentYearTaxData.subtitle,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorConstants.white),
                ),
              ),
              Text(
                widget.currentYearTaxData.price.toString() + "0 Euro",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.white),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        for (var i = 0; i < widget.currentYearTaxData.points.length; i++)
          _points(widget.currentYearTaxData.points[i]),
        const SizedBox(
          height: 80,
        ),
        ButtonComponent(
          buttonText: LocaleKeys.pay,
          onPressed: () {
            Utils.animateToNextPage(pageController, pageIndex);
          },
        )
      ],
    );
  }

  Padding _points(String points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2, right: 5),
            child: Icon(
              Icons.check_circle,
              size: 20,
              color: ColorConstants.toxicGreen,
            ),
          ),
          Flexible(
            child: Text(
              points,
              style: FontStyles.fontMedium(fontSize: 16, lineSpacing: 1.1),
            ),
          )
        ],
      ),
    );
  }

  _submitData(DeclarationTaxViewModel consumer) async {
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res = await consumer.submitDeclarationTaxData(context,
        isCurrentYear: true,
        taxPrice: widget.currentYearTaxData.price.toString());
    await consumer.fetchTaxFiledYears();
    PopupLoader.hideLoadingDialog(context);
    if (res.status!) {
      Utils.completedDialog(context);
    } else {
      ToastComponent.showToast(res.message!);
    }
  }
}
