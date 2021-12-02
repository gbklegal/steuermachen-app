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
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              StringConstants.document,
              style: FontStyles.fontBold(fontSize: 24),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: ColorConstants.formFieldBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: Image.asset(AssetConstants.icPdf),
              title: Text(
                "Annual tax slip 2020",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 18),
              ),
              subtitle: const Text("Yesterday"),
              trailing: SvgPicture.asset(AssetConstants.icBin),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Flexible(
          child: Image.asset(AssetConstants.submitDocument),
        ),
        const SizedBox(
          height: 60,
        ),
        _useCameraBtn(context),
        _uploadBtn(context),
      ],
    );
  }

  Padding _useCameraBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButtonTheme.of(context).style?.copyWith(
                  minimumSize: MaterialStateProperty.all(
                    Size(MediaQuery.of(context).size.width, 70),
                  ),
                ),
            onPressed: () {
              Navigator.pushNamed(context, RouteConstants.howItWorksScreen);
            },
            child: const Text(
              StringConstants.useCamera,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }

  Padding _uploadBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
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
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  StringConstants.upload,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
