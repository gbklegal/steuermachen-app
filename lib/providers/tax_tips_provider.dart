import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/wrappers/faq_wp_wrapper.dart';

import '../services/networks/dio_client_network.dart';

class TaxTipsProvider extends ChangeNotifier {
  ApiResponse _taxTips = ApiResponse.loading();

  ApiResponse get taxTips => _taxTips;

  set setTaxTipsWrapper(ApiResponse taxTips) {
    _taxTips = taxTips;
  }

  Future<void> fetchTaxTips() async {
    try {
      setTaxTipsWrapper = ApiResponse.loading();
      notifyListeners();
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.baseUrl;
      var response = await serviceLocatorInstance<DioApiServices>()
          .getRequest(HTTPConstants.taxTips, queryParameters: {
        'page': '1',
        '_embed': null,
        '_fields': 'id,date,link,title,content,_links,_embedded',
      });
      List<TaxTipsWrapper> _tips = [];
      for (var e in response as List<dynamic>) {
        _tips.add(TaxTipsWrapper.fromJson(e));
      }
      setTaxTipsWrapper = ApiResponse.completed(_tips);
    } catch (e) {
      setTaxTipsWrapper = ApiResponse.error(e.toString());
    }
    notifyListeners();
  }
}
