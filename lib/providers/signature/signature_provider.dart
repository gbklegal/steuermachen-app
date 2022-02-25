import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:steuermachen/constants/colors/color_constants.dart';

class SignatureProvider extends ChangeNotifier {
  final SignatureController controller = SignatureController(
    penStrokeWidth: 2,
    penColor: ColorConstants.black,
    exportBackgroundColor: Colors.white,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );
  Future<String> createTempPath(Uint8List image) async {
    Uint8List imageInUnit8List = image; // store unit8List image here ;
    var tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/signature.png').create();
    file.writeAsBytesSync(imageInUnit8List);
    return '${tempDir.path}/signature.png';
  }


  clearSignature(){
    controller.clear();
  }
}
