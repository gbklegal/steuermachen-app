import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/repositories/remote/documents_repository.dart';
import 'package:steuermachen/data/repositories/remote/safe_and_declaration_tax_repository.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';
import 'package:steuermachen/wrappers/document/documents_wrapper.dart';

class DocumentsViewModel extends ChangeNotifier {
  late ApiResponse _documentOptions = ApiResponse.loading();
  ApiResponse get documentOptions => _documentOptions;
  set setDocumentOptions(ApiResponse documentsOptions) {
    _documentOptions = documentsOptions;
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

  Future<CommonResponseWrapper> addDocumentOptionsData() async {
    try {
      await serviceLocatorInstance<DocumentsRepository>()
          .addDocumentsOptionsData();
      return CommonResponseWrapper(
          status: true, message: StringConstants.success);
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  Future<void> fetchDocumentOptionsData() async {
    try {
      if (documentOptions.status == Status.loading ||
          documentOptions.data == null) {
        setDocumentOptions = ApiResponse.loading();
        notifyListeners();
        var res = await serviceLocatorInstance<DocumentsRepository>()
            .fetchDocumentOptions();
        Map<String, dynamic> x = res.data() as Map<String, dynamic>;
        DocumentOptionsWrappers data = DocumentOptionsWrappers.fromJson(x);
        setDocumentOptions = ApiResponse.completed(data);
      }
    } catch (e) {
      setDocumentOptions = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  _clearFields() {
    _selectedFiles = [];
    _signaturePath = "";
  }
}
