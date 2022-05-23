import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/view_models/tax/current_year_tax/current_year_tax_provider.dart';
import 'package:steuermachen/screens/tax/current_year_tax/current_year_tax_question_component.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) =>
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
              return CurrentYearTaxViewComponent(
                currentYearTaxData: currentYearTaxViewWrapper.en,
              );
            } else {
              return CurrentYearTaxViewComponent(
                currentYearTaxData: currentYearTaxViewWrapper.du,
              );
            }
          }
        }),
      ),
    );
  }
}
