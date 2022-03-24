import 'dart:convert';

class FAQContentWrapper {
  FAQContentWrapper({
    this.du,
    this.en,
  });

  List<FAQContent>? du;
  List<FAQContent>? en;

  factory FAQContentWrapper.fromRawJson(String str) =>
      FAQContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQContentWrapper.fromJson(Map<String, dynamic> json) =>
      FAQContentWrapper(
        du: json["du"] == null
            ? null
            : List<FAQContent>.from(
                json["du"].map((x) => FAQContent.fromJson(x))),
        en: json["en"] == null
            ? null
            : List<FAQContent>.from(
                json["en"].map((x) => FAQContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "du":
            du == null ? null : List<dynamic>.from(du!.map((x) => x.toJson())),
        "en":
            en == null ? null : List<dynamic>.from(en!.map((x) => x.toJson())),
      };
}

class FAQContent {
  FAQContent({this.question, this.title, this.answer, this.isActive});

  String? question;
  String? title;
  String? answer;
  bool? isActive;
  factory FAQContent.fromRawJson(String str) =>
      FAQContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQContent.fromJson(Map<String, dynamic> json) => FAQContent(
        question: json["question"],
        title: json["title"],
        answer: json["answer"],
        isActive: false,
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "title": title,
        "answer": answer,
      };
}
