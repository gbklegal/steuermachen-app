import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/signature_component.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/data/view_models/tax/finance_court/finance_court_provider.dart';
import 'package:steuermachen/screens/tax/finance_court/finance_law/finance_law_component.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_court_view_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';
import 'package:collection/collection.dart';

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
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => provider.getFinanceCourtViewData().then(
        (value) {
          setState(
            () {
              response = value;
            },
          );
        },
      ),
    );
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (provider.getBusyStateFinanceCourt || response == null)
                const EmptyScreenLoaderComponent()
              else if (!response!.status!)
                ErrorComponent(
                  message: response!.message!,
                  onTap: () async {
                    await provider
                        .getFinanceCourtViewData()
                        .then((value) => response = value);
                  },
                )
              else
                _getMainBody()
            ],
          )),
    );
  }

  Flexible _getMainBody() {
    FinanceCourtViewWrapper financeCourtViewWrapper =
        response!.data as FinanceCourtViewWrapper;
    if (context.locale == const Locale('en')) {
      return Flexible(
        child: _QuestionsView(
          financeCourtViewData: financeCourtViewWrapper.en,
        ),
      );
    } else {
      return Flexible(
        child: _QuestionsView(
          financeCourtViewData: financeCourtViewWrapper.du,
        ),
      );
    }
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
  late FinanceCourtProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<FinanceCourtProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        provider.getFinanceLawViewData().then((value) => response = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FinanceCourtProvider>(builder: (context, consumer, child) {
      if (consumer.getBusyStateFinanceLaw || response == null) {
        return const EmptyScreenLoaderComponent();
      } else if (!response!.status!) {
        return ErrorComponent(
          message: response!.message!,
          onTap: () async {
            await provider
                .getFinanceLawViewData()
                .then((value) => response = value);
          },
        );
      } else {
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
                  Visibility(
                    visible: widget.financeCourtViewData[i].title != "",
                    child: Text(
                      widget.financeCourtViewData[i].title,
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
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Column(
                          children: [
                            if (widget.financeCourtViewData[i].optionType ==
                                OptionConstants.userForm)
                              const UserFormComponent()
                            else if (widget
                                    .financeCourtViewData[i].optionType ==
                                OptionConstants.subjectTaxLaw)
                              Transform.translate(
                                offset: const Offset(0, -20),
                                child: const FinanceLawComponent(),
                              )
                            else if (widget
                                    .financeCourtViewData[i].optionType ==
                                OptionConstants.signature)
                              const SignatureComponent()
                            else if (widget
                                    .financeCourtViewData[i].optionType ==
                                OptionConstants.termsCondition)
                              TermsAndConditionComponent(
                                showCommissioning: true,
                                onPressedOrderNow: (value) async {
                                  PopupLoader.showLoadingDialog(context);
                                  CommonResponseWrapper res = await consumer
                                      .submitFinanceCourtData(context);
                                  PopupLoader.hideLoadingDialog(context);
                                  if (res.status!) {
                                    Utils.completedDialog(context);
                                  } else {
                                    ToastComponent.showToast(res.message!);
                                  }
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (widget.financeCourtViewData[i].showBottomNav)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: BackResetForwardBtnComponent(
                        onTapBack: () {
                          Utils.animateToPreviousPage(pageController, i);
                        },
                        onTapReset: () => Utils.animateToPreviousPage(
                            pageController,
                            widget.financeCourtViewData.length -
                                widget.financeCourtViewData.length),
                        onTapContinue: () => _onTapContinue(i),
                      ),
                    )
                ],
              ),
          ],
        );
      }
    });
  }

  _onTapContinue(int i) async {
    if (widget.financeCourtViewData[i].optionType == OptionConstants.userForm) {
      bool status = await Utils.submitProfile(context);
      if (status) {
        Utils.animateToNextPage(pageController, i);
      }
    } else if (widget.financeCourtViewData[i].optionType ==
        OptionConstants.subjectTaxLaw) {
      _validateSubjectLawData(i);
    } else if (widget.financeCourtViewData[i].optionType ==
        OptionConstants.signature) {
      bool status = await Provider.of<SignatureProvider>(context, listen: false)
          .checkSignatureIsPresent();
      if (status) {
        Utils.animateToNextPage(pageController, i);
      }
    } else {
      Utils.animateToNextPage(pageController, i);
    }
  }

  _validateSubjectLawData(int i) {
    FinanceViewData _data;
    if (context.locale == const Locale('en')) {
      _data = provider.financeLawWrapper.en;
    } else {
      _data = provider.financeLawWrapper.du;
    }
    var foundChecked =
        _data.options.firstWhereOrNull((e) => e.isSelect == true);
    if (foundChecked != null) {
      Utils.animateToNextPage(pageController, i);
    } else {
      ToastComponent.showToast(
          ErrorMessagesConstants.pleaseCheckTheAboveFields);
    }
  }
}
