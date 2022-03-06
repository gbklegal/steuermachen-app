import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/signature_component.dart';
import 'package:steuermachen/components/tax_calculate_screen.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
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
import 'package:steuermachen/providers/tax/finance_court/finance_court_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax_view_wrapper.dart';
import 'package:steuermachen/wrappers/finance_court_view_wrapper.dart';

class FinanceCourtScreen extends StatefulWidget {
  const FinanceCourtScreen({Key? key}) : super(key: key);

  @override
  _FinanceCourtScreenState createState() => _FinanceCourtScreenState();
}

class _FinanceCourtScreenState extends State<FinanceCourtScreen> {
  late FinanceCourtProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<FinanceCourtProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        provider.getFinanceCourtViewData().then((value) => response = value));
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
        backText: "",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child:
            Consumer<FinanceCourtProvider>(builder: (context, consumer, child) {
          if (consumer.getBusyStateFinanceCourt || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                consumer.setBusyStateFinanceCourt = true;
                await provider
                    .getFinanceCourtViewData()
                    .then((value) => response = value);
                consumer.setBusyStateFinanceCourt = false;
              },
            );
          } else {
            FinanceCourtViewWrapper financeCourtViewWrapper =
                response!.data as FinanceCourtViewWrapper;
            if (context.locale == const Locale('en')) {
              return _QuestionsView(
                financeCourtViewData: financeCourtViewWrapper.en,
              );
            } else {
              return _QuestionsView(
                financeCourtViewData: financeCourtViewWrapper.du,
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
    required this.financeCourtViewData,
  }) : super(key: key);
  final List<FinanceCourtViewData> financeCourtViewData;

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
        for (var i = 0; i < widget.financeCourtViewData.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextProgressBarComponent(
                title:
                    "${LocaleKeys.step.tr()} ${i + 1}/${widget.financeCourtViewData.length}",
                progress: (i + 1) / widget.financeCourtViewData.length,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.financeCourtViewData[i].title,
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
                        if (widget.financeCourtViewData[i].optionType ==
                            OptionConstants.userForm)
                          const UserFormComponent()
                        else if (widget.financeCourtViewData[i].optionType ==
                            OptionConstants.subjectTaxLaw)
                          const _TaxCalculator()
                        else if (widget.financeCourtViewData[i].optionType ==
                            OptionConstants.signature)
                          const SignatureComponent()
                        else if (widget.financeCourtViewData[i].optionType ==
                            OptionConstants.termsCondition)
                          const TermsAndConditionComponent()
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.financeCourtViewData[i].showBottomNav)
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
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
        pageController.animateToPage(i + 1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInToLinear);
      },
      child: SelectionCardComponent(
        title: widget.financeCourtViewData[i].options[x],
        imagePath: widget.financeCourtViewData[i].optionImgPath.isNotEmpty
            ? widget.financeCourtViewData[i].optionImgPath[x]
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
