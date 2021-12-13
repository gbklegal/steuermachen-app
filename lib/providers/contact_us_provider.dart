import 'package:flutter/material.dart';
import 'package:steuermachen/utils/input_validation_util.dart';

class ContactUsProvider extends ChangeNotifier with InputValidationUtil {
  String? validateEmptyField(String? value) {
    return validateEmail(value);
  }

}
