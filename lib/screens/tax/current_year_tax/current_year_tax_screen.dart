import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/payment/payment_methods_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/tax/current_year_tax/current_year_tax_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/current_year_view_wrapper.dart';

class CurrentYearTaxScreen extends StatefulWidget {
  const CurrentYearTaxScreen({Key? key}) : super(key: key);

  @override
  _CurrentYearTaxScreenState createState() => _CurrentYearTaxScreenState();
}

class _CurrentYearTaxScreenState extends State<CurrentYearTaxScreen> {
  late CurrentYearTaxProvider provider;
  CommonResponseWrapper? response;
  @override
  void initState() {
    provider = Provider.of<CurrentYearTaxProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        provider.getCurrentYearTaxViewData().then((value) => response = value));
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
        showBottomLine: false,
        backText: "",
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Consumer<CurrentYearTaxProvider>(
            builder: (context, consumer, child) {
          if (consumer.getBusyStateDeclarationTax || response == null) {
            return const EmptyScreenLoaderComponent();
          } else if (!response!.status!) {
            return ErrorComponent(
              message: response!.message!,
              onTap: () async {
                consumer.setBusyStateDeclarationTax = true;
                await provider
                    .getCurrentYearTaxViewData()
                    .then((value) => response = value);
                consumer.setBusyStateDeclarationTax = false;
              },
            );
          } else {
            CurrentYearViewWrapper currentYearTaxViewWrapper =
                response!.data as CurrentYearViewWrapper;
            if (context.locale == const Locale('en')) {
              return _CurrentYearTaxView(
                currentYearTaxData: currentYearTaxViewWrapper.en,
              );
            } else {
              return _CurrentYearTaxView(
                currentYearTaxData: currentYearTaxViewWrapper.du,
              );
            }
          }
        }),
      ),
    );
  }
}

class _CurrentYearTaxView extends StatefulWidget {
  const _CurrentYearTaxView({
    Key? key,
    required this.currentYearTaxData,
  }) : super(key: key);
  final CurrentYearViewData currentYearTaxData;

  @override
  State<_CurrentYearTaxView> createState() => _CurrentYearTaxViewState();
}

class _CurrentYearTaxViewState extends State<_CurrentYearTaxView> {
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
         const PaymentMethodsComponent()
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
                widget.currentYearTaxData.price.toString() + "",
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
          buttonText: LocaleKeys.powerOfAttorney,
          onPressed: (){
             pageController.animateToPage(pageIndex + 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInToLinear);
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
}
