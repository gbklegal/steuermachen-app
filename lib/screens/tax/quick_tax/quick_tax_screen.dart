import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/widget_styles.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/tax/quick_tax/quick_tax_provider.dart';
import 'package:steuermachen/utils/input_validation_util.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/quick_tax_wrapper.dart';

class QuickTaxScreen extends StatefulWidget {
  const QuickTaxScreen({Key? key}) : super(key: key);

  @override
  _QuickTaxScreenState createState() => _QuickTaxScreenState();
}

class _QuickTaxScreenState extends State<QuickTaxScreen> {
  late QuickTaxProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<QuickTaxProvider>(context, listen: false);
    _getData();
    super.initState();
  }

  _getData() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => provider.getQuickTaxViewData().then(
        (value) {
          setState(() {
            response = value;
          });
        },
      ),
    );
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (provider.getBusyStateQuickTax || response == null)
                const Center(child: EmptyScreenLoaderComponent())
              else if (!response!.status!)
                ErrorComponent(
                  message: response!.message!,
                  onTap: () async {
                    await provider
                        .getQuickTaxViewData()
                        .then((value) => response = value);
                  },
                )
              else
                _questionsView()
            ],
          ),
        ),
      ),
    );
  }

  Flexible _questionsView() {
    QuickTaxWrapper quickTaxWrapper = response!.data as QuickTaxWrapper;
    if (context.locale == const Locale('en')) {
      return Flexible(
        child: _QuestionsView(
          quickTaxData: quickTaxWrapper.en,
        ),
      );
    } else {
      return Flexible(
        child: _QuestionsView(
          quickTaxData: quickTaxWrapper.du,
        ),
      );
    }
  }
}

class _QuestionsView extends StatefulWidget {
  const _QuestionsView({
    Key? key,
    required this.quickTaxData,
  }) : super(key: key);
  final List<QuickTaxData> quickTaxData;

  @override
  State<_QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<_QuestionsView> {
  final pageController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Utils.hideKeyboard(context),
      child: PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          for (var i = 0; i < widget.quickTaxData.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextProgressBarComponent(
                  title:
                      "${LocaleKeys.step.tr()} ${i + 1}/${widget.quickTaxData.length}",
                  progress: (i + 1) / widget.quickTaxData.length,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.quickTaxData[i].title,
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
                      child: Consumer<QuickTaxProvider>(
                          builder: (context, consumer, child) {
                        return Column(
                          children: [
                            if (widget.quickTaxData[i].optionType ==
                                OptionConstants.singleSelect)
                              for (var x = 0;
                                  x < widget.quickTaxData[i].options.length;
                                  x++)
                                SelectionCardComponent(
                                  title: widget.quickTaxData[i].options[x].name,
                                  onTap: () {
                                    _selectionCardOnTap(
                                        consumer, i, x, context);
                                  },
                                )
                            else
                              TextFormField(
                                controller: consumer.controllers![i],
                                keyboardType:
                                    widget.quickTaxData[i].inputType == "number"
                                        ? TextInputType.number
                                        : null,
                                decoration: InputDecoration(
                                  label:
                                      Text(widget.quickTaxData[i].inputTitle),
                                  focusedBorder: WidgetStyles.outlineBorder,
                                  enabledBorder: WidgetStyles.outlineBorder,
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
                if (widget.quickTaxData[i].showBottomNav)
                  Consumer<QuickTaxProvider>(
                      builder: (context, consumer, child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: BackResetForwardBtnComponent(
                        showContinueBtn: widget.quickTaxData[i].optionType !=
                            OptionConstants.singleSelect,
                        onTapBack: () {
                          Utils.hideKeyboard(context);
                          Utils.animateToPreviousPage(pageController, i);
                        },
                        onTapContinue: () {
                          if (widget.quickTaxData[i].optionType ==
                              OptionConstants.input) {
                            if (_validateInputField(
                                consumer.controllers![i]!.text)) {
                              int parsedInt =
                                  int.parse(consumer.controllers![i]!.text);
                              if (parsedInt > 10) {
                                consumer.addPoint(i, 1);
                              }
                              Utils.hideKeyboard(context);
                              Utils.animateToNextPage(pageController, i);
                            }
                          } else {
                            Utils.hideKeyboard(context);
                            Utils.animateToNextPage(pageController, i);
                          }
                        },
                      ),
                    );
                  })
              ],
            ),
        ],
      ),
    );
  }

  bool _validateInputField(String digit) {
    if (digit != "" && InputValidationUtil().isValidateDigit(digit)) {
      return true;
    } else {
      ToastComponent.showToast(ErrorMessagesConstants.invalidInput);
      return false;
    }
  }

  void _selectionCardOnTap(
      QuickTaxProvider consumer, int i, int x, BuildContext context) {
    consumer.addPoint(i, widget.quickTaxData[i].options[x].point);
    if (widget.quickTaxData[i].options[x].decision ==
        OptionConstants.complete) {
      Navigator.pushReplacementNamed(
          context, RouteConstants.quickTaxEstimatedValueScreen);
    } else {
      Utils.animateToNextPage(pageController, i);
    }
  }
}
