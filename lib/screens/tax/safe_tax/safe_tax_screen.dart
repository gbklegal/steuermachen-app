import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/signature_component.dart';
import 'package:steuermachen/components/terms_conditions_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/signature/signature_provider.dart';
import 'package:steuermachen/providers/tax/safe_tax/safe_tax_provider.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/safe_tax/safe_tax_wrapper.dart';

class SafeTaxScreen extends StatefulWidget {
  const SafeTaxScreen({Key? key}) : super(key: key);

  @override
  _SafeTaxScreenState createState() => _SafeTaxScreenState();
}

class _SafeTaxScreenState extends State<SafeTaxScreen> {
  late SafeTaxProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<SafeTaxProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => provider.getSafeTaxViewData().then(
        (value) {
          setState(() {
            response = value;
          });
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
            if (provider.getBusyStateSafeTax || response == null)
              const EmptyScreenLoaderComponent()
            else if (!response!.status!)
              ErrorComponent(
                message: response!.message!,
                onTap: () async {
                  provider.setBusyStateSafeTax = true;
                  await provider
                      .getSafeTaxViewData()
                      .then((value) => response = value);
                  provider.setBusyStateSafeTax = false;
                },
              )
            else
              _getMainBody()
          ],
        ),
      ),
    );
  }

  Flexible _getMainBody() {
    SafeTaxWrapper safeTaxWrapper = response!.data as SafeTaxWrapper;
    if (context.locale == const Locale('en')) {
      return Flexible(
        child: _QuestionsView(
          safeTaxData: safeTaxWrapper.en,
        ),
      );
    } else {
      return Flexible(
        child: _QuestionsView(
          safeTaxData: safeTaxWrapper.du,
        ),
      );
    }
  }
}

class _QuestionsView extends StatefulWidget {
  const _QuestionsView({
    Key? key,
    required this.safeTaxData,
  }) : super(key: key);
  final List<SafeTaxData> safeTaxData;

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
        for (var i = 0; i < widget.safeTaxData.length; i++)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextProgressBarComponent(
                title:
                    "${LocaleKeys.step.tr()} ${i + 1}/${widget.safeTaxData.length}",
                progress: (i + 1) / widget.safeTaxData.length,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.safeTaxData[i].title,
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
                  child: Consumer<SafeTaxProvider>(
                      builder: (context, consumer, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Column(
                        children: [
                          if (widget.safeTaxData[i].optionType ==
                              OptionConstants.singleSelect)
                            for (var x = 0;
                                x < widget.safeTaxData[i].options.length;
                                x++)
                              _optionsWidget(consumer, i, x)
                          else if (widget.safeTaxData[i].optionType ==
                              OptionConstants.userForm)
                            const UserFormComponent()
                          else if (widget.safeTaxData[i].optionType ==
                              OptionConstants.signature)
                            Transform.translate(
                              offset: const Offset(0, -20),
                              child: const SignatureComponent(),
                            )
                          else if (widget.safeTaxData[i].optionType ==
                              OptionConstants.termsCondition)
                            Transform.translate(
                              offset: const Offset(0, -20),
                              child: TermsAndConditionComponent(
                                  onPressedOrderNow: (value) async {
                                await _submitData(consumer);
                              }),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              if (widget.safeTaxData[i].showBottomNav) _bottomBtns(i)
            ],
          ),
      ],
    );
  }

  Padding _bottomBtns(int i) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 80),
      child: BackResetForwardBtnComponent(
        showContinueBtn:
            widget.safeTaxData[i].optionType != OptionConstants.singleSelect,
        onTapBack: () {
          Utils.animateToPreviousPage(pageController, i);
        },
        onTapContinue: () async {
          if (widget.safeTaxData[i].optionType == OptionConstants.userForm) {
            bool status = await Utils.submitProfile(context);
            if (status) {
              Utils.animateToNextPage(pageController, i);
            }
          }
        else  if (widget.safeTaxData[i].optionType == OptionConstants.signature) {
            bool status =
                await Provider.of<SignatureProvider>(context, listen: false)
                    .checkSignatureIsPresent();
            if (status) {
              Utils.animateToNextPage(pageController, i);
            }
          } else {
            Utils.animateToNextPage(pageController, i);
          }
        },
      ),
    );
  }

  SelectionCardComponent _optionsWidget(
      SafeTaxProvider consumer, int i, int x) {
    return SelectionCardComponent(
      title: widget.safeTaxData[i].options[x],
      imagePath: widget.safeTaxData[i].optionImgPath.isNotEmpty
          ? widget.safeTaxData[i].optionImgPath[x]
          : null,
      onTap: () {
        int year = DateTime.now().year;
        if (year.toString() == widget.safeTaxData[i].options[x]) {
          Navigator.pushNamed(context, RouteConstants.currentYearTaxScreen);
        } else {
          if (i == 0) {
            consumer.setTaxYear(widget.safeTaxData[i].options[x]);
          } else if (i == 1) {
            consumer.setMartialStatus(widget.safeTaxData[i].options[x]);
          }
          Utils.animateToNextPage(pageController, i);
        }
      },
    );
  }

  _submitData(SafeTaxProvider consumer) async {
    PopupLoader.showLoadingDialog(context);
    CommonResponseWrapper res = await consumer.submitSafeTaxData(context);
    PopupLoader.hideLoadingDialog(context);
    if (res.status!) {
      Utils.completedDialog(context);
    } else {
      ToastComponent.showToast(res.message!);
    }
  }
}
