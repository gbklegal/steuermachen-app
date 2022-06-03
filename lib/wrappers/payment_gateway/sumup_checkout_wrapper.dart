class SumpupCheckoutWrapper {
  SumpupCheckoutWrapper({
    required this.invoiceNumber,
    this.orderNumber,
    required this.amount,
    required this.currency,
    required this.payToEmail,
    required this.description,
    required this.id,
    required this.status,
    required this.date,
    required this.transactionCode,
    required this.transactionId,
    required this.transactions,
  });
  late final String invoiceNumber;
  String? orderNumber;
  late final dynamic amount;
  late final String currency;
  late final String payToEmail;
  late final String description;
  late final String id;
  late final String status;
  late final String date;
  late final String? transactionCode;
  late final String? transactionId;
  late final List<Transactions>? transactions;

  SumpupCheckoutWrapper.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['checkout_reference'];
    amount = json['amount'];
    currency = json['currency'];
    payToEmail = json['pay_to_email'];
    description = json['description'];
    id = json['id'];
    status = json['status'];
    date = json['date'];
    transactionCode = json['transaction_code'];
    transactionId = json['transaction_id'];
    transactions = List.from(json['transactions'])
        .map((e) => Transactions.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['checkout_reference'] = invoiceNumber;
    _data['amount'] = amount;
    _data['currency'] = currency;
    _data['pay_to_email'] = payToEmail;
    _data['description'] = description;
    _data['id'] = id;
    _data['status'] = status;
    _data['date'] = date;
    _data['transaction_code'] = transactionCode;
    _data['transaction_id'] = transactionId;
    _data['transactions'] = transactions?.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Transactions {
  Transactions({
    required this.id,
    required this.transactionCode,
    required this.merchantCode,
    required this.amount,
    required this.vatAmount,
    required this.tipAmount,
    required this.currency,
    required this.timestamp,
    required this.status,
    required this.paymentType,
    required this.entryMode,
    required this.installmentsCount,
    required this.authCode,
    required this.internalId,
  });
  late final String id;
  late final String transactionCode;
  late final String merchantCode;
  late final int amount;
  late final int vatAmount;
  late final int tipAmount;
  late final String currency;
  late final String timestamp;
  late final String status;
  late final String paymentType;
  late final String entryMode;
  late final int installmentsCount;
  late final String authCode;
  late final int internalId;

  Transactions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionCode = json['transaction_code'];
    merchantCode = json['merchant_code'];
    amount = json['amount'];
    vatAmount = json['vat_amount'];
    tipAmount = json['tip_amount'];
    currency = json['currency'];
    timestamp = json['timestamp'];
    status = json['status'];
    paymentType = json['payment_type'];
    entryMode = json['entry_mode'];
    installmentsCount = json['installments_count'];
    authCode = json['auth_code'];
    internalId = json['internal_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['transaction_code'] = transactionCode;
    _data['merchant_code'] = merchantCode;
    _data['amount'] = amount;
    _data['vat_amount'] = vatAmount;
    _data['tip_amount'] = tipAmount;
    _data['currency'] = currency;
    _data['timestamp'] = timestamp;
    _data['status'] = status;
    _data['payment_type'] = paymentType;
    _data['entry_mode'] = entryMode;
    _data['installments_count'] = installmentsCount;
    _data['auth_code'] = authCode;
    _data['internal_id'] = internalId;
    return _data;
  }
}
