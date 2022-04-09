import 'package:firebase_auth/firebase_auth.dart';
import 'package:steuermachen/main.dart';

class SafeAndDeclarationTaxRepository {
  Future<dynamic> fetchTaxFiledYears() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      return await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("safe_and_declaration_tax")
          .get();
    } catch (e) {
      rethrow;
    }
  }
}
