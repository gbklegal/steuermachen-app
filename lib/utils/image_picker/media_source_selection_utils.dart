import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/utils/image_picker/image_preview_util.dart';

class MediaSourceSelectionWidget extends StatelessWidget {
  final GestureTapCallback? onTapGallery, onTapCamera;
  final Function(String)? onImagePath;

  MediaSourceSelectionWidget(
      {Key? key, this.onTapGallery, this.onTapCamera, this.onImagePath})
      : super(key: key);

  List<PickedFile> prescription = <PickedFile>[];
  final ImagePicker _picker = ImagePicker();
  late PickedFile profileImage;

  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  bool isImageSelectedCamera = false;
  late String imagePath;

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return AlertDialog(
    //   title: const Text(StringConstants.chooseOption),
    //   content: SingleChildScrollView(
    //     child: ListBody(
    //       children: <Widget>[
    //         InkWell(
    //           enableFeedback: true,
    //           child: const ListTile(
    //             leading: Icon(Icons.photo),
    //             title: Text(StringConstants.gallery),
    //           ),
    //           onTap: () {
    //             getImage(context);
    //           },
    //         ),
    //         const Padding(padding: EdgeInsets.all(8.0)),
    //         InkWell(
    //           enableFeedback: true,
    //           child: const ListTile(
    //             leading: Icon(Icons.camera),
    //             title: Text(StringConstants.camera),
    //           ),
    //           onTap: () {
    //             getImageCamera(context);
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

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
            onImagePath!(imagePath);
            Navigator.pop(context);
            // Navigator.pop(context);
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
      print(e);
    }
  }
}
