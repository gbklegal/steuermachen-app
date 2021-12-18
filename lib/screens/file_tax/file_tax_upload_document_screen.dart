import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/components/text_progress_bar_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class FileTaxUploadDocumentScreen extends StatefulWidget {
  const FileTaxUploadDocumentScreen({Key? key}) : super(key: key);

  @override
  _FileTaxUploadDocumentScreenState createState() =>
      _FileTaxUploadDocumentScreenState();
}

class _FileTaxUploadDocumentScreenState
    extends State<FileTaxUploadDocumentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarComponent(
        LocaleKeys.uplaodYourDocuments.tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 16),
             TextProgressBarComponent(
              title: "${LocaleKeys.step.tr()} 5/5",
              progress: 1,
            ),
            const SizedBox(
              height: 30,
            ),
            _buildUploadDocument(),
            const SizedBox(
              height: 20,
            ),
            _buildUploadedDocumentPreview()
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ButtonComponent(
          buttonText: LocaleKeys.next.tr(),
          onPressed: () {
            Navigator.pushNamed(
                context, RouteConstants.fileTaxFinalSubmissionScreen);
          },
        ),
      ),
    );
  }

  Widget _buildUploadDocument() {
    return Container(
      width: 359,
      height: 203.05,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [_buildBoxShadowUpload()],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextComponent(
            LocaleKeys.uploadDocuments.tr(),
            style: FontStyles.fontRegular(fontSize: 14),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: double.infinity,
            height: 133.971,
            decoration: BoxDecoration(
              color: ColorConstants.paleGrey,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(AssetConstants.uploadDoc),
                const SizedBox(
                  height: 8,
                ),
                TextComponent(
                  LocaleKeys.upload.tr(),
                  style: FontStyles.fontRegular(
                      fontSize: 12, color: ColorConstants.charcoalGrey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadedDocumentPreview() {
    return Container(
      width: 343,
      height: 137,
      padding: const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: ColorConstants.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [_buildBoxShadowUpload()],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextComponent(
            LocaleKeys.annualSlip.tr(),
            style: FontStyles.fontRegular(fontSize: 14),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              // color: ColorConstants.toxicGreen,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  fit: StackFit.loose,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          AssetConstants.sampleImg,
                          fit: BoxFit.fill,
                          height: 65,
                          width: 65,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: SvgPicture.asset(AssetConstants.removePic),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxShadow _buildBoxShadowUpload() {
    return const BoxShadow(
        color: ColorConstants.blackSix,
        offset: Offset(0, 0),
        blurRadius: 8,
        spreadRadius: 0);
  }
}
