import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/empty_screen_loader_component.dart';
import 'package:steuermachen/components/error_component%20copy.dart';
import 'package:steuermachen/components/selection_card_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/quick_tax_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class QuickTaxScreen extends StatefulWidget {
  const QuickTaxScreen({Key? key}) : super(key: key);

  @override
  _QuickTaxScreenState createState() => _QuickTaxScreenState();
}

class _QuickTaxScreenState extends State<QuickTaxScreen> {
  late QuickTaxProvider provider;
  late Future<CommonResponseWrapper> response;
  @override
  void initState() {
    provider = Provider.of<QuickTaxProvider>(context, listen: false);
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   provider = Provider.of<QuickTaxProvider>(context, listen: false);
  //   Future.microtask(() {
  //     provider.setBusyStateQuickTax = true;
  //     provider.getQuickTaxViewData().then(
  //         (value) => {response = value, provider.setBusyStateQuickTax = false});
  //   });
  // }

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
          child: FutureBuilder<CommonResponseWrapper>(
            future: provider.getQuickTaxViewData(),
            builder: (context, AsyncSnapshot<CommonResponseWrapper> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Text(
                      "No Data Found!!",
                      style: TextStyle(fontSize: 25.0),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextProgressBarComponent(
                        title: "${LocaleKeys.step.tr()} 9/10",
                        progress: 0.9,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Wähle dein jährliches\nBruttoeinkommen aus (ca.)",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16),
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
                                for (var i = 0; i < 25; i++)
                                  const SelectionCardComponent(
                                    title: "bis 9.000 Euro",
                                  )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                return ErrorComponent(
                  message: snapshot.data!.message!,
                  onTap: () async {
                    // consumer.setBusyStateQuickTax = true;
                    // await provider
                    //     .getQuickTaxViewData()
                    //     .then((value) => response = value);
                    // consumer.setBusyStateQuickTax = false;
                  },
                );
              } else {
                return const EmptyScreenLoaderComponent();
              }
            },
          )
          // Consumer<QuickTaxProvider>(builder: (context, consumer, child) {
          //   if (consumer.getBusyStateQuickState) {
          //     return const EmptyScreenLoaderComponent();
          //   } else if (!response.status!) {
          //     return ErrorComponent(
          //       message: response.message!,
          //       onTap: () async {
          //         consumer.setBusyStateQuickTax = true;
          //         await provider
          //             .getQuickTaxViewData()
          //             .then((value) => response = value);
          //         consumer.setBusyStateQuickTax = false;
          //       },
          //     );
          //   } else {
          //     return Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         TextProgressBarComponent(
          //           title: "${LocaleKeys.step.tr()} 9/10",
          //           progress: 0.9,
          //         ),
          //         const SizedBox(
          //           height: 20,
          //         ),
          //         Text(
          //           "Wähle dein jährliches\nBruttoeinkommen aus (ca.)",
          //           textAlign: TextAlign.left,
          //           style: Theme.of(context)
          //               .textTheme
          //               .bodyText1!
          //               .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
          //         ),
          //         const SizedBox(
          //           height: 15,
          //         ),
          //         Expanded(
          //           child: SingleChildScrollView(
          //             child: Padding(
          //               padding: const EdgeInsets.only(bottom: 25),
          //               child: Column(
          //                 children: [
          //                   for (var i = 0; i < 25; i++)
          //                     const SelectionCardComponent(
          //                       title: "bis 9.000 Euro",
          //                     )
          //                 ],
          //               ),
          //             ),
          //           ),
          //         )
          //       ],
          //     );
          //   }
          // }),
          ),
    );
  }
}
