import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/email_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/repositories/remote/email_repository.dart';
import 'package:steuermachen/data/view_models/tax/declaration_tax/declaration_tax_view_model.dart';
import 'package:steuermachen/screens/tax/declaration_tax/declaration_tax_components/declaration_question_view_component.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_view_wrapper.dart';

class DeclarationTaxScreen extends StatefulWidget {
  const DeclarationTaxScreen({Key? key}) : super(key: key);

  @override
  _DeclarationTaxScreenState createState() => _DeclarationTaxScreenState();
}

class _DeclarationTaxScreenState extends State<DeclarationTaxScreen> {
  late DeclarationTaxViewModel provider;
  @override
  void initState() {
    provider = Provider.of<DeclarationTaxViewModel>(context, listen: false);
    _getDeclarationTaxViewData();
    super.initState();
  }

  void _getDeclarationTaxViewData() {
    if (provider.taxFiledYears.status != Status.completed ||
        provider.viewData.status != Status.completed) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => {
          provider
              .fetchTaxFiledYears()
              .then((_) => provider.fetchDeclarationTaxViewData())
        },
      );
    }
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
        child: Consumer<DeclarationTaxViewModel>(
            builder: (context, consumer, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (consumer.taxFiledYears.status == Status.loading ||
                  consumer.viewData.status == Status.loading)
                const EmptyScreenLoaderComponent()
              else if (consumer.taxFiledYears.status == Status.error ||
                  consumer.viewData.status == Status.error)
                ErrorComponent(
                  message: consumer.viewData.message!,
                  onTap: _getDeclarationTaxViewData,
                )
              else
                _getMainBody(consumer.viewData.data)
            ],
          );
        }),
      ),
    );
  }

  Flexible _getMainBody(DeclarationTaxViewWrapper declarationTaxViewWrapper) {
    if (context.locale == const Locale('en')) {
      return Flexible(
        child: DeclarationQuestionsViewComponent(
          declarationTaxData: declarationTaxViewWrapper.en,
          checkSubmittedTaxYears: provider.taxFiledYears.data,
        ),
      );
    } else {
      return Flexible(
        child: DeclarationQuestionsViewComponent(
          declarationTaxData: declarationTaxViewWrapper.du,
          checkSubmittedTaxYears: provider.taxFiledYears.data,
        ),
      );
    }
  }
}
