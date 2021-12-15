import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';

class LegalAdviceProvider extends ChangeNotifier {
  List<String> _selectedFiles = [];
  late String _signaturePath;
  setFilesForUpload(List<String> files) {
    _selectedFiles = files;
  }

  setSignaturePath(String signature) {
    _signaturePath = signature;
  }

  Future<CommonResponseWrapper> uploadFiles() async {
    try {
      List<String> _url = [];
      if (_selectedFiles.isNotEmpty) {
        for (var i = 0; i < _selectedFiles.length; i++) {
          String url = await _uploadToFirebaseStorage(_selectedFiles[i]);
          _url.add(url);
        }
      }
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_documents")
          .doc("${user?.uid}")
          .set({"document_path": _url}, SetOptions(merge: true));
      if (_signaturePath.isNotEmpty && _signaturePath != "") {
        String digiSignatureUrl =
            await _uploadToFirebaseStorage(_signaturePath);
        await firestore.collection("legal_advice").doc("${user?.uid}").set({
          "signature_path": [digiSignatureUrl]
        }, SetOptions(merge: true, mergeFields: ["signature_path"]));
      }
      // _clearFields();
      return CommonResponseWrapper(
          status: true, message: "Legal advice submitted");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<String> _uploadToFirebaseStorage(String _file) async {
    File file = File(_file);
    String fileName = basename(file.path);
    var snapshot = FirebaseStorage.instance.ref().child("files/");
    var uploadedFile = await snapshot.child(fileName).putFile(file);
    String url = await uploadedFile.ref.getDownloadURL();
    return url;
  }

  _clearFields() {
    _selectedFiles = [];
    _signaturePath = "";
  }
}
