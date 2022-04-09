import 'package:flutter/material.dart';
import 'package:steuermachen/main.dart';

class SustainabilityProvider extends ChangeNotifier {
  getSustainContent(String currentUserId) {
    var query = firestore.collection("sustainability").doc();
    print(query);
  }
}
