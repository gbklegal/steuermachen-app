import 'package:firebase_auth/firebase_auth.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/json/declaration_tax_view.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class SafeAndDeclarationTaxRepository {
  Future<dynamic> addDeclarationTaxViewData() async {
    try {
      await firestore
          .collection("declaration_tax")
          .doc("content")
          .set(declarationTaxViewJson);
    } catch (e) {
      rethrow;
    }
  }

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

  Future<dynamic> fetchDeclarationTaxViewData() async {
    try {
      return await firestore.collection("declaration_tax").doc("content").get();
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> submitDeclarationTax(Map<String, dynamic> data) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("safe_and_declaration_tax")
          .add(data);
    } catch (e) {
      rethrow;
    }
  }
}
