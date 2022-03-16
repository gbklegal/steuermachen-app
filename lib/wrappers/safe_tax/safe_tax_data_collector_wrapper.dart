class SafeTaxDataCollectorWrapper {
  SafeTaxDataCollectorWrapper({
    required this.taxYear,
    required this.martialStatus,
    required this.signaturePath,
    required this.termsAndConditionChecked,
  });
  late final String taxYear;
  late final String martialStatus;
  late final String signaturePath;
  late final String termsAndConditionChecked;
  SafeTaxDataCollectorWrapper.fromJson(Map<String, dynamic> json) {
    taxYear = json['tax_year'];
    martialStatus = json['martial_status'];
    signaturePath = json['signature_path'];
    termsAndConditionChecked = json['terms_and_condition_checked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tax_year'] = taxYear;
    _data['martial_status'] = martialStatus;
    _data['signature_path'] = signaturePath;
    _data['terms_and_condition_checked'] = termsAndConditionChecked;

    return _data;
  }
}
