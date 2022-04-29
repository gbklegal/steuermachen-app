import 'package:steuermachen/constants/strings/process_constants.dart';
import 'package:steuermachen/wrappers/document/documents_wrapper.dart';
import 'package:steuermachen/wrappers/tax_steps_wrapper.dart';
import 'package:steuermachen/wrappers/user_wrapper.dart';

class SafeAndDeclarationTaxDataCollectorWrapper {
  SafeAndDeclarationTaxDataCollectorWrapper(
      {this.taxYear,
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
      this.taxName});
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
  String? checkOutReference;

  SafeAndDeclarationTaxDataCollectorWrapper.fromJson(
      Map<String, dynamic> json, String documentId) {
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
    steps = List<TaxStepsWrapper>.from(
        json['steps'].map((x) => TaxStepsWrapper.fromJson(x)));
    status = json['status'];
    invoices = json['invoices'];
    documentsPath = json['documents_path'] != null
        ? List<DocumentsWrapper>.from(
            json['documents_path']?.map((x) => DocumentsWrapper.fromJson(x)))
        : [];
    keyId = documentId;
    checkOutReference = json["checkout_reference"];
  }

  Map<String, dynamic> toJson(String taxName, List<TaxStepsWrapper> _steps) {
    final _data = <String, dynamic>{};
    _data['tax_year'] = taxYear;
    _data['martial_status'] = martialStatus;
    _data['grossIncome'] = grossIncome;
    _data['is_promo_applied'] = isPromoApplied;
    _data['signature_path'] = signaturePath;
    _data['user_address'] = userAddress?.toJson();
    _data['user_info'] = userInfo?.toJson();
    _data['terms_and_condition_checked'] = termsAndConditionChecked;
    _data['invoices'] = invoices;
    _data['tax_price'] = taxPrice;
    _data['documents_path'] = documentsPath?.map((e) => e.toJson()).toList();
    _data['created_at'] = DateTime.now();
    _data['approve_at'] = null;
    _data['tax_name'] = taxName;
    _data['steps'] = _steps.map((e) => e.toJson()).toList();
    _data['status'] = ProcessConstants.pending;
    _data['approved_by'] = null;
    _data['checkout_reference'] = checkOutReference;

    return _data;
  }
}
