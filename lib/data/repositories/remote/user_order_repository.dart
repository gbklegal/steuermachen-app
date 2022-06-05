import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steuermachen/constants/strings/tax_name_constants.dart';
import 'package:steuermachen/json/declaration_tax_view.dart';
import 'package:steuermachen/main.dart';

class UserOrderRepository {
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
          .where(
            'tax_name',
            whereIn: [
              TaxNameConstants.declarationTax,
              TaxNameConstants.safeTax,
              TaxNameConstants.currentYear,
            ],
          )
          .where('user_info.user_id', isEqualTo: user?.uid)
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

  Future<DocumentReference<Map<String, dynamic>>> submitUserOrder(
      Map<String, dynamic> data) async {
    try {
      return await firestore.collection("user_orders").add(data);
    } catch (e) {
      rethrow;
    }
  }
}
