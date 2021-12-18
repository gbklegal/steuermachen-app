import 'dart:io';
import 'dart:typed_data';
import 'package:easy_localization/src/public_ext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/dialogs/completed_dialog_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:signature/signature.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/document_provider.dart';

class LegalAction2Screen extends StatefulWidget {
  const LegalAction2Screen({Key? key}) : super(key: key);

  @override
  State<LegalAction2Screen> createState() => _LegalAction2ScreenState();
}

class _LegalAction2ScreenState extends State<LegalAction2Screen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: ColorConstants.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
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
      appBar:  AppBarComponent(
        LocaleKeys.powerOfAttorney.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            Text(
              LocaleKeys.discPowerOfAttorney.tr(),
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              LocaleKeys.digitalSignature.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 25),
            Text(
              LocaleKeys.signHere.tr(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Signature(
                controller: _controller,
                height: 300,
                backgroundColor: ColorConstants.formFieldBackground,
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: AppConstants.bottomBtnPadding,
        child: ElevatedButton(
          style: ElevatedButtonTheme.of(context).style?.copyWith(
                minimumSize: MaterialStateProperty.all(
                  Size(MediaQuery.of(context).size.width, 70),
                ),
              ),
          onPressed: () async {
            PopupLoader.showLoadingDialog(context);
            var pngBytes = await _controller.toPngBytes();
            String sign = await _createTempPath(pngBytes!);
            DocumentsProvider _provider =
                Provider.of<DocumentsProvider>(context, listen: false);
            _provider.setSignaturePath(sign);
            await _provider.uploadFiles();
            PopupLoader.hideLoadingDialog(context);
            _dialog();
          },
          child:  Text(
            LocaleKeys.send.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Future<String> _createTempPath(Uint8List image) async {
    Uint8List imageInUnit8List = image; // store unit8List image here ;
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/signature.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    return '${tempDir.path}/signature.png';
  }
}
