import 'package:steuermachen/wrappers/user_wrapper.dart';

class EasyTaxDataCollectorWrapper {
  EasyTaxDataCollectorWrapper(
      {this.userInfo,
      this.userAddress,
      this.termsAndConditionChecked,
      this.invoiceNumber,
      this.subscriptionPrice,
      this.taxYear,
      this.orderNumber
      });
  String? taxYear;
  bool? termsAndConditionChecked;
  double? subscriptionPrice;
  UserWrapper? userInfo;
  UserWrapper? userAddress;
  String? invoiceNumber;
  String? orderNumber;

  EasyTaxDataCollectorWrapper.fromJson(Map<String, dynamic> json) {
    termsAndConditionChecked = json['terms_and_condition_checked'];
    invoiceNumber = json["invoice_number"];
    taxYear = json['tax_year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['tax_year'] = taxYear;
    _data['user_address'] = userAddress?.toJson();
    _data['user_info'] = userInfo?.toJson();
    _data['terms_and_condition_checked'] = termsAndConditionChecked;
    _data['subscription_price'] = subscriptionPrice;
    _data['invoice_number'] = invoiceNumber;
    _data['order_number'] = orderNumber;
    return _data;
  }
}
