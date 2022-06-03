import 'package:steuermachen/json/document_upload_options.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/declaration_tax/user_orders_data_model.dart';

class DocumentsRepository {
  Future<dynamic> addDocumentsOptionsData() async {
    try {
      return await firestore
          .collection("document")
          .doc("document-options")
          .set(documentOptionJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> fetchDocumentOptions() async {
    try {
      return await firestore
          .collection("document")
          .doc("document-options")
          .get();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addUserTaxDocuments(UserOrdersDataModel _selectedTax) async {
    try {
      await firestore
          .collection("user_orders")
          .doc(_selectedTax.keyId)
          .update({"documents_path": _selectedTax.documentsPath?.map((e) => e.toJson()).toList()});
    } catch (e) {
      rethrow;
    }
  }
}
