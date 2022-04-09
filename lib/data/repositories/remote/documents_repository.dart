import 'package:steuermachen/json/document_upload_options.dart';
import 'package:steuermachen/main.dart';

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
}
