import 'dart:convert';
class FAQContentModel {
  FAQContentModel({this.question, this.answer, this.isActive});

  String? question;
  String? answer;
  bool? isActive;
  factory FAQContentModel.fromRawJson(String str) =>
      FAQContentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQContentModel.fromJson(Map<String, dynamic> json) => FAQContentModel(
        question: json["question"],
        answer: json["answer"],
        isActive: false,
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
