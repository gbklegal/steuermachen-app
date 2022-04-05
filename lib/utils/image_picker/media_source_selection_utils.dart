import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/utils/image_picker/image_preview_util.dart';

class MediaSourceSelectionWidget extends StatefulWidget {
  final GestureTapCallback? onTapGallery, onTapCamera;
  final Function(String)? onImagePath;

  const MediaSourceSelectionWidget(
      {Key? key, this.onTapGallery, this.onTapCamera, this.onImagePath})
      : super(key: key);

  @override
  _MediaSourceSelectionWidgetState createState() =>
      _MediaSourceSelectionWidgetState();
}

class _MediaSourceSelectionWidgetState
    extends State<MediaSourceSelectionWidget> {
  List<PickedFile> prescription = <PickedFile>[];
  final ImagePicker _picker = ImagePicker();
  late PickedFile profileImage;

  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  bool isImageSelectedCamera = false;
  late String imagePath;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LocaleKeys.chooseOption.tr()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            InkWell(
              enableFeedback: true,
              child: ListTile(
                leading: const Icon(Icons.photo),
                title: Text(LocaleKeys.gallery.tr()),
              ),
              onTap: () async {
                await getImage(context);
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            InkWell(
              enableFeedback: true,
              child: ListTile(
                leading: const Icon(Icons.camera),
                title: Text(LocaleKeys.camera.tr()),
              ),
              onTap: () async {
                await getImageCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  // ignore: prefer_typing_uninitialized_variables
  var pickedImage;
  Future getImage(BuildContext context) async {
    pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 70,
        maxHeight: 600,
        maxWidth: 600);
    if (pickedImage != null) {
      imagePath = pickedImage.path;
      showCustomImageView(context, false);
    }
  }

  Future getImageCamera(BuildContext context) async {
    pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70,
        maxHeight: 600,
        maxWidth: 600);
    if (pickedImage != null) {
      imagePath = pickedImage.path;
      showCustomImageView(context, true);
    } else {
      // ignore: avoid_print
      print('No image selected.');
    }
  }

  void showCustomImageView(BuildContext context, bool imageSelectedCamera) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomImagePreview(
          path: imagePath,
          // imageCroped: () {
          //   _cropImage(pickedImage.path);
          // },
          onImagePath: (imagePath) {
            widget.onImagePath!(imagePath);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          onButtonCancel: () {
            Navigator.pop(context);
            if (isImageSelectedCamera) {
              deleteFile(imagePath);
            }
          },
        );
      },
    );
  }

  Future<void> deleteFile(String path) async {
    try {
      final file = File(path);
      await file.delete();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
