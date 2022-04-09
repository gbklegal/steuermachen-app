import 'package:flutter/material.dart';
import 'package:steuermachen/components/toast_component.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';
import 'package:steuermachen/languages/locale_keys.g.dart';
import 'package:collection/collection.dart';

class TermsAndConditionProvider extends ChangeNotifier {
  final List<_TermsAndContionChecksData> _commissioning = [
    _TermsAndContionChecksData(
        title: LocaleKeys.commissioningRadioTitle1, isSelected: false),
    _TermsAndContionChecksData(
        title: LocaleKeys.commissioningRadioTitle2, isSelected: false),
  ];
  final List<_TermsAndContionChecksData> _termsAndConditionChecks = [
    _TermsAndContionChecksData(
        title: LocaleKeys.termsAndConditionCheck1, isSelected: false),
    _TermsAndContionChecksData(
        title: LocaleKeys.termsAndConditionCheck2, isSelected: false),
  ];
  List<_TermsAndContionChecksData> get commissioning => _commissioning;
  List<_TermsAndContionChecksData> get termsAndConditionChecks =>
      _termsAndConditionChecks;
  changeCommissionCheckState(int index) {
    for (var item in _commissioning) {
      item.isSelected = false;
    }
    _commissioning[index].isSelected = true;
    notifyListeners();
  }

  changeTermsAndConditionCheckedState(int index) {
    _termsAndConditionChecks[index].isSelected =
        !_termsAndConditionChecks[index].isSelected;
    notifyListeners();
  }

  _TermsAndContionChecksData? getCommissionCheckedValue() {
    var _commission =
        _commissioning.firstWhereOrNull((e) => e.isSelected == true);
    return _commission;
  }

  bool validateChecks(bool showCommissioning) {
    if (showCommissioning) {
      var _commission =
          _commissioning.firstWhereOrNull((e) => e.isSelected == true);
      if (_commission == null) {
        ToastComponent.showToast(
            ErrorMessagesConstants.pleaseCheckTheAboveFields);
        return false;
      }
    }

    var _termsChecks =
        _termsAndConditionChecks.firstWhereOrNull((e) => e.isSelected == false);
    if (_termsChecks != null) {
      ToastComponent.showToast(
          ErrorMessagesConstants.pleaseCheckTheAboveFields);
      return false;
    } else {
      return true;
    }
  }
}

// List<_TermsAndContionChecksData> get  _commissioning=>  commissioning;

class _TermsAndContionChecksData {
  late String title;
  late bool isSelected;
  _TermsAndContionChecksData({required this.title, required this.isSelected});
}
