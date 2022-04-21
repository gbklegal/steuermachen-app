import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/text_component.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:path/path.dart' as path;
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/data/view_models/document/document_view_model.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';
import 'documents_components/document_upload_component.dart';

class DocumentOverviewDetailScreen extends StatefulWidget {
  const DocumentOverviewDetailScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<DocumentOverviewDetailScreen> createState() =>
      _DocumentOverviewDetailScreenState();
}

class _DocumentOverviewDetailScreenState
    extends State<DocumentOverviewDetailScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  late DocumentsViewModel documentViewModel;

  @override
  void initState() {
    super.initState();
    documentViewModel = Provider.of<DocumentsViewModel>(context, listen: false);
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
      body: _mainBody(context),
    );
  }

  Padding _mainBody(BuildContext context) {
    DocumentOptionsWrappers documentOptions =
        documentViewModel.documentOptions.data as DocumentOptionsWrappers;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          if (context.locale == const Locale('en'))
            DocumentUploadComponent(data: documentOptions.en)
          else
            DocumentUploadComponent(data: documentOptions.du),
          const SizedBox(
            height: 20,
          ),
          TextComponent(
            LocaleKeys.documentOverviewForTaxYear.tr() +
                " ${documentViewModel.selectedTax.taxYear}",
            style: FontStyles.fontMedium(
                fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.9),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<DocumentsViewModel>(
                      builder: (context, consumer, child) {
                    return Column(
                        children: consumer.selectedTax.documentsPath!.isNotEmpty
                            ? consumer.selectedTax.documentsPath!
                                .map((e) => _selectedDocumentListTile(
                                      e.url,
                                      e.documentTitle,
                                      isImage: false,
                                      isUrl: true,
                                    ))
                                .toList()
                            : [const TextComponent(LocaleKeys.noDocuments)]);
                  }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _selectedDocumentListTile(
    String fileName,
    String documentTitle, {
    bool isImage = true,
    bool isUrl = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.formFieldBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: _showImage(isImage, isUrl, fileName),
          title: Text(
            path.basename(File(fileName).path),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          ),
          subtitle: Text(documentTitle.toString()),
          trailing: InkWell(
              onTap: () async {
                PopupLoader.showLoadingDialog(context);
                await documentViewModel.deleteDocuments(
                    documentViewModel.selectedTax, fileName);

                PopupLoader.hideLoadingDialog(context);
              },
              child: SvgPicture.asset(AssetConstants.icCross)),
        ),
      ),
    );
  }

  Widget _showImage(bool isImage, bool isUrl, String fileName) {
    if (fileName.contains(".pdf")) {
      return Image.asset(AssetConstants.icPdf);
    }
    if (isImage) {
      return _imagePreview(fileName);
    } else if (isUrl) {
      return _imagePreview(fileName, isUrl: isUrl);
    } else {
      return Image.asset(AssetConstants.icPdf);
    }
  }

  InkWell _imagePreview(String imagePath, {bool isUrl = false}) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(),
              body: PhotoView(
                imageProvider: _getImageProvider(imagePath, isUrl: isUrl),
              ),
            ),
          ),
        );
      },
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: _getImageProvider(imagePath, isUrl: isUrl)
              // FileImage(
              //   File(imagePath),
              // ),
              ),
        ),
      ),
    );
  }

  _getImageProvider(String imagePath, {bool isUrl = false}) {
    if (isUrl) {
      return NetworkImage(imagePath);
    } else {
      return FileImage(
        File(imagePath),
      );
    }
  }
}
