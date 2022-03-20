import 'package:steuermachen/wrappers/user_wrapper.dart';

class DeclarationTaxDataCollectorWrapper {
  DeclarationTaxDataCollectorWrapper({
    this.taxYear,
    this.martialStatus,
    this.grossIncome,
    this.isPromoApplied = false,
    this.userInfo,
    this.userAddress,
    this.signaturePath,
    this.termsAndConditionChecked,
  });
  String? taxYear;
  String? martialStatus;
  String? grossIncome;
  bool? isPromoApplied;
  String? signaturePath;
  bool? termsAndConditionChecked;
  UserWrapper? userInfo;
  UserWrapper? userAddress;
  DeclarationTaxDataCollectorWrapper.fromJson(Map<String, dynamic> json) {
    taxYear = json['tax_year'];
    martialStatus = json['martial_status'];
    grossIncome = json['grossIncome'];
    isPromoApplied = json['is_promo_applied'];
    signaturePath = json['signature_path'];
    termsAndConditionChecked = json['terms_and_condition_checked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tax_year'] = taxYear;
    _data['martial_status'] = martialStatus;
    _data['grossIncome'] = grossIncome;
    _data['is_promo_applied'] = isPromoApplied;
    _data['signature_path'] = signaturePath;
    _data['user_address'] = userAddress?.toJson();
    _data['user_info'] = userInfo?.toJson();
    _data['terms_and_condition_checked'] = termsAndConditionChecked;

    return _data;
  }
}
