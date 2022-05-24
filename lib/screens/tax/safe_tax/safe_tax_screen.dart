import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/view_models/tax/safe_tax/safe_tax_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/safe_tax/safe_tax_wrapper.dart';
import 'safe_tax_components/safe_tax_questions_component.dart';

class SafeTaxScreen extends StatefulWidget {
  const SafeTaxScreen({Key? key}) : super(key: key);

  @override
  _SafeTaxScreenState createState() => _SafeTaxScreenState();
}

class _SafeTaxScreenState extends State<SafeTaxScreen> {
  late SafeTaxProvider provider;
  CommonResponseWrapper? response;
  CommonResponseWrapper? checkSubmittedTaxYears;
  @override
  void initState() {
    provider = Provider.of<SafeTaxProvider>(context, listen: false);
    provider.checkTaxIsAlreadySubmit().then((va) {
      checkSubmittedTaxYears = va;
      _getSafeTaxViewData();
    });
    super.initState();
  }

  void _getSafeTaxViewData() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) => provider.getSafeTaxViewData().then(
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
        child: SafeTaxQuestionsComponent(
          safeTaxData: safeTaxWrapper.en,
          checkSubmittedTaxYears: checkSubmittedTaxYears?.data,
        ),
      );
    } else {
      return Flexible(
        child: SafeTaxQuestionsComponent(
          safeTaxData: safeTaxWrapper.du,
          checkSubmittedTaxYears: checkSubmittedTaxYears?.data,
        ),
      );
    }
  }
}
