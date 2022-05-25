import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/wrappers/faq_wrapper.dart';

class FaqProvider extends ChangeNotifier {
  ApiResponse _faqs = ApiResponse.loading();

  ApiResponse get faqs => _faqs;

  set setFaqWrapper(ApiResponse faqs) {
    _faqs = faqs;
  }

  Future<void> fetchFaqs() async {
    try {
      setFaqWrapper = ApiResponse.loading();
      notifyListeners();
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.baseUrl;
      var response = await serviceLocatorInstance<DioApiServices>()
          .getRequest(HTTPConstants.faq);
      List<FAQContentModel> _faqs = [];
      for (var e in response as List<dynamic>) {
        _faqs.add(FAQContentModel.fromJson(e));
      }
      setFaqWrapper = ApiResponse.completed(_faqs);
    } catch (e) {
      setFaqWrapper = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
