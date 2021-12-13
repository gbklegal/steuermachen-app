import 'dart:convert';

class HowItWorksContentWrapper {
  HowItWorksContentWrapper({
    this.du,
    this.en,
  });

  List<HowItWorkContent>? du;
  List<HowItWorkContent>? en;

  factory HowItWorksContentWrapper.fromRawJson(String str) =>
      HowItWorksContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HowItWorksContentWrapper.fromJson(Map<String, dynamic> json) =>
      HowItWorksContentWrapper(
        du: json["du"] == null ? null: List<HowItWorkContent>.from(json["du"].map((x) => HowItWorkContent.fromJson(x))),
        en: json["en"] == null
            ? null
            : List<HowItWorkContent>.from(json["en"].map((x) => HowItWorkContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "du": du == null ? null : List<dynamic>.from(du!.map((x) => x.toJson())),
        "en": en == null ? null : List<dynamic>.from(en!.map((x) => x.toJson())),
      };
}

class HowItWorkContent {
  HowItWorkContent({
    this.title,
    this.text,
  });

  String? title;
  String? text;

  factory HowItWorkContent.fromRawJson(String str) => HowItWorkContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HowItWorkContent.fromJson(Map<String, dynamic> json) => HowItWorkContent(
        title: json["title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
      };
}
