import 'dart:convert';

class SustainabilityContentWrapper {
  SustainabilityContentWrapper({
    this.du,
    this.en,
  });

  List<Content>? du;
  List<Content>? en;

  factory SustainabilityContentWrapper.fromRawJson(String str) =>
      SustainabilityContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SustainabilityContentWrapper.fromJson(Map<String, dynamic> json) =>
      SustainabilityContentWrapper(
        du: json["du"] == null ? null: List<Content>.from(json["du"].map((x) => Content.fromJson(x))),
        en: json["en"] == null
            ? null
            : List<Content>.from(json["en"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "du": du == null ? null : List<dynamic>.from(du!.map((x) => x.toJson())),
        "en": en == null ? null : List<dynamic>.from(en!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.title,
    this.text,
  });

  String? title;
  String? text;

  factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        title: json["title"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "text": text,
      };
}
