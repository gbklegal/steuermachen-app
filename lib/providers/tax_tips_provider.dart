import 'package:flutter/material.dart';
import 'package:steuermachen/wrappers/faq_wp_wrapper.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class TaxTipsProvider extends ChangeNotifier {
  List<TaxTipsWrapper>? _taxTipsWrapper;

  List<TaxTipsWrapper>? get taxTipsWrapper => _taxTipsWrapper;

  set setTaxTipsWrapper(List<TaxTipsWrapper> taxTipsWrapper) {
    _taxTipsWrapper = taxTipsWrapper;
  }

  Future<List<TaxTipsWrapper>?> fetchTaxTips() async {
    try {
      var url = Uri.https('steuermachen.de', '/wp-json/wp/v2/posts', {
        'page': '1',
        '_embed': null,
        '_fields': 'id,date,link,title,content,_links,_embedded',
      });

      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        List<TaxTipsWrapper> _tips = [];
        for (var e in jsonResponse) {
          _tips.add(TaxTipsWrapper.fromJson(e));
        }
        print('Number of books about http: $_taxTipsWrapper');
        return setTaxTipsWrapper = _tips;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
