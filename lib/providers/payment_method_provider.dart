import 'package:flutter/material.dart';
import 'package:steuermachen/wrappers/user_wrapper.dart';

class PaymentMethodProvider extends ChangeNotifier {
  UserWrapper? _selectedAddress;

  UserWrapper? get getSelectedAddress => _selectedAddress;

  set setSelectedAddress(UserWrapper? selectedAddress) {
    _selectedAddress = selectedAddress;
  }

}
