import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline/fdottedline.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/components/button_component.dart';
import 'package:steuermachen/components/error_component.dart';
import 'package:steuermachen/components/loading_component.dart';
import 'package:steuermachen/constants/app_constants.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:path/path.dart' as path;
import 'package:steuermachen/main.dart';
import 'package:steuermachen/providers/document_provider.dart';
import 'package:steuermachen/utils/image_picker/media_source_selection_utils.dart';
import 'package:steuermachen/utils/utils.dart';

class SelectDocumentForScreen extends StatefulWidget {
  const SelectDocumentForScreen(
      {Key? key, this.showNextBtn = false, this.onNextBtnRoute})
      : super(key: key);

  final bool? showNextBtn;
  final String? onNextBtnRoute;
  @override
  State<SelectDocumentForScreen> createState() =>
      _SelectDocumentForScreenState();
}

class _SelectDocumentForScreenState extends State<SelectDocumentForScreen> {
  late List<String> selectImageList = [];
  late List<String> selectPDFList = [];
  User? user = FirebaseAuth.instance.currentUser;
  _openCameraGallerySelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaSourceSelectionWidget(
          onTapGallery: () {
            Navigator.pop(context);
          },
          onTapCamera: () {},
          onImagePath: (String imagePath) async {
            setState(() {
              selectImageList.add(imagePath);
            });
          },
        );
      },
    );
  }

  _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        selectPDFList.add(result.files.single.path!);
        // File file = File();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBarWithSideCornerCircleAndRoundBody(
        body: _mainBody(context),
      ),
      bottomNavigationBar: Visibility(
        visible: widget.showNextBtn!,
        child: Padding(
          padding: AppConstants.bottomBtnPadding,
          child: ButtonComponent(
            btnHeight: 56,
            buttonText: StringConstants.next.toUpperCase(),
            textStyle: FontStyles.fontRegular(
                color: ColorConstants.white, fontSize: 18),
            onPressed: () {
              DocumentsProvider _provider =
                  Provider.of<DocumentsProvider>(context, listen: false);
              _provider
                  .setFilesForUpload([...selectPDFList, ...selectImageList]);
              Navigator.pushNamed(context, widget.onNextBtnRoute!);
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
                      consumer.getDocuments();
                        return const SizedBox();
                        // _selectedDocumentListTile(selectImageList[i],
                        // Utils.getTimeAgo(DateTime.now()), i);
                      // } else if (snapshot.hasError) {
                      //   return const ErrorComponent();
                      // } else {
                      //   return const LoadingComponent();
                      // }
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
              StringConstants.selectDocument,
              style: FontStyles.fontMedium(
                  lineSpacing: 1.1, fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: [
              Expanded(child: _useCameraBtn(context)),
              Expanded(child: _uploadBtn(context)),
            ],
          ),
        ),
      ],
    );
  }

  Padding _selectedDocumentListTile(String fileName, String time, int index,
      {bool isImage = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.formFieldBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: isImage
              ? _imagePreview(fileName)
              : Image.asset(AssetConstants.icPdf),
          title: Text(
            path.basename(File(fileName).path),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          ),
          subtitle: Text(time.toString()),
          trailing: InkWell(
              onTap: () {
                setState(() {
                  if (isImage) {
                    selectImageList.removeAt(index);
                  } else {
                    selectPDFList.removeAt(index);
                  }
                });
              },
              child: SvgPicture.asset(AssetConstants.icCross)),
        ),
      ),
    );
  }

  InkWell _imagePreview(String imagePath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoView(
              imageProvider: FileImage(File(imagePath)),
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
            image: FileImage(
              File(imagePath),
            ),
          ),
        ),
      ),
    );
  }

  Padding _useCameraBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 5),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButtonTheme.of(context).style?.copyWith(
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 58),
                  ),
                ),
            onPressed: () {
              _openCameraGallerySelectionDialog();
            },
            child: const Text(
              StringConstants.useCamera,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Padding _uploadBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 15),
      child: InkWell(
        onTap: () async {
          await _pickFile();
        },
        child: FDottedLine(
          dottedLength: 3,
          corner: const FDottedLineCorner(
              leftBottomCorner: 10,
              leftTopCorner: 10,
              rightTopCorner: 10,
              rightBottomCorner: 10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  StringConstants.select,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
              StringConstants.documentOverview,
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
