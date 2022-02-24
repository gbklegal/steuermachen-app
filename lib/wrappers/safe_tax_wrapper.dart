class SafeTaxWrapper {
  SafeTaxWrapper({
    required this.en,
    required this.du,
  });
  late final List<SafeTaxData> en;
  late final List<SafeTaxData> du;

  SafeTaxWrapper.fromJson(Map<String, dynamic> json) {
    en = List.from(json['en']).map((e) => SafeTaxData.fromJson(e)).toList();
    du = List.from(json['du']).map((e) => SafeTaxData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.map((e) => e.toJson()).toList();
    _data['du'] = du.map((e) => e.toJson()).toList();
    return _data;
  }
}

class SafeTaxData {
  SafeTaxData({
    required this.title,
    required this.optionType,
    required this.options,
    required this.optionImgPath,
    required this.showBottomNav,
  });
  late final String title;
  late final String optionType;
  late final List<String> options;
  late final List<String> optionImgPath;
  late final bool showBottomNav;

  SafeTaxData.fromJson(Map<String, dynamic> json) {
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
