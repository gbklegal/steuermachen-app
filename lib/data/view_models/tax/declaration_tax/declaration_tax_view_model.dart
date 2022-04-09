import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/repositories/remote/safe_and_declaration_tax_repository.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/data/view_models/tax_calculator_provider.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_view_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class DeclarationTaxViewModel extends ChangeNotifier {
  final SafeAndDeclarationTaxDataCollectorWrapper?
      _declarationTaxDataCollectorWrapper =
      SafeAndDeclarationTaxDataCollectorWrapper();
  SafeAndDeclarationTaxDataCollectorWrapper? get dataCollectorWrapper =>
      _declarationTaxDataCollectorWrapper;
  bool _busyStateDeclarationTax = true;
  bool get getBusyStateDeclarationTax => _busyStateDeclarationTax;
  set setBusyStateDeclarationTax(bool _isBusy) {
    _busyStateDeclarationTax = _isBusy;
    notifyListeners();
  }

  Future<CommonResponseWrapper> getDeclarationTaxViewData() async {
    try {
      setBusyStateDeclarationTax = true;
      var res =
          await firestore.collection("declaration_tax").doc("content").get();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      DeclarationTaxViewWrapper declarationTaxWrapper =
          DeclarationTaxViewWrapper.fromJson(x);
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(status: true, data: declarationTaxWrapper);
    } catch (e) {
      setBusyStateDeclarationTax = false;
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  //Execute this function for adding UI view in firestore
  // JSON//filepath: declaration_tax_view.json
  Future<CommonResponseWrapper> addDeclarationTaxViewData() async {
    try {
      // await firestore.collection("declaration_tax").doc("content").set(json);
      return CommonResponseWrapper(
          status: true,
          message: "declaration tax view data added successfully");
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  setTaxYear(String year) {
    _declarationTaxDataCollectorWrapper?.taxYear = year;
  }

  setMartialStatus(String status) {
    _declarationTaxDataCollectorWrapper?.martialStatus = status;
  }

  setIncome(String income) {
    _declarationTaxDataCollectorWrapper?.grossIncome = income;
  }

  Future<CommonResponseWrapper> submitDeclarationTaxData(
      BuildContext context) async {
    await _setData(context);
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await firestore
          .collection("user_orders")
          .doc("${user?.uid}")
          .collection("safe_and_declaration_tax")
          .add({
        ..._declarationTaxDataCollectorWrapper!.toJson(),
        "created_at": DateTime.now(),
        "tax_name": "declarationTax",
        "steps": taxSteps.map((e) => e.toJson()).toList(),
        "status": ProcessConstants.pending,
        "approved_by": null,
      });
      return CommonResponseWrapper(
          status: true, message: StringConstants.thankYouForOrder);
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: ErrorMessagesConstants.somethingWentWrong);
    }
  }

  sendMail() async {
    serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
        HTTPConstants.baseUrl;
    serviceLocatorInstance<DioClientNetwork>()
            .dio
            .options
            .headers["Authorization"] =
        "Bearer " + HTTPConstants.defaultAccessToken;
    var response = await serviceLocatorInstance<DioApiServices>()
        .postRequest(HTTPConstants.sendMail,
            // options: Options(headers: {
            //   "Authorization": "Bearer ${HTTPConstants.defaultAccessToken}"
            // }),
            data: {
          "to": "osama.asif20@gmail.com",
          "subject": "You tax has been submitted",
          "message": "Test meesage"
        });
    print(response);
  }

  Future<void> _setData(BuildContext context) async {
    SignatureProvider _signature =
        Provider.of<SignatureProvider>(context, listen: false);
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    TaxCalculatorProvider _tax =
        Provider.of<TaxCalculatorProvider>(context, listen: false);
    String signaturePath = await Utils.uploadToFirebaseStorage(
        await _signature.getSignaturePath());
    _declarationTaxDataCollectorWrapper?.signaturePath = signaturePath;
    _declarationTaxDataCollectorWrapper?.userInfo =
        _user.getUserFromControllers();
    _declarationTaxDataCollectorWrapper?.userAddress = _user.getSelectedAddress;
    _declarationTaxDataCollectorWrapper?.termsAndConditionChecked = true;
    _declarationTaxDataCollectorWrapper?.grossIncome = _tax.selectedPrice;
  }

  Future<CommonResponseWrapper?> checkTaxIsAlreadySubmit() async {
    try {
      var res = await serviceLocatorInstance<SafeAndDeclarationTaxRepository>()
          .fetchTaxFiledYears();
      if (res.docs.isNotEmpty) {
        return CommonResponseWrapper(
          status: true,
          data: res.docs,
          message: LocaleKeys.alreadySubmittedTax.tr(),
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
