class DeclarationTaxDataCollectorWrapper {
  DeclarationTaxDataCollectorWrapper({
     this.taxYear,
     this.martialStatus,
     this.signaturePath,
     this.termsAndConditionChecked,
  });
   String? taxYear;
   String? martialStatus;
   String? signaturePath;
   bool? termsAndConditionChecked;
  DeclarationTaxDataCollectorWrapper.fromJson(Map<String, dynamic> json) {
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
