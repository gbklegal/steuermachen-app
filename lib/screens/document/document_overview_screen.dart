import 'dart:io';
import 'package:easy_localization/src/public_ext.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/popup_loader_component.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:path/path.dart' as path;
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/providers/document/document_provider.dart';
import 'package:steuermachen/utils/image_picker/media_source_selection_utils.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/documents_wrapper.dart';

class DocumentOverviewScreen extends StatefulWidget {
  const DocumentOverviewScreen(
      {Key? key,
      this.showNextBtn = false,
      this.onNextBtnRoute,
      this.uploadBtnNow = false,
      this.showRoundBody = true})
      : super(key: key);

  final bool? showNextBtn;
  final bool? uploadBtnNow;
  final String? onNextBtnRoute;
  final bool? showRoundBody;
  @override
  State<DocumentOverviewScreen> createState() => _DocumentOverviewScreenState();
}

class _DocumentOverviewScreenState extends State<DocumentOverviewScreen> {
  late List<String> selectImageList = [];
  late List<String> selectPDFList = [];
  User? user = FirebaseAuth.instance.currentUser;
  late DocumentsProvider _provider;
  List<DocumentsWrapper> documents = [];
  @override
  void initState() {
    super.initState();
    _provider = Provider.of<DocumentsProvider>(context, listen: false);

    _provider.getDocuments().then((value) => documents = value);
  }

  PreferredSizeWidget? _appBar() {
    if (!widget.showRoundBody!) {
      return AppBarComponent(
        LocaleKeys.uplaodYourDocuments.tr(),
        showPersonIcon: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _mainBody(context),
      bottomNavigationBar: Visibility(
        visible: widget.showNextBtn! || widget.uploadBtnNow!,
        child: Padding(
          padding: AppConstants.bottomBtnPadding,
          child: ButtonComponent(
            btnHeight: 56,
            buttonText: widget.uploadBtnNow!
                ? LocaleKeys.upload.tr()
                : LocaleKeys.next.tr().toUpperCase(),
            textStyle: FontStyles.fontRegular(
                color: ColorConstants.white, fontSize: 18),
            onPressed: () async {
              _provider
                  .setFilesForUpload([...selectPDFList, ...selectImageList]);
              if (widget.uploadBtnNow!) {
                PopupLoader.showLoadingDialog(context);
                CommonResponseWrapper res = await _provider.uploadFiles();
                PopupLoader.hideLoadingDialog(context);
                ToastComponent.showToast(res.message!);
              } else {
                Navigator.pushNamed(context, widget.onNextBtnRoute!);
              }
            },
          ),
        ),
      ),
    );
  }

  Column _mainBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        _documentSelection(context),
        const _DocumentOverview(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer<DocumentsProvider>(
                    builder: (context, consumer, child) {
                  return Column(
                    children: [
                      for (var i = 0; i < documents.length; i++)
                        for (var x = 0; x < documents[i].url.length; x++)
                          _selectedDocumentListTile(documents[i].url[x],
                              Utils.getTimeAgo(DateTime.now()), i,
                              isImage: false, isUrl: true, doc: documents[i])
                    ],
                  );
                }),
                if (selectImageList.isNotEmpty)
                  for (var i = 0; i < selectImageList.length; i++)
                    _selectedDocumentListTile(selectImageList[i],
                        Utils.getTimeAgo(DateTime.now()), i),
                if (selectPDFList.isNotEmpty)
                  for (var i = 0; i < selectPDFList.length; i++)
                    _selectedDocumentListTile(
                        selectPDFList[i], Utils.getTimeAgo(DateTime.now()), i,
                        isImage: false),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column _documentSelection(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              LocaleKeys.selectDocument.tr(),
              style: FontStyles.fontMedium(
                  lineSpacing: 1.1, fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  Padding _selectedDocumentListTile(
    String fileName,
    String time,
    int index, {
    DocumentsWrapper? doc,
    bool isImage = true,
    bool isUrl = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          subtitle: Text(time.toString()),
          trailing: InkWell(
              onTap: () async {
                if (isUrl) {
                  PopupLoader.showLoadingDialog(context);
                  await _provider.deleteDocuments(doc!, fileName);
                  var x = await _provider.getDocuments();
                  setState(() {
                    documents = [];
                    documents = x;
                  });
                  PopupLoader.hideLoadingDialog(context);
                } else {
                  setState(() {
                    if (isImage) {
                      selectImageList.removeAt(index);
                    } else {
                      selectPDFList.removeAt(index);
                    }
                  });
                }
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
            builder: (context) => PhotoView(
              imageProvider: _getImageProvider(imagePath, isUrl: isUrl),
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
class _DocumentOverview extends StatelessWidget {
  const _DocumentOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.documentOverview.tr(),
              style: FontStyles.fontMedium(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5.0),
              child: Icon(
                Icons.file_upload_outlined,
                color: ColorConstants.primary,
                size: 22,
              ),
            )
          ],
        ),
      ),
    );
  }
}
