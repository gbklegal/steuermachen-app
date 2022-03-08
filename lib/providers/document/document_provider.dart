import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';
import 'package:steuermachen/wrappers/document/documents_wrapper.dart';

class DocumentsProvider extends ChangeNotifier {
    bool _busyStateDocument = true;
  bool get getBusyStateDocument => _busyStateDocument;
  set setBusyStateDocument(bool _isBusy) {
    _busyStateDocument = _isBusy;
    notifyListeners();
  }

  List<String> _selectedFiles = [];
  late String _signaturePath = "";
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
      if (_url.isNotEmpty) {
        await firestore
            .collection("user_documents")
            .doc("${user?.uid}")
            .collection("path")
            .add({"url": _url});
      }

      if (_signaturePath != "") {
        String digiSignatureUrl =
            await _uploadToFirebaseStorage(_signaturePath);
        if (digiSignatureUrl.isNotEmpty) {
          await firestore
              .collection("legal_advice")
              .doc("${user?.uid}")
              .collection("path")
              .add({"signature_path": digiSignatureUrl});
        }
      }
      _clearFields();
      return CommonResponseWrapper(status: true, message: "Documents uploaded");
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

  Future<List<DocumentsWrapper>> getDocuments() async {
    User? user = FirebaseAuth.instance.currentUser;
    QuerySnapshot data = await firestore
        .collection("user_documents")
        .doc(user!.uid)
        .collection("path")
        .get();
    List<DocumentsWrapper> documents = [];
    for (var ele in data.docs) {
      Map<String, dynamic> mapDocsUrl = ele.data() as Map<String, dynamic>;
      List<String> urls = [];
      for (var item in mapDocsUrl["url"]) {
        urls.add(item);
      }
      DocumentsWrapper x = DocumentsWrapper(
          path: "user_documents/${user.uid}/path/${ele.id}",
          key: ele.id,
          url: urls);
      documents.add(x);
    }
    notifyListeners();
    return documents;
  }

  deleteDocuments(DocumentsWrapper _document, String url) async {
    try {
      _document.url.remove(url);
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseStorage.instance.refFromURL(url).delete();
      await firestore
          .doc("user_documents/${user?.uid}/path/${_document.key}")
          .set({"url": _document.url});
    } catch (e) {
      print(e);
    }
  }
    Future<CommonResponseWrapper> getDocumentOptionsData() async {
    try {
      setBusyStateDocument = true;
      var res =
          await firestore.collection("document").doc("document-options").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      DocumentOptionsWrappers data = DocumentOptionsWrappers.fromJson(x);
      setBusyStateDocument = false;
      return CommonResponseWrapper(status: true, data: data);
    } catch (e) {
      setBusyStateDocument = false;
      return CommonResponseWrapper(
          status: false, message: "Something went wrong");
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: document_upload_options.json
  Future<CommonResponseWrapper> addDocumentOptionsData() async {
    try {
      await firestore.collection("document").doc("document-options").set(json);
      return CommonResponseWrapper(
          status: true, message: "addDocumentOptionsData view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: "Something went wrong");
    }
  }
  _clearFields() {
    _selectedFiles = [];
    _signaturePath = "";
  }
}

var json = {
  "en": [
    {
      "option_type": "option_list",
      "options": [
        "Annual wage tax statement",
        "Pension notice/certificate",
        "invoice for additional costs"
      ]
    },
    {"option_type": "years_list", "options": []}
  ],
  "du": [
    {
      "option_type": "option_list",
      "options": [
        "Annual wage tax statement",
        "Pension notice/certificate",
        "invoice for additional costs"
      ]
    },
    {"option_type": "years_list", "options": []}
  ]
};
