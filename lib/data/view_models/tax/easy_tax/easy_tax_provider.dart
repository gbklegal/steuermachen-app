import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/email_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/data/repositories/remote/email_repository.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/easy_tax/easy_tax_wrapper.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumup_checkout_wrapper.dart';
import 'package:steuermachen/wrappers/send_mail_model.dart';

class EasyTaxProvider extends ChangeNotifier {
  final EasyTaxDataCollectorWrapper? _easyTaxDataCollectorWrapper =
      EasyTaxDataCollectorWrapper();

  EasyTaxDataCollectorWrapper? get easyTaxDataCollectorWrapper =>
      _easyTaxDataCollectorWrapper;

  bool _busyStateEasyTax = true;
  bool get getBusyStateEasyTax => _busyStateEasyTax;
  set setBusyStateEasyTax(bool _isBusy) {
    _busyStateEasyTax = _isBusy;
    notifyListeners();
  }

  setSubscriptionPrice(double amount) {
    _easyTaxDataCollectorWrapper?.subscriptionPrice = amount;
  }

  Future<CommonResponseWrapper> getEasyTaxViewData() async {
    try {
      setBusyStateEasyTax = true;
      var res = await firestore.collection("easy_tax").doc("content-v1").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      EasyTaxWrapper easyTaxWrapper = EasyTaxWrapper.fromJson(x);
      setBusyStateEasyTax = false;
      return CommonResponseWrapper(status: true, data: easyTaxWrapper);
    } catch (e) {
      setBusyStateEasyTax = false;
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: easy_tax_view.json
  Future<CommonResponseWrapper> addEasyTaxViewData() async {
    try {
      await firestore.collection("easy_tax").doc("content-v1").set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: easy_tax_initial_view.json
  Future<CommonResponseWrapper> addEasyTaxInitialViewData() async {
    try {
      // await firestore
      //     .collection("easy_tax")
      //     .doc("initial_view_content")
      //     .set(json);
      return CommonResponseWrapper(
          status: true, message: "easy tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.somethingWentWrong.tr());
    }
  }

  Future<CommonResponseWrapper> submitEasyTaxData(BuildContext context) async {
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    PaymentGateWayProvider _paymentProvider =
        Provider.of<PaymentGateWayProvider>(context, listen: false);
    _easyTaxDataCollectorWrapper?.userInfo = _user.getUserFromControllers();
    _easyTaxDataCollectorWrapper?.userAddress = _user.getSelectedAddress;
    _easyTaxDataCollectorWrapper?.termsAndConditionChecked = true;
    _easyTaxDataCollectorWrapper?.taxYear = DateTime.now().year.toString();
    try {
      User? user = FirebaseAuth.instance.currentUser;
      Map<String, dynamic> data = {
        ..._easyTaxDataCollectorWrapper!.toJson(),
        "created_at": DateTime.now(),
        "status": ProcessConstants.pending,
        "payment_type": "billing",
        "payment_info": null,
        "approved_by": null,
      };
      DocumentReference<Map<String, dynamic>> firestoreResponse;
      if (_paymentProvider.isCardPayment) {
        ApiResponse apiResponse = await _paymentProvider.completeCheckout();
        if (apiResponse.status == Status.completed) {
          SumpupCheckoutWrapper checkoutWrapper = apiResponse.data;
          data["payment_info"] = checkoutWrapper.toJson();
          data["payment_type"] = "card";
          data['checkout_reference'] = checkoutWrapper.checkoutReference;
          _easyTaxDataCollectorWrapper?.checkOutReference =
              checkoutWrapper.checkoutReference;
          firestoreResponse = await firestore
              .collection("user_orders")
              .doc("${user?.uid}")
              .collection("easy_tax")
              .add(data);
          _paymentProvider.isCardPayment = false;
        } else {
          return CommonResponseWrapper(
              status: false, message: apiResponse.message);
        }
      } else {
        data['checkout_reference'] = _paymentProvider.getCheckoutReference(10);
        _easyTaxDataCollectorWrapper?.checkOutReference =
            _paymentProvider.getCheckoutReference(10);
        firestoreResponse = await firestore
            .collection("user_orders")
            .doc("${user?.uid}")
            .collection("easy_tax")
            .add(data);
      }

      SendMailModel? sendMailResponse = await EmailRepository().sendMail(
          _easyTaxDataCollectorWrapper!.userInfo!.email!,
          EmailInvoiceConstants.orderSubject,
          EmailInvoiceConstants.steuerEASY,
          salutation: _easyTaxDataCollectorWrapper!.userInfo!.gender,
          lastName: _easyTaxDataCollectorWrapper!.userInfo!.lastName,
          orderNumber: _easyTaxDataCollectorWrapper!.checkOutReference,
          taxYear: _easyTaxDataCollectorWrapper!.taxYear,
          totalPrice: _easyTaxDataCollectorWrapper!.subscriptionPrice,
          sendInvoice: true,
          invoiceTemplate: EmailInvoiceConstants.steuerEASY,
          templatePdf: EmailInvoiceConstants.steuerEasyPdf);

      await EmailRepository().sendMail("dialog@steuermachen.de",
          EmailInvoiceConstants.orderSubject, EmailInvoiceConstants.steuerEASY,
          salutation: _easyTaxDataCollectorWrapper!.userInfo!.gender,
          lastName: _easyTaxDataCollectorWrapper!.userInfo!.lastName,
          orderNumber: _easyTaxDataCollectorWrapper!.checkOutReference,
          taxYear: _easyTaxDataCollectorWrapper!.taxYear,
          totalPrice: _easyTaxDataCollectorWrapper!.subscriptionPrice,
          sendInvoice: true,
          invoiceTemplate: EmailInvoiceConstants.steuerEASY,
          templatePdf: EmailInvoiceConstants.steuerEasyPdf);
      if (sendMailResponse != null) {
        firestoreResponse.update({
          "invoices_path": [sendMailResponse.pdf.url]
        });
      }
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.thankYouForOrder.tr());
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
    }
  }
}

var json = {
  "en": [
    {
      "title": "",
      "option_type": "initial_screen",
      "options": [],
      "option_img_path": [],
      "content": {
        "page_title": "Your price for an initial consultation",
        "title": "Inexpensive initial consultation - order taxEASY now!",
        "price": 25.00,
        "currency_symbol": "€",
        "subtitle": "only for initial tax advice",
        "buttonText": "Order now for a fee",
        "advice_points": [
          "Individually to your tax question",
          "Modern digital from anywhere ",
          "Guaranteed security"
        ]
      },
      "show_bottom_nav": false
    },
    {
      "title": "Check your personal information\nsalutation",
      "option_type": "user_form",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": true
    },
    {
      "title": "",
      "option_type": "payment_methods",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "confirm_billing",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "terms_and_condition",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    }
  ],
  "du": [
    {
      "title": "",
      "option_type": "initial_screen",
      "options": [],
      "option_img_path": [],
      "content": {
        "page_title": "Dein Preis für eine Erstberatung",
        "title": "Kostengünstige Erstberatung - jetzt taxEASY bestellen!",
        "price": 25.00,
        "currency_symbol": "€",
        "subtitle": "nur für steuerliche Erstberatung",
        "buttonText": "Jetzt kostenpflichtig beauftragen",
        "advice_points": [
          "Individuell auf deine Steuerfrage",
          "Modern digital von überall ",
          "Garantierte Sicherheit"
        ]
      },
      "show_bottom_nav": false
    },
    {
      "title": "Check your personal information\nsalutation",
      "option_type": "user_form",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": true
    },
    {
      "title": "",
      "option_type": "payment_methods",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "confirm_billing",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    },
    {
      "title": "",
      "option_type": "terms_and_condition",
      "options": [],
      "option_img_path": [],
      "show_bottom_nav": false
    }
  ]
};
