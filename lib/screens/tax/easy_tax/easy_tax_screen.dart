import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/back_reset_forward_btn_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/shadow_card_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/user_form_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/options_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/widget_styles.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/easy_tax/easy_tax_provider.dart';
import 'package:steuermachen/screens/tax/easy_tax/easy_tax_component/initial_easy_tax_component.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_wrapper.dart';

class EasyTaxScreen extends StatefulWidget {
  const EasyTaxScreen({Key? key}) : super(key: key);

  @override
  _EasyTaxScreenState createState() => _EasyTaxScreenState();
}

class _EasyTaxScreenState extends State<EasyTaxScreen> {
  late EasyTaxProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<EasyTaxProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => provider.getEasyTaxViewData().then((value) => response = value),
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
        backText: "",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Consumer<EasyTaxProvider>(builder: (context, consumer, child) {
          if (consumer.getBusyStateEasyTax || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                consumer.setBusyStateEasyTax = true;
                await provider
                    .addEasyTaxViewData()
                    .then((value) => response = value);
                consumer.setBusyStateEasyTax = false;
              },
            );
          } else {
            EasyTaxWrapper easyTaxWrapper = response!.data as EasyTaxWrapper;
            if (context.locale == const Locale('en')) {
              return _QuestionsView(
                easyTaxData: easyTaxWrapper.en,
              );
            } else {
              return _QuestionsView(
                easyTaxData: easyTaxWrapper.du,
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
    required this.easyTaxData,
  }) : super(key: key);
  final List<EasyTaxData> easyTaxData;

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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      children: [
                        if (widget.easyTaxData[i].optionType ==
                            OptionConstants.initialScreen)
                          InitialEasyTaxComponent(
                            onPressed: () {
                              pageController.animateToPage(i + 1,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInToLinear);
                              // Navigator.pushNamed(
                              //     context, RouteConstants.taxAdviceFormScreen);
                            },
                          )
                        else if (widget.easyTaxData[i].optionType ==
                            OptionConstants.userForm)
                          const UserFormComponent()
                        else if (widget.easyTaxData[i].optionType ==
                            OptionConstants.paymentMethods)
                          const PaymentMethodsComponent()
                      ],
                    ),
                  ),
                ),
              ),
              if (widget.easyTaxData[i].showBottomNav)
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
