import 'package:steuermachen/wrappers/user_wrapper.dart';

class EasyTaxDataCollectorWrapper {
  EasyTaxDataCollectorWrapper({
    this.userInfo,
    this.userAddress,
    this.termsAndConditionChecked,
    this.subscriptionPrice
  });
  bool? termsAndConditionChecked;
  double? subscriptionPrice;
  UserWrapper? userInfo;
  UserWrapper? userAddress;
  EasyTaxDataCollectorWrapper.fromJson(Map<String, dynamic> json) {
    termsAndConditionChecked = json['terms_and_condition_checked'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_address'] = userAddress?.toJson();
    _data['user_info'] = userInfo?.toJson();
    _data['terms_and_condition_checked'] = termsAndConditionChecked;
    _data['subscription_price'] = subscriptionPrice;

    return _data;
  }
}
