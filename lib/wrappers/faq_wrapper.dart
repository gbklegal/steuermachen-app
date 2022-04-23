import 'dart:convert';

class FAQContentWrapper {
  FAQContentWrapper({
    this.du,
    this.en,
  });

  FAQContent? du;
  FAQContent? en;

  factory FAQContentWrapper.fromRawJson(String str) =>
      FAQContentWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQContentWrapper.fromJson(Map<String, dynamic> json) =>
      FAQContentWrapper(
        du: FAQContent.fromJson(json["du"]),
        en: FAQContent.fromJson(json["en"]),
      );

  Map<String, dynamic> toJson() => {
        "du": du,
        "en": en,
      };
}

class FAQContent {
  FAQContent({this.question, this.answer, this.isActive});

  String? question;
  String? answer;
  bool? isActive;
  factory FAQContent.fromRawJson(String str) =>
      FAQContent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQContent.fromJson(Map<String, dynamic> json) => FAQContent(
        question: json["question"],
        answer: json["answer"],
        isActive: false,
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
