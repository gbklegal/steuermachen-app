import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/quick_tax_provider.dart';

class QuickTaxScreen extends StatefulWidget {
  const QuickTaxScreen({Key? key}) : super(key: key);

  @override
  _QuickTaxScreenState createState() => _QuickTaxScreenState();
}

class _QuickTaxScreenState extends State<QuickTaxScreen> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextProgressBarComponent(
              title: "${LocaleKeys.step.tr()} 9/10",
              progress: 0.9,
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                // await Provider.of<QuickTaxProvider>(context, listen: false)
                //     .addQuickTaxViewData();
              },
              child: Text(
                "Wähle dein jährliches\nBruttoeinkommen aus (ca.)",
                textAlign: TextAlign.left,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            for (var i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 68,
                  decoration: BoxDecoration(
                    color: ColorConstants.toxicGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 0.5, color: ColorConstants.toxicGreen),
                  ),
                  child: Center(
                    child: Text(
                      "bis 9.000 Euro",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
