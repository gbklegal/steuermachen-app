class QuickTaxWrapper {
  QuickTaxWrapper({
    required this.en,
    required this.du,
  });
  late final List<QuickTaxData> en;
  late final List<QuickTaxData> du;
  
  QuickTaxWrapper.fromJson(Map<String, dynamic> json){
    en = List.from(json['en']).map((e)=>QuickTaxData.fromJson(e)).toList();
    du = List.from(json['du']).map((e)=>QuickTaxData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.map((e)=>e.toJson()).toList();
    _data['du'] = du.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class QuickTaxData {
  QuickTaxData({
    required this.title,
    required this.optionType,
    required this.options,
    required this.inputTitle,
    required this.inputType,
    required this.showBottomNav,
  });
  late final String title;
  late final String optionType;
  late final List<String> options;
  late final String inputTitle;
  late final String inputType;
  late final bool showBottomNav;
  
  QuickTaxData.fromJson(Map<String, dynamic> json){
    title = json['title'];
    optionType = json['option_type'];
    options = List.castFrom<dynamic, String>(json['options']);
    inputTitle = json['input_title'];
    inputType = json['input_type'];
    showBottomNav = json['show_bottom_nav'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['option_type'] = optionType;
    _data['options'] = options;
    _data['input_title'] = inputTitle;
    _data['input_type'] = inputType;
    _data['show_bottom_nav'] = showBottomNav;
    return _data;
  }
}
