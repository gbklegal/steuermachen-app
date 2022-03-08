class DocumentOptionsWrappers {
  DocumentOptionsWrappers({
    required this.en,
    required this.du,
  });
  late final List<DocumentOptionsData> en;
  late final List<DocumentOptionsData> du;

  DocumentOptionsWrappers.fromJson(Map<String, dynamic> json) {
    en = List.from(json['en'])
        .map((e) => DocumentOptionsData.fromJson(e))
        .toList();
    du = List.from(json['du'])
        .map((e) => DocumentOptionsData.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en.map((e) => e.toJson()).toList();
    _data['du'] = du.map((e) => e.toJson()).toList();
    return _data;
  }
}

class DocumentOptionsData {
  DocumentOptionsData({
    required this.optionType,
    required this.options,
  });
  late final String optionType;
  late final List<String> options;

  DocumentOptionsData.fromJson(Map<String, dynamic> json) {
    optionType = json['option_type'];
    options = List.castFrom<dynamic, String>(json['options']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['option_type'] = optionType;
    _data['options'] = options;
    return _data;
  }
}
