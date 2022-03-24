import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/providers/tax/easy_tax/easy_tax_provider.dart';
import 'package:steuermachen/screens/tax/easy_tax/easy_tax_component/easy_tax_question_component.dart';
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
    _getEasyTaxViewData();
    super.initState();
  }

  void _getEasyTaxViewData() {
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) => provider.getEasyTaxViewData().then(
        (value) {
          setState(
            () {
              response = value;
            },
          );
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
            if (provider.getBusyStateEasyTax || response == null)
              const EmptyScreenLoaderComponent()
            else if (!response!.status!)
              ErrorComponent(
                  message: response!.message!,
                  onTap: () async {
                    provider.setBusyStateEasyTax = true;
                    await provider
                        .addEasyTaxViewData()
                        .then((value) => response = value);
                    provider.setBusyStateEasyTax = false;
                  })
            else
              _getMainBody(),
          ],
        ),
      ),
    );
  }

  Flexible _getMainBody() {
    EasyTaxWrapper easyTaxWrapper = response!.data as EasyTaxWrapper;
    if (context.locale == const Locale('en')) {
      return Flexible(
        child: EasyTaxQuestionsViewComponent(
          easyTaxData: easyTaxWrapper.en,
        ),
      );
    } else {
      return Flexible(
        child: EasyTaxQuestionsViewComponent(
          easyTaxData: easyTaxWrapper.du,
        ),
      );
    }
  }
}
