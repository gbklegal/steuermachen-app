import 'package:flutter/material.dart';
import 'package:steuermachen/data/repositories/remote/user_order_repository.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';

class UserOrdersViewModel extends ChangeNotifier {
  late ApiResponse _userOrders = ApiResponse.loading();
  ApiResponse get userOrders => _userOrders;
  set setUserOrders(ApiResponse orders) {
    _userOrders = orders;
  }

  Future<void> fetchUserOrders({bool isNotifify = true}) async {
    try {
      setUserOrders = ApiResponse.loading();
      if (isNotifify) {
        notifyListeners();
      }
      var res =
          await serviceLocatorInstance<UserOrderRepository>().fetchUserOrders();
      if (res.docs.isNotEmpty) {
        setUserOrders = ApiResponse.completed(res.docs);
      } else {
        setUserOrders = ApiResponse.completed(null);
      }
    } catch (e) {
      setUserOrders = ApiResponse.error(e.toString());
    }
    if (isNotifify) {
      notifyListeners();
    }
  }
}
