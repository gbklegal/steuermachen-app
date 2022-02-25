import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/dialogs/completed_dialog_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/signature_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/document/document_provider.dart';
import 'package:steuermachen/providers/signature/signature_provider.dart';

class LegalAction2Screen extends StatefulWidget {
  const LegalAction2Screen({Key? key}) : super(key: key);

  @override
  State<LegalAction2Screen> createState() => _LegalAction2ScreenState();
}

class _LegalAction2ScreenState extends State<LegalAction2Screen> {
  @override
  void initState() {
    super.initState();
  }

  _dialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const CompletedDialogComponent();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        LocaleKeys.powerOfAttorney.tr(),
        showPersonIcon: false,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SignatureComponent(),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ElevatedButton(
          style: ElevatedButtonTheme.of(context).style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 56),
                ),
              ),
          onPressed: () async {
            PopupLoader.showLoadingDialog(context);
            var signatureProvider =
                Provider.of<SignatureProvider>(context, listen: false);
            var pngBytes = await signatureProvider.controller.toPngBytes();
            String sign = await signatureProvider.createTempPath(pngBytes!);
            DocumentsProvider _provider =
                Provider.of<DocumentsProvider>(context, listen: false);
            _provider.setSignaturePath(sign);
            await _provider.uploadFiles();
            PopupLoader.hideLoadingDialog(context);
            _dialog();
          },
          child: Text(
            LocaleKeys.send.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
