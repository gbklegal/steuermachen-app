class FinanceLawViewWrapper {
  FinanceLawViewWrapper({
    required this.en,
    required this.du,
  });
  late FinanceViewData en;
  late FinanceViewData du;

  FinanceLawViewWrapper.fromJson(Map<String, dynamic> json) {
    en = FinanceViewData.fromJson(json['en']);
    du = FinanceViewData.fromJson(json['du']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.toJson();
    _data['du'] = du.toJson();
    return _data;
  }
}

class FinanceViewData {
  FinanceViewData({
    required this.title,
    required this.subtitle,
    required this.options,
    required this.thirdTitle,
    required this.showBottomNav,
  });
  late final String title;
  late final String subtitle;
  late final List<Options> options;
  late final String thirdTitle;
  late final bool showBottomNav;

  FinanceViewData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    options = List.from(json['options']).map((e) => Options.fromJson(e)).toList();
    thirdTitle = json['thirdTitle'];
    showBottomNav = json['show_bottom_nav'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['options'] = options.map((e) => e.toJson()).toList();
    _data['thirdTitle'] = thirdTitle;
    _data['show_bottom_nav'] = showBottomNav;
    return _data;
  }
}

class Options {
  Options({
    required this.type,
    required this.title,
    required this.isSelect,
  });
  late final String type;
  late final String title;
  late bool isSelect;

  Options.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    isSelect = json['isSelect'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['isSelect'] = isSelect;
    return _data;
  }
}
