import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/providers/document_provider.dart';
import 'package:steuermachen/providers/tax_file_provider.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class FileTaxFinalSubmissionScreen extends StatefulWidget {
  const FileTaxFinalSubmissionScreen({Key? key}) : super(key: key);

  @override
  State<FileTaxFinalSubmissionScreen> createState() =>
      _FileTaxFinalSubmissionScreenState();
}

class _FileTaxFinalSubmissionScreenState
    extends State<FileTaxFinalSubmissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarComponent(
        StringConstants.curStatus,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
            const TextProgressBarComponent(
              title: "${StringConstants.step} 5/5",
              progress: 1,
            ),
            const SizedBox(
              height: 48,
            ),
            TextComponent(
              StringConstants.initAdvice,
              style: FontStyles.fontBold(fontSize: 24),
            ),
            const SizedBox(
              height: 18,
            ),
            TextComponent(
              StringConstants.ifNeedInit,
              style: FontStyles.fontRegular(fontSize: 18),
            ),
            const SizedBox(
              height: 26,
            ),
            ButtonComponent(
              buttonText: StringConstants.toTaxRe.toUpperCase(),
              textStyle: FontStyles.fontRegular(
                  color: ColorConstants.white, fontSize: 18),
              btnHeight: 56,
              onPressed: () {
                Navigator.pushNamed(context, RouteConstants.taxAdviceScreen);
              },
            ),
            const SizedBox(
              height: 26,
            ),
            Align(
              alignment: Alignment.center,
              child: TextComponent(
                StringConstants.or,
                style: FontStyles.fontBold(fontSize: 24),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ButtonComponent(
              btnHeight: 56,
              buttonText: StringConstants.orderNow.toUpperCase(),
              textStyle: FontStyles.fontRegular(
                color: ColorConstants.white,
                fontSize: 18,
              ),
              color: ColorConstants.toxicGreen,
              onPressed: () async {
                PopupLoader.showLoadingDialog(context);
                TaxFileProvider taxFileProvider =
                    Provider.of<TaxFileProvider>(context, listen: false);
                DocumentsProvider documentsProvider =
                    Provider.of<DocumentsProvider>(context, listen: false);
                CommonResponseWrapper res = await taxFileProvider
                    .submitTaxFileForm(taxFileProvider.taxFile);
                CommonResponseWrapper resFiles =
                    await documentsProvider.uploadFiles();
                if (res.status!) {
                  // Navigator.pushNamed(
                  //     context, RouteConstants.fileTaxDoneOrderScreen);
                  ToastComponent.showToast((resFiles.message!+" files"), long: true);
                  ToastComponent.showToast(res.message!, long: true);
                } else {
                  ToastComponent.showToast(res.message!, long: true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
