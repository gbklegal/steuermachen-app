import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/wrappers/document/documents_wrapper.dart';
import 'package:steuermachen/wrappers/finance/finance_law_view_wrapper.dart';
import 'package:steuermachen/wrappers/payment_gateway/sumup_checkout_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';
import 'package:steuermachen/wrappers/user_wrapper.dart';

class UserOrdersDataModel {
  UserOrdersDataModel({
    this.taxYear,
    this.martialStatus,
    this.grossIncome,
    this.isPromoApplied = false,
    this.userInfo,
    this.userAddress,
    this.signaturePath,
    this.termsAndConditionChecked,
    this.steps,
    this.approveAt,
    this.approvedBy,
    this.createdAt,
    this.status,
    this.taxName,
    this.invoiceNumber,
    this.orderNumber,
    this.paymentType,
    this.paymentInfo,
    this.subscriptionPrice,
  });
  String? taxYear;
  String? martialStatus;
  String? grossIncome;
  String? taxPrice;
  bool? isPromoApplied;
  String? signaturePath;
  bool? termsAndConditionChecked;
  UserWrapper? userInfo;
  UserWrapper? userAddress;
  List<TaxStepsWrapper>? steps;
  List<String>? invoices;
  List<DocumentsWrapper>? documentsPath;
  DateTime? createdAt;
  DateTime? approveAt;
  String? taxName;
  String? status;
  String? approvedBy;
  String? keyId;
  String? invoiceNumber;
  String? orderNumber;
  String? paymentType;
  SumpupCheckoutWrapper? paymentInfo;
  double? subscriptionPrice;
  FinanceLawViewWrapper? subjectLawChecks;
  String? checkedCommission;
  DateTime? selectedAppealDate;

  UserOrdersDataModel.fromJson(Map<String, dynamic> json, String documentId) {
    taxYear = json['tax_year'];
    martialStatus = json['martial_status'];
    grossIncome = json['grossIncome'];
    isPromoApplied = json['is_promo_applied'];
    signaturePath = json['signature_path'];
    termsAndConditionChecked = json['terms_and_condition_checked'];

    createdAt = json['created_at'].toDate();
    approveAt = json['approve_at']?.toDate();
    approvedBy = json['approved_by'];
    taxName = json['tax_name'];
    taxPrice = json['tax_price'];
    userInfo = UserWrapper.fromJson(json['user_info']);
    userAddress = json['user_address'] != null
        ? UserWrapper.fromJson(json['user_address'])
        : null;
    steps = json['steps'] != null
        ? List<TaxStepsWrapper>.from(
            json['steps'].map((x) => TaxStepsWrapper.fromJson(x)))
        : null;
    status = json['status'];
    invoices = json['invoices_path'] != null
        ? List<String>.from(json['invoices_path'])
        : null;
    documentsPath = json['documents_path'] != null
        ? List<DocumentsWrapper>.from(
            json['documents_path']?.map((x) => DocumentsWrapper.fromJson(x)))
        : [];
    keyId = documentId;
    invoiceNumber = json["invoice_number"];
    orderNumber = json["order_number"];
    paymentType = json["payment_type"];
    paymentInfo = json["payment_info"];
    subscriptionPrice = json["subscription_price"];
    subjectLawChecks = json["subject_law_checks"];
    selectedAppealDate = json["selected_appeal_date"];
    checkedCommission = json['checked_commission'];
  }

  Map<String, dynamic> toJson(String taxName, {List<TaxStepsWrapper>? steps}) {
    final _data = <String, dynamic>{};
    _data['tax_year'] = taxYear;
    _data['martial_status'] = martialStatus;
    _data['grossIncome'] = grossIncome;
    _data['is_promo_applied'] = isPromoApplied;
    _data['signature_path'] = signaturePath;
    _data['user_address'] = userAddress?.toJson();
    _data['user_info'] = userInfo?.toJson();
    _data['terms_and_condition_checked'] = termsAndConditionChecked;
    _data['invoices_path'] = invoices;
    _data['tax_price'] = taxPrice;
    _data['documents_path'] = documentsPath?.map((e) => e.toJson()).toList();
    _data['created_at'] = DateTime.now();
    _data['approve_at'] = null;
    _data['tax_name'] = taxName;
    _data['steps'] = steps?.map((e) => e.toJson()).toList();
    _data['status'] = status ?? ProcessConstants.pending;
    _data['approved_by'] = null;
    _data['invoice_number'] = invoiceNumber;
    _data['order_number'] = orderNumber;
    _data['payment_type'] = paymentType;
    _data['payment_info'] = paymentInfo?.toJson();
    _data['subscription_price'] = subscriptionPrice;
    _data['subject_law_checks'] = subjectLawChecks?.toJson();
    _data['selected_appeal_date'] = selectedAppealDate;
    _data['checked_commission'] = checkedCommission;

    return _data;
  }
}
