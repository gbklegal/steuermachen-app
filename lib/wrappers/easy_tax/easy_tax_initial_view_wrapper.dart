class EasyTaxInitialViewWrapper {
  EasyTaxInitialViewWrapper({
    required this.en,
    required this.du,
  });
  late final EasyTaxInitialViewData en;
  late final EasyTaxInitialViewData du;

  EasyTaxInitialViewWrapper.fromJson(Map<String, dynamic> json) {
    en = EasyTaxInitialViewData.fromJson(json['en']);
    du = EasyTaxInitialViewData.fromJson(json['du']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.toJson();
    _data['du'] = du.toJson();
    return _data;
  }
}

class EasyTaxInitialViewData {
  EasyTaxInitialViewData({
    required this.pageTitle,
    required this.title,
    required this.price,
    required this.subtitle,
    required this.buttonText,
    required this.advicePoints,
  });
  late final String pageTitle;
  late final String title;
  late final String price;
  late final String subtitle;
  late final String buttonText;
  late final List<String> advicePoints;

  EasyTaxInitialViewData.fromJson(Map<String, dynamic> json) {
    pageTitle = json['page_title'];
    title = json['title'];
    price = json['price'];
    subtitle = json['subtitle'];
    buttonText = json['buttonText'];
    advicePoints = List.castFrom<dynamic, String>(json['advice_points']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page_title'] = pageTitle;
    _data['title'] = title;
    _data['price'] = price;
    _data['subtitle'] = subtitle;
    _data['buttonText'] = buttonText;
    _data['advice_points'] = advicePoints;
    return _data;
  }
}
