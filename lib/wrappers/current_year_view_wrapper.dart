class CurrentYearViewWrapper {
  CurrentYearViewWrapper({
    required this.en,
    required this.du,
  });
  late final CurrentYearViewData en;
  late final CurrentYearViewData du;

  CurrentYearViewWrapper.fromJson(Map<String, dynamic> json) {
    en = CurrentYearViewData.fromJson(json['en']);
    du = CurrentYearViewData.fromJson(json['du']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.toJson();
    _data['du'] = du.toJson();
    return _data;
  }
}

class CurrentYearViewData {
  CurrentYearViewData({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.points,
    required this.showBottomNav,
  });
  late final String title;
  late final String subtitle;
  late final double price;
  late final List<String> points;
  late final bool showBottomNav;

  CurrentYearViewData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    price = double.parse(json['price'].toString());
    points = List.castFrom<dynamic, String>(json['points']);
    showBottomNav = json['show_bottom_nav'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['subtitle'] = subtitle;
    _data['price'] = price;
    _data['points'] = points;
    _data['show_bottom_nav'] = showBottomNav;
    return _data;
  }
}
