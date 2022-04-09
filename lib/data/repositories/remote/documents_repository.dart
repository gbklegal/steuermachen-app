import 'package:firebase_auth/firebase_auth.dart';
import 'package:steuermachen/json/document_upload_options.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';

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

  Future<dynamic> addUserTaxDocuments(
      SafeAndDeclarationTaxDataCollectorWrapper _selectedTax) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("safe_and_declaration_tax")
          .doc(_selectedTax.keyId)
          .update(
              _selectedTax.toJson(_selectedTax.taxName!, _selectedTax.steps!));
    } catch (e) {
      rethrow;
    }
  }
}
