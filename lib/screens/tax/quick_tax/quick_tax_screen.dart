import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/widget_styles.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/quick_tax/quick_tax_provider.dart';
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
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        provider.getQuickTaxViewData().then((value) => response = value));
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
        child: Consumer<QuickTaxProvider>(builder: (context, consumer, child) {
          if (consumer.getBusyStateQuickTax || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                consumer.setBusyStateQuickTax = true;
                await provider
                    .getQuickTaxViewData()
                    .then((value) => response = value);
                consumer.setBusyStateQuickTax = false;
              },
            );
          } else {
            QuickTaxWrapper quickTaxWrapper = response!.data as QuickTaxWrapper;
            if (context.locale == const Locale('en')) {
              return _QuestionsView(
                quickTaxData: quickTaxWrapper.en,
              );
            } else {
              return _QuestionsView(
                quickTaxData: quickTaxWrapper.du,
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
                    child: Column(
                      children: [
                        if (widget.quickTaxData[i].optionType ==
                            OptionConstants.singleSelect)
                          for (var x = 0;
                              x < widget.quickTaxData[i].options.length;
                              x++)
                            InkWell(
                              onTap: () {
                                pageController.animateToPage(i + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInToLinear);
                              },
                              child: SelectionCardComponent(
                                title: widget.quickTaxData[i].options[x],
                              ),
                            )
                        else
                          TextFormField(
                            // controller: _emailController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                label: Text(widget.quickTaxData[i].inputTitle),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: WidgetStyles.outlineInputBorder,
                                enabledBorder: WidgetStyles.outlineInputBorder,
                                filled: true),
                            // validator: validateEmail,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.quickTaxData[i].showBottomNav)
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
}
