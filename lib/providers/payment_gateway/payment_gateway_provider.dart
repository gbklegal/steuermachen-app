import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumup_checkout_wrapper.dart';
import '../../constants/strings/http_constants.dart';
import '../../main.dart';
import '../../services/networks/dio_api_services.dart';
import '../../services/networks/dio_client_network.dart';
import '../../wrappers/payment_gateway/sumpup_access_token_wrapper.dart';

class PaymentGateWayProvider extends ChangeNotifier {
  final String _clientSecret =
      "cc_sk_classic_9EzSNuTJGPXEMvV0x6oUVf6BHXYsXSHnyLjbAf0PJVD8BvwYOV";
  final String _clientId = "cc_classic_1ILMHC5QQEkd4ZK4jkVKIhRuJHHXP";
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  Future<ApiResponse> fetchAccessToken() async {
    try {
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.sumpBaseUrl;
      var response = await serviceLocatorInstance<DioApiServices>()
          .postRequest(HTTPConstants.sumupAccessToken, data: {
        'grant_type': 'client_credentials',
        'client_id': _clientId,
        'client_secret': _clientSecret,
      });
      return ApiResponse.completed(SumpupAccessTokenWrapper.fromJson(response));
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> createCheckout(String accessToken, int amount) async {
    try {
      serviceLocatorInstance<DioClientNetwork>()
          .dio
          .options
          .headers["Authorization"] = "Bearer " + accessToken;
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.sumpBaseUrl;
      var response = await serviceLocatorInstance<DioApiServices>()
          .postRequest(HTTPConstants.sumupCheckOuts, data: {
        'checkout_reference': getCheckoutReference(15),
        'amount': amount,
        'currency': "EUR",
        "pay_to_email": "dialog@steuermachen.de",
        "description": "Sample one-time payment"
      });
      return ApiResponse.completed(SumpupCheckoutWrapper.fromJson(response));
    } catch (e) {
      print(e);
      return ApiResponse.error(e.toString());
    }
  }

  String getCheckoutReference(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

// curl -X POST \
//   https://api.sumup.com/v0.1/checkouts \
//   -H 'Authorization: Bearer 565e2d19cef68203170ddadb952141326d14e03f4ccbd46daa079c26c910a864' \
//   -H 'Content-Type: application/json' \
//   -d '{
//         "checkout_reference": "CO746453",
//         "amount": 10,
//         "currency": "EUR",
//         "pay_to_email": "docuser@sumup.com",
//         "description": "Sample one-time payment"
//       }'