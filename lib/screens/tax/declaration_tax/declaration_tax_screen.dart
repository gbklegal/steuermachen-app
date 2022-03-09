import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/tax_calculate_screen.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/tax/declaration_tax/declaration_tax_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax_view_wrapper.dart';

class DeclarationTaxScreen extends StatefulWidget {
  const DeclarationTaxScreen({Key? key}) : super(key: key);

  @override
  _DeclarationTaxScreenState createState() => _DeclarationTaxScreenState();
}

class _DeclarationTaxScreenState extends State<DeclarationTaxScreen> {
  late DeclarationTaxProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<DeclarationTaxProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        provider.getDeclarationTaxViewData().then((value) => response = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.appName,
        imageTitle: AssetConstants.logo,
        backgroundColor: Colors.transparent,
        showBackButton: true,
        showPersonIcon: false,
        showBottomLine: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Consumer<DeclarationTaxProvider>(
            builder: (context, consumer, child) {
          if (consumer.getBusyStateDeclarationTax || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                consumer.setBusyStateDeclarationTax = true;
                await provider
                    .getDeclarationTaxViewData()
                    .then((value) => response = value);
                consumer.setBusyStateDeclarationTax = false;
              },
            );
          } else {
            DeclarationTaxViewWrapper declarationTaxViewWrapper =
                response!.data as DeclarationTaxViewWrapper;
            if (context.locale == const Locale('en')) {
              return _QuestionsView(
                declarationTaxData: declarationTaxViewWrapper.en,
              );
            } else {
              return _QuestionsView(
                declarationTaxData: declarationTaxViewWrapper.du,
              );
            }
          }
        }),
      ),
    );
  }
}

class _QuestionsView extends StatefulWidget {
  const _QuestionsView({
    Key? key,
    required this.declarationTaxData,
  }) : super(key: key);
  final List<DeclarationTaxViewData> declarationTaxData;

  @override
  State<_QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<_QuestionsView> {
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
                          const _TaxCalculator()
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
                      pageController.animateToPage(i - 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOutBack);
                    },
                    onTapContinue: () {
                      pageController.animateToPage(i + 1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInToLinear);
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
          pageController.animateToPage(i + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInToLinear);
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

class _TaxCalculator extends StatelessWidget {
  const _TaxCalculator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TaxCalculatorComponent(
          routeName: RouteConstants.currentIncomeScreen,
        ),
        const SizedBox(
          height: 24,
        ),
        TextComponent(
          LocaleKeys.promoCode.tr(),
          style: FontStyles.fontMedium(fontSize: 18),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
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
        const SizedBox(height: 12),
        TextComponent(
          LocaleKeys.applyNow.tr(),
          style: FontStyles.fontMedium(
              fontSize: 17, underLine: true, color: ColorConstants.toxicGreen),
        ),
      ],
    );
  }
}
