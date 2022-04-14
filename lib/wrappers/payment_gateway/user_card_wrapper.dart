class UserCardWrapper {
  UserCardWrapper({
    this.paymentType,
    this.card,
  });
  late String? paymentType;
  late UserCardInfo? card;

  UserCardWrapper.fromJson(Map<String, dynamic> json) {
    paymentType = json['payment_type'];
    card = UserCardInfo.fromJson(json['card']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payment_type'] = paymentType;
    _data['card'] = card?.toJson();
    return _data;
  }
}

class UserCardInfo {
  UserCardInfo({
    this.name,
    this.number,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
  });
  late String? name;
  late String? number;
  late String? expiryMonth;
  late String? expiryYear;
  late String? cvv;

  UserCardInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    number = json['number'];
    expiryMonth = json['expiry_month'];
    expiryYear = json['expiry_year'];
    cvv = json['cvv'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['number'] = number;
    _data['expiry_month'] = expiryMonth;
    _data['expiry_year'] = expiryYear;
    _data['cvv'] = cvv;
    return _data;
  }
}
