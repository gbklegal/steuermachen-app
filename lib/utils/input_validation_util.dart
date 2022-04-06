import 'package:email_validator/email_validator.dart';
import 'package:steuermachen/constants/strings/error_messages_constants.dart';

class InputValidationUtil {
  // static const patternName =
  //     r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$";
  static const patternName =
      r"^(?=.{1,40}$)[a-zA-Z]+(?:[-'\s][a-zA-Z]+)*$";
  static const patternPhone = r'^\+(?:[0-9]●?){6,14}[0-9]$';
  static const patternDigits = r'^[0-9]*$';
  static const Pattern passwordMinLen8withLowerCaseAndSpecialChar =
      r'^((?=.*\d)(?=.*[a-z])(?=.*[\W_]).{8,20})';
  static const Pattern passwordMinLenWithOneCharAndNumber =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  bool isEmailValid(String email) {
    return EmailValidator.validate(email);
  }

  bool _isPhoneValid(String phone) {
    RegExp regexPhone = RegExp(patternPhone);
    return regexPhone.hasMatch(phone);
  }

  bool _isValidName(String name) {
    RegExp regexName = RegExp(patternName);
    return regexName.hasMatch(name);
  }

  bool isValidateDigit(String digit) {
    RegExp regexName = RegExp(patternDigits);
    return regexName.hasMatch(digit);
  }

  isPasswordValid(String password, String pattern) {
    RegExp regexPassword = RegExp(pattern);
    return regexPassword.hasMatch(password);
  }

  String? validatePhone(String? phone, {String? errorMessage}) {
    if (phone!.isEmpty) {
      return ErrorMessagesConstants.errEmpty;
    } else if (_isPhoneValid(phone)) {
      return null;
    } else {
      if (errorMessage == null) {
        return ErrorMessagesConstants.invalidContact;
      } else {
        return errorMessage;
      }
    }
  }

  String? validateFieldLength(String? input, int length,
      {String? errorMessage}) {
    if (input!.isEmpty) {
      if (errorMessage == null) {
        return ErrorMessagesConstants.errEmpty;
      } else {
        return errorMessage;
      }
    } else if (input.length < length) {
      if (errorMessage == null) {
        return "${ErrorMessagesConstants.errMinLength} $length Characters";
      } else {
        return errorMessage;
      }
    } else {
      return null;
    }
  }

  String? validatePassAndConfirmPass(String? input, String? input2,
      {String? errorMessage}) {
    if (input2!.isEmpty) {
      if (errorMessage == null) {
        return ErrorMessagesConstants.fieldRequired;
      } else {
        return errorMessage;
      }
    } else if (input != input2) {
      if (errorMessage == null) {
        return ErrorMessagesConstants.errPasswordsSame;
      } else {
        return errorMessage;
      }
    } else {
      return null;
    }
  }

  String? validateEmail(String? email, {String? errorMessage}) {
    if (email!.isEmpty) {
      return ErrorMessagesConstants.errEmpty;
    } else if (isEmailValid(email)) {
      return null;
    } else {
      if (errorMessage == null) {
        return ErrorMessagesConstants.invalidEmail;
      } else {
        return errorMessage;
      }
    }
  }

  String? validateName(String? name, {String? errorMessage}) {
    if (name!.isEmpty) {
      return ErrorMessagesConstants.errEmpty;
    } else if (_isValidName(name)) {
      return null;
    } else {
      if (errorMessage == null) {
        return ErrorMessagesConstants.invalidName;
      } else {
        return errorMessage;
      }
    }
  }

  String? validateFieldEmpty(String? input, {String? errorMessage}) {
    if (input!.isEmpty) {
      if (errorMessage == null) {
        return ErrorMessagesConstants.errEmpty;
      } else {
        return errorMessage;
      }
    } else {
      return null;
    }
  }

  String? validateDigit(String? input, {String? errorMessage}) {
    if (isValidateDigit(input!)) {
      if (errorMessage == null) {
        return ErrorMessagesConstants.errEmpty;
      } else {
        return errorMessage;
      }
    } else {
      return null;
    }
  }

  String? validatePassword(String? password, {String? errorMessage}) {
    if (password!.isEmpty) {
      return ErrorMessagesConstants.errEmpty;
    } else if (password.length > 7) {
      return null;
    } else {
      if (errorMessage == null) {
        return ErrorMessagesConstants.invalidPassword;
      } else {
        return errorMessage;
      }
    }
  }
}
