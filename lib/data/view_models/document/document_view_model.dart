import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/repositories/remote/documents_repository.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/user_orders_data_model.dart';
import 'package:steuermachen/wrappers/document/document_option_wrapper.dart';
import 'package:steuermachen/wrappers/document/documents_wrapper.dart';

class DocumentsViewModel extends ChangeNotifier {
  late UserOrdersDataModel selectedTax;
  late ApiResponse _documentOptions = ApiResponse.loading();
  ApiResponse get documentOptions => _documentOptions;
  set setDocumentOptions(ApiResponse documentsOptions) {
    _documentOptions = documentsOptions;
  }

  List<String> _selectedFiles = [];
  setFilesForUpload(List<String> files) {
    _selectedFiles = files;
  }

  Future<CommonResponseWrapper> uploadFiles(String documentTitle,
      UserOrdersDataModel _selectedTax) async {
    try {
      List<DocumentsWrapper> _url = [];
      if (_selectedFiles.isNotEmpty) {
        for (var i = 0; i < _selectedFiles.length; i++) {
          String url = await _uploadToFirebaseStorage(_selectedFiles[i]);
          _url.add(DocumentsWrapper(documentTitle: documentTitle, url: url));
        }
      }
      User? user = FirebaseAuth.instance.currentUser;
      if (_url.isNotEmpty) {
        _selectedTax.documentsPath?.addAll(_url);
        await serviceLocatorInstance<DocumentsRepository>()
            .addUserTaxDocuments(_selectedTax);
      }
      selectedTax = _selectedTax;
      _clearFields();
      notifyListeners();
      return CommonResponseWrapper(status: true, message: "Documents uploaded");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  Future<String> _uploadToFirebaseStorage(String _file) async {
    File file = File(_file);
    String fileName = basename(file.path);
    var snapshot = FirebaseStorage.instance.ref().child("files/");
    var uploadedFile = await snapshot.child(Utils.generateRandomString(10)).putFile(file);
    String url = await uploadedFile.ref.getDownloadURL();
    return url;
  }



  deleteDocuments(UserOrdersDataModel _selectedTax,
      String url) async {
    try {
      _selectedTax.documentsPath?.removeWhere((element) => element.url == url);
      await FirebaseStorage.instance.refFromURL(url).delete();
      await serviceLocatorInstance<DocumentsRepository>()
          .addUserTaxDocuments(_selectedTax);
      selectedTax = _selectedTax;
      notifyListeners();
    } catch (e) {
      ToastComponent.showToast(LocaleKeys.somethingWentWrong.tr());
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
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  Future<void> fetchDocumentOptionsData() async {
    try {
      if (documentOptions.status != Status.completed) {
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
  }
}
