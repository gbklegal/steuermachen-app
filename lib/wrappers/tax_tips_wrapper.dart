import 'dart:convert';

class TaxTipsContentWrapper {
  TaxTipsContentWrapper({
    this.du,
    this.en,
  });

  List<TaxTipsContent>? du;
  List<TaxTipsContent>? en;

  factory TaxTipsContentWrapper.fromRawJson(String str) =>
      TaxTipsContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxTipsContentWrapper.fromJson(Map<String, dynamic> json) =>
      TaxTipsContentWrapper(
        du: json["du"] == null
            ? null
            : List<TaxTipsContent>.from(
                json["du"].map((x) => TaxTipsContent.fromJson(x))),
        en: json["en"] == null
            ? null
            : List<TaxTipsContent>.from(
                json["en"].map((x) => TaxTipsContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "du":
            du == null ? null : List<dynamic>.from(du!.map((x) => x.toJson())),
        "en":
            en == null ? null : List<dynamic>.from(en!.map((x) => x.toJson())),
      };
}

class TaxTipsContent {
  TaxTipsContent({
    this.title,
    this.subtitle,
    this.articleBy,
    this.readTime,
    this.publishedDate,
    this.image,
    this.content,
  });

  String? title;
  String? subtitle;
  String? articleBy;
  String? readTime;
  DateTime? publishedDate;
  String? image;
  String? content;

  factory TaxTipsContent.fromRawJson(String str) =>
      TaxTipsContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxTipsContent.fromJson(Map<String, dynamic> json) => TaxTipsContent(
        title: json["title"],
        subtitle: json["subtitle"],
        articleBy: json["article_by"],
        readTime: json["read_time"],
        publishedDate: json["published_date"].toDate(),
        image: json["image"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
      };
}
