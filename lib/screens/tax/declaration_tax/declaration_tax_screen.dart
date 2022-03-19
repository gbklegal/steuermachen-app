import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/providers/tax/declaration_tax/declaration_tax_provider.dart';
import 'package:steuermachen/screens/tax/declaration_tax/declaration_tax_components/declaration_question_view_component.dart';
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
              return DeclarationQuestionsViewComponent(
                declarationTaxData: declarationTaxViewWrapper.en,
              );
            } else {
              return DeclarationQuestionsViewComponent(
                declarationTaxData: declarationTaxViewWrapper.du,
              );
            }
          }
        }),
      ),
    );
  }
}
