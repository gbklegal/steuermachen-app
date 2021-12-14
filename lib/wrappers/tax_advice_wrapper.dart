import 'dart:convert';

class TaxAdviceContentWrapper {
  TaxAdviceContentWrapper({
    this.du,
    this.en,
  });

  TaxAdviceContent? du;
  TaxAdviceContent? en;

  factory TaxAdviceContentWrapper.fromRawJson(String str) =>
      TaxAdviceContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxAdviceContentWrapper.fromJson(Map<String, dynamic> json) =>
      TaxAdviceContentWrapper(
        du: json["du"] == null ? null : TaxAdviceContent.fromJson(json["du"]),
        en: json["en"] == null ? null : TaxAdviceContent.fromJson(json["en"]),
      );

  Map<String, dynamic> toJson() => {
        "du": du!.toJson(),
        "en": en!.toJson(),
      };
}

class TaxAdviceContent {
  TaxAdviceContent({
    this.title,
    this.subtitle,
    this.price,
    this.advicePoints,
  });

  String? title;
  String? subtitle;
  String? price;
  List<String>? advicePoints;

  factory TaxAdviceContent.fromRawJson(String str) =>
      TaxAdviceContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxAdviceContent.fromJson(Map<String, dynamic> json) =>
      TaxAdviceContent(
        title: json["title"],
        subtitle: json["subtitle"],
        price: json["price"],
        advicePoints: json["advice_points"] == null
            ? null
            : List<String>.from(json["advice_points"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "price": price,
        "advice_points": List<dynamic>.from(advicePoints!.map((x) => x)),
      };
}
