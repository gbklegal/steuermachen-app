// To parse this JSON data, do
//
//     final taxStepsWrapper = taxStepsWrapperFromJson(jsonString);

import 'dart:convert';

import 'package:steuermachen/constants/strings/process_constants.dart';

List<TaxStepsWrapper> taxSteps = [
  TaxStepsWrapper(
      titleEn: 'Tax return commissioned',
      titleDe: 'Steuererklärung beauftragt',
      status: ProcessConstants.pending,
      createdAt: DateTime.now()),
  TaxStepsWrapper(
      titleEn: 'Documents received',
      titleDe: 'Unterlagen eingegangen',
      status: ProcessConstants.pending,
      createdAt: DateTime.now()),
  TaxStepsWrapper(
      titleEn: 'Review of the documents',
      titleDe: 'Prüfung der Unterlagen',
      status: ProcessConstants.pending,
      createdAt: DateTime.now()),
  TaxStepsWrapper(
      titleEn: 'Declaration sent',
      titleDe: 'Erklärung fertig versendet',
      status: ProcessConstants.pending,
      createdAt: DateTime.now()),
  TaxStepsWrapper(
      titleEn: 'Tax assessment pending ',
      titleDe: 'Steuerbescheid ausstehend ',
      status: ProcessConstants.pending,
      createdAt: DateTime.now()),
  TaxStepsWrapper(
      titleEn: 'Tax assessment checked - done',
      titleDe: 'Steuerbescheid geprüft – fertig',
      status: ProcessConstants.pending,
      createdAt: DateTime.now()),
];

class TaxStepsWrapper {
  TaxStepsWrapper({
    required this.titleEn,
    required this.titleDe,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.updatedBy,
  });

  String titleEn;
  String titleDe;
  String status;
  DateTime createdAt;
  DateTime? updatedAt;
  String? updatedBy;

  factory TaxStepsWrapper.fromRawJson(String str) =>
      TaxStepsWrapper.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TaxStepsWrapper.fromJson(Map<String, dynamic> json) =>
      TaxStepsWrapper(
        titleEn: json["titleEn"],
        titleDe: json["titleDe"],
        status: json["status"],
        createdAt: json["createdAt"]?.toDate(),
        updatedAt: json["updatedAt"]?.toDate(),
        updatedBy: json["updatedBy"],
      );

  Map<String, dynamic> toJson() => {
        "titleEn": titleEn,
        "titleDe": titleDe,
        "status": status,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "updatedBy": updatedBy,
      };
}
