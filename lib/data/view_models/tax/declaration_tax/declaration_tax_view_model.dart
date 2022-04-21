import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/constants/strings/string_constants.dart';
import 'package:steuermachen/data/repositories/remote/safe_and_declaration_tax_repository.dart';
import 'package:steuermachen/data/view_models/payment_gateway/payment_gateway_provider.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/data/view_models/profile/profile_provider.dart';
import 'package:steuermachen/data/view_models/signature/signature_provider.dart';
import 'package:steuermachen/data/view_models/tax_calculator_provider.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/utils/utils.dart';
import 'package:steuermachen/wrappers/common_response_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_data_collector_wrapper.dart';
import 'package:steuermachen/wrappers/declaration_tax/declaration_tax_view_wrapper.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumup_checkout_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';

class DeclarationTaxViewModel extends ChangeNotifier {
  late ApiResponse _viewData = ApiResponse.loading();
  ApiResponse get viewData => _viewData;
  set setViewData(ApiResponse viewData) {
    _viewData = viewData;
  }

  late ApiResponse _taxFiledYears = ApiResponse.loading();
  ApiResponse get taxFiledYears => _taxFiledYears;
  set setTaxFiledYears(ApiResponse taxFiledYears) {
    _taxFiledYears = taxFiledYears;
  }

  final SafeAndDeclarationTaxDataCollectorWrapper?
      _declarationTaxDataCollectorWrapper =
      SafeAndDeclarationTaxDataCollectorWrapper();
  SafeAndDeclarationTaxDataCollectorWrapper? get dataCollectorWrapper =>
      _declarationTaxDataCollectorWrapper;

  Future<void> fetchDeclarationTaxViewData() async {
    try {
      setViewData = ApiResponse.loading();
      notifyListeners();
      var res = await serviceLocatorInstance<SafeAndDeclarationTaxRepository>()
          .fetchDeclarationTaxViewData();
      Map<String, dynamic> x = res.data() as Map<String, dynamic>;
      DeclarationTaxViewWrapper declarationTaxWrapper =
          DeclarationTaxViewWrapper.fromJson(x);
      setViewData = ApiResponse.completed(declarationTaxWrapper);
    } catch (e) {
      setViewData = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }

  Future<CommonResponseWrapper> addDeclarationTaxViewData() async {
    try {
      await serviceLocatorInstance<SafeAndDeclarationTaxRepository>()
          .addDeclarationTaxViewData();
      return CommonResponseWrapper(
          status: true, message: StringConstants.success);
    } catch (e) {
      return CommonResponseWrapper(
          status: true, message: LocaleKeys.somethingWentWrong.tr());
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

  setTaxPrice(String taxPrice) {
    _declarationTaxDataCollectorWrapper?.taxPrice = taxPrice;
  }

  Future<CommonResponseWrapper> submitDeclarationTaxData(BuildContext context,
      {bool isCurrentYear = false, String? taxPrice}) async {
    PaymentGateWayProvider _paymentProvider =
        Provider.of<PaymentGateWayProvider>(context, listen: false);
    if (isCurrentYear) {
      _setCurrentYearTax(context, taxPrice!);
    } else {
      await _setDataDeclarationTax(context);
    }
    try {
      Map<String, dynamic> data = {
        ..._declarationTaxDataCollectorWrapper!
            .toJson(isCurrentYear ? "currentYear" : "declarationTax", taxSteps),
        "payment_type": "billing",
        "payment_info": null,
        "approved_by": null,
      };
      if (_paymentProvider.isCardPayment) {
        ApiResponse apiResponse = await _paymentProvider.completeCheckout();
        if (apiResponse.status == Status.completed) {
          SumpupCheckoutWrapper checkoutWrapper = apiResponse.data;
          data["payment_info"] = checkoutWrapper.toJson();
          data["payment_type"] = "card";
          await serviceLocatorInstance<SafeAndDeclarationTaxRepository>()
              .submitDeclarationTax(data);
          _paymentProvider.isCardPayment = false;
        } else {
          return CommonResponseWrapper(
              status: false, message: apiResponse.message);
        }
      } else {
        await serviceLocatorInstance<SafeAndDeclarationTaxRepository>()
            .submitDeclarationTax(data);
      }
      return CommonResponseWrapper(
          status: true, message: StringConstants.thankYouForOrder);
    } catch (e) {
      return CommonResponseWrapper(
          status: false, message: LocaleKeys.somethingWentWrong.tr());
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

  Future<void> _setDataDeclarationTax(BuildContext context) async {
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

  Future<void> _setCurrentYearTax(BuildContext context, String taxPrice) async {
    ProfileProvider _user =
        Provider.of<ProfileProvider>(context, listen: false);
    _declarationTaxDataCollectorWrapper?.userInfo =
        _user.getUserFromControllers();
    _declarationTaxDataCollectorWrapper?.userAddress = _user.getSelectedAddress;
    _declarationTaxDataCollectorWrapper?.termsAndConditionChecked = true;
    _declarationTaxDataCollectorWrapper?.grossIncome = taxPrice;
  }

  Future<void> fetchTaxFiledYears() async {
    try {
      setTaxFiledYears = ApiResponse.loading();
      notifyListeners();
      var res = await serviceLocatorInstance<SafeAndDeclarationTaxRepository>()
          .fetchTaxFiledYears();
      if (res.docs.isNotEmpty) {
        setTaxFiledYears = ApiResponse.completed(res.docs);
      } else {
        setTaxFiledYears = ApiResponse.completed(null);
      }
    } catch (e) {
      setTaxFiledYears = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
