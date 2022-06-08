import 'package:flutter/material.dart';
import 'package:steuermachen/constants/strings/http_constants.dart';
import 'package:steuermachen/main.dart';
import 'package:steuermachen/services/networks/api_response_states.dart';
import 'package:steuermachen/services/networks/dio_api_services.dart';
import 'package:steuermachen/services/networks/dio_client_network.dart';
import 'package:steuermachen/wrappers/tax_tips_wp_wrapper.dart';

class TaxTipsProvider extends ChangeNotifier {
  int _currentPage = 1;

  int get currentPage => _currentPage;

  set setCurrentPage(int currentPage) {
    _currentPage = currentPage;
  }

  bool _isAllRecordFetched = false;

  bool get isAllRecordFetched => _isAllRecordFetched;

  set setIsAllRecordFetched(bool isAllRecordFetched) {
    _isAllRecordFetched = isAllRecordFetched;
  }

  ApiResponse _taxTips = ApiResponse.loading();

  ApiResponse get taxTips => _taxTips;

  set setTaxTipsWrapper(ApiResponse taxTips) {
    _taxTips = taxTips;
  }

  Future<void> fetchTaxTips({required int page, bool isLoader = true}) async {
    try {
      if (isLoader) {
        setTaxTipsWrapper = ApiResponse.loading();
        notifyListeners();
      }
      serviceLocatorInstance<DioClientNetwork>().dio.options.baseUrl =
          HTTPConstants.baseUrl;
      var response = await serviceLocatorInstance<DioApiServices>()
          .getRequest(HTTPConstants.taxTips, queryParameters: {
        'page': page,
        '_embed': null,
        '_fields': 'id,date,link,title,content,_links,_embedded',
      });
      List<TaxTipsWrapper> _tips = [];
      for (var e in response as List<dynamic>) {
        _tips.add(TaxTipsWrapper.fromJson(e));
      }
      if (_currentPage > 1) {
        List<TaxTipsWrapper> _temp = [..._taxTips.data, ..._tips];
        setTaxTipsWrapper = ApiResponse.completed(_temp);
      } else {
        setTaxTipsWrapper = ApiResponse.completed(_tips);
      }
    } catch (e) {
      if (e.toString() == "Bad Request") {
        setIsAllRecordFetched = true;
        if (isAllRecordFetched) {
          setTaxTipsWrapper = ApiResponse.completed(_taxTips.data);
        }
      } else {
        setTaxTipsWrapper = ApiResponse.error(e.toString());
      }
    }
    notifyListeners();
  }
}
