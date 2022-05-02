import 'package:steuermachen/wrappers/user_wrapper.dart';

class EasyTaxDataCollectorWrapper {
  EasyTaxDataCollectorWrapper(
      {this.userInfo,
      this.userAddress,
      this.termsAndConditionChecked,
      this.checkOutReference,
      this.subscriptionPrice,
      this.taxYear});
  String? taxYear;
  bool? termsAndConditionChecked;
  double? subscriptionPrice;
  UserWrapper? userInfo;
  UserWrapper? userAddress;
  String? checkOutReference;

  EasyTaxDataCollectorWrapper.fromJson(Map<String, dynamic> json) {
    termsAndConditionChecked = json['terms_and_condition_checked'];
    checkOutReference = json["checkout_reference"];
    taxYear = json['tax_year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tax_year'] = taxYear;
    _data['user_address'] = userAddress?.toJson();
    _data['user_info'] = userInfo?.toJson();
    _data['terms_and_condition_checked'] = termsAndConditionChecked;
    _data['subscription_price'] = subscriptionPrice;
    _data['checkout_reference'] = checkOutReference;
    return _data;
  }
}
