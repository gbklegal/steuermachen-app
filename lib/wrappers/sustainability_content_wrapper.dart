import 'dart:convert';

class SustainabilityContentWrapper {
  SustainabilityContentWrapper({
    this.du,
    this.en,
  });

  List<SustainContent>? du;
  List<SustainContent>? en;

  factory SustainabilityContentWrapper.fromRawJson(String str) =>
      SustainabilityContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SustainabilityContentWrapper.fromJson(Map<String, dynamic> json) =>
      SustainabilityContentWrapper(
        du: json["du"] == null ? null: List<SustainContent>.from(json["du"].map((x) => SustainContent.fromJson(x))),
        en: json["en"] == null
            ? null
            : List<SustainContent>.from(json["en"].map((x) => SustainContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "du": du == null ? null : List<dynamic>.from(du!.map((x) => x.toJson())),
        "en": en == null ? null : List<dynamic>.from(en!.map((x) => x.toJson())),
      };
}

class SustainContent {
  SustainContent({
    this.title,
    this.text,
  });

  String? title;
  String? text;

  factory SustainContent.fromRawJson(String str) => SustainContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SustainContent.fromJson(Map<String, dynamic> json) => SustainContent(
        title: json["title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
      };
}
