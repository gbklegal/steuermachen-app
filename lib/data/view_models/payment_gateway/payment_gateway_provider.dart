import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumpup_access_token_wrapper.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumup_checkout_wrapper.dart';
import 'package:steuermachen/wrappers/payment_gateway/user_card_wrapper.dart';

class PaymentGateWayProvider extends ChangeNotifier {
  bool isCardPayment = false;
  dynamic paymentAmount;
  late SumpupCheckoutWrapper? checkoutWrapper;
  UserCardWrapper userCardInfo = UserCardWrapper(card: UserCardInfo());
  final String _clientSecret =
      "cc_sk_classic_HGg5OT0Wt7H9pdeii0xcJtQc8HEu0bbQzUQwcGyf96mIjgtUQv";
  final String _clientId = "cc_classic_1g0OhhPjpXX3msXUvIg35qLTlO3zy";
  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  Future<ApiResponse> fetchAccessToken() async {
    try {
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.sumpBaseUrl;
      var response = await serviceLocatorInstance<DioApiServices>().postRequest(
          HTTPConstants.sumupAccessToken,
          options: Options(contentType: 'application/x-www-form-urlencoded'),
          data: {
            'grant_type': 'client_credentials',
            'client_id': _clientId,
            'client_secret': _clientSecret,
            'scopes': [
              'payments',
              'transactions.history',
              'user.app-settings',
              'user.profile_readonly'
            ],
          });
      return ApiResponse.completed(SumpupAccessTokenWrapper.fromJson(response));
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> createCheckout(String accessToken, dynamic amount) async {
    try {
      // if (amount is double) {
      amount = double.parse(amount.toString());
      // }
      //  else {
      //   amount = int.parse(amount.toString());
      // }
      serviceLocatorInstance<DioClientNetwork>()
          .dio
          .options
          .headers["Authorization"] = "Bearer " + accessToken;
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.sumpBaseUrl;
      List<String> checkOutReferenceNo = await generateOrderNumber();
      var response = await serviceLocatorInstance<DioApiServices>()
          .postRequest(HTTPConstants.sumupCheckOuts, data: {
        'checkout_reference': checkOutReferenceNo[1],
        'amount': amount,
        'currency': "EUR",
        "pay_to_email": "dialog@steuermachen.de",
        "description": "Sample one-time payment"
      });
      checkoutWrapper?.orderNumber = checkOutReferenceNo[0];
      checkoutWrapper = SumpupCheckoutWrapper.fromJson(response);
      return ApiResponse.completed(checkoutWrapper);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse> completeCheckout() async {
    try {
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.sumpBaseUrl;
      userCardInfo.paymentType = "card";
      var response = await serviceLocatorInstance<DioApiServices>().postRequest(
          HTTPConstants.sumupCheckOuts + "/${checkoutWrapper?.id}",
          data: userCardInfo.toJson());
      checkoutWrapper = SumpupCheckoutWrapper.fromJson(response);
      return ApiResponse.completed(checkoutWrapper);
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<List<String>> generateOrderNumber() async {
    try {
      String orderNumber = "0";
      DocumentSnapshot event =
          await firestore.collection("order_number").doc("order_number").get();
      Map<String, dynamic>? data = event.data() as Map<String, dynamic>;
      orderNumber = data["number"];
      while (orderNumber.length < 4) {
        orderNumber = "0" + orderNumber;
      }
      String currentYear = DateTime.now().year.toString();
      int incrementOrderNumber = int.parse(data["number"]);
      await firestore
          .collection("order_number")
          .doc("order_number")
          .update({"number": (incrementOrderNumber + 1).toString()});
      String formattedOrderNumber = currentYear + orderNumber;
      String formattedInvoiceNumber =
          "AS" + currentYear.replaceAll("20", "-") + "-" + orderNumber;
      return [formattedOrderNumber, formattedInvoiceNumber];
    } catch (e) {
      rethrow;
    }
  }

  String getCheckoutReference(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}
