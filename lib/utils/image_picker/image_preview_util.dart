import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:photo_view/photo_view.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';

class CustomImagePreview extends StatefulWidget {
  // final PickedFile image;
  final GestureTapCallback? imageCroped, onButtonSubmit, onButtonCancel;
  final Function(String)? onImagePath;
  final String? path;
  const CustomImagePreview(
      {Key? key,
      this.path,
      this.imageCroped,
      this.onButtonSubmit,
      this.onButtonCancel,
      this.onImagePath})
      : super(key: key);
  @override
  _CustomImagePreviewState createState() => _CustomImagePreviewState();
}

class _CustomImagePreviewState extends State<CustomImagePreview> {
  String? cropImagePath = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Container(),
          actions: <Widget>[
            InkWell(
              enableFeedback: true,
              onTap: () {
                _cropImage(widget.path!);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.crop),
              ),
            )
          ],
        ),
        body: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PhotoView(
                imageProvider: FileImage(
                  File(getImageCroppedNot(
                      cropImagePath != "" ? cropImagePath : widget.path)),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: TextButton(
                  // color: Colors.red,
                  onPressed: widget.onButtonCancel,
                  child: Text(
                    LocaleKeys.cancel.tr(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: TextButton(
                      // color: Colors.green,
                      onPressed: () {
                        widget.onImagePath!(cropImagePath != ""
                            ? cropImagePath!
                            : widget.path!);
                      },
                      child: Text(
                        LocaleKeys.submit.tr(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )))
            ],
          ),
        ),
      ),
    );
  }

  //get cropped image or orignal image
  String getImageCroppedNot(path) {
    return path;
  }

  Future<void> _cropImage(String path) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        compressQuality: 70,
        // maxHeight: 600,
        // maxWidth: 600
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Edit',
            toolbarColor: ColorConstants.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            activeControlsWidgetColor: ColorConstants.primary,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Edit',
        ));
    if (croppedFile != null) {
      cropImagePath = croppedFile.path;
      setState(() {});
    }
  }
}
