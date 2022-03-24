class EasyTaxWrapper {
  EasyTaxWrapper({
    required this.en,
    required this.du,
  });
  late final List<EasyTaxData> en;
  late final List<EasyTaxData> du;

  EasyTaxWrapper.fromJson(Map<String, dynamic> json) {
    en = List.from(json['en']).map((e) => EasyTaxData.fromJson(e)).toList();
    du = List.from(json['du']).map((e) => EasyTaxData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.map((e) => e.toJson()).toList();
    _data['du'] = du.map((e) => e.toJson()).toList();
    return _data;
  }
}

class EasyTaxData {
  EasyTaxData({
    required this.title,
    required this.optionType,
    required this.options,
    required this.optionImgPath,
    required this.showBottomNav,
  });
  late final String title;
  late final String optionType;
  late final List<dynamic> options;
  late final List<dynamic> optionImgPath;
  late final bool showBottomNav;

  EasyTaxData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    optionType = json['option_type'];
    options = List.castFrom<dynamic, String>(json['options']);
    optionImgPath = List.castFrom<dynamic, String>(json['option_img_path']);
    showBottomNav = json['show_bottom_nav'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['option_type'] = optionType;
    _data['options'] = options;
    _data['option_img_path'] = optionImgPath;
    _data['show_bottom_nav'] = showBottomNav;
    return _data;
  }
}
