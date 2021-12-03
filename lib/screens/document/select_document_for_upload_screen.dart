import 'package:fdottedline/fdottedline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:steuermachen/components/app_bar/appbar_component.dart';
import 'package:steuermachen/components/app_bar/appbar_with_side_corner_circle_and_body.dart';
import 'package:steuermachen/constants/assets/asset_constants.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/constants/routes/route_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/constants/styles/font_styles_constants.dart';
import 'package:steuermachen/utils/image_picker/media_source_selection_utils.dart';

class SelectDocumentForScreen extends StatefulWidget {
  const SelectDocumentForScreen({Key? key}) : super(key: key);

  @override
  State<SelectDocumentForScreen> createState() =>
      _SelectDocumentForScreenState();
}

class _SelectDocumentForScreenState extends State<SelectDocumentForScreen> {
  late List<String> selectImageList = [];
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

  @override
  Widget build(BuildContext context) {
    return AppBarWithSideCornerCircleAndRoundBody(
      body: _mainBody(context),
    );
  }

  Column _mainBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
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
        Align(
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
        ),
        _selectedDocumentListTile(context),
      ],
    );
  }

  Padding _selectedDocumentListTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstants.formFieldBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Image.asset(AssetConstants.icPdf),
          title: Text(
            "Annual tax slip 2020",
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          ),
          subtitle: const Text("Yesterday"),
          trailing: SvgPicture.asset(AssetConstants.icCross),
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
              Navigator.pushNamed(context, RouteConstants.howItWorksScreen);
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
        onTap: _openCameraGallerySelectionDialog,
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
