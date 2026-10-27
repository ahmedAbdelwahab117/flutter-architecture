import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';

import '../constant/app_strings.dart';
 
class Validate {
  static FilteringTextInputFormatter priceFormater =
      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$'));
  static FilteringTextInputFormatter numberOnlyFormater =
      FilteringTextInputFormatter.allow(RegExp('[0-9]'));

  static LengthLimitingTextInputFormatter maxLengthFormater(int length) =>
      LengthLimitingTextInputFormatter(length);

  static RegExp upperCaseRegex = RegExp(r'[A-Z]');
  static RegExp lowerCaseRegex = RegExp(r'[a-z]');
  static RegExp egyptionPhoneNumberRegex = RegExp(
    r'^(?:[0][1][0125])[0-9]{8}$',
  );
  static RegExp phoneNumberRegex = RegExp(r'^\+?[0-9]{10,15}$');
  static RegExp digit = RegExp(r'\d');
  static RegExp specialChar = RegExp(r'[^A-Za-z0-9]');
  static RegExp userNameReg = RegExp(r"^[a-zA-Z\-'\s]+$");
  static FilteringTextInputFormatter nameFormatter =
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));
  static RegExp fileExtensionRegExp = RegExp(
    r'\.(jpg|jpeg|png|bmp|webp|svg|pdf|word|docx?)$',
  );

  static RegExp imgExtensionRegExp = RegExp(r'\.(jpg|jpeg|png|bmp|webp|svg?)$');

  static RegExp emailRegex = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  ///validation Functions
  // static String? validateName(String name) {
  //   if (name.isEmpty) {
  //     return 'Name is required';
  //   } else if (!name.contains(upperCaseRegex)) {
  //     return ("Name must contain Uppercase letter");
  //   } else if (!name.contains(lowerCaseRegex)) {
  //     return ("Name must contain Lowercase letter");
  //   } else {
  //     return null;
  //   }
  // }

  // static String? nationalNotEmpty(String val) {
  //   if (val.isEmpty) {
  //     return 'This field can\'t be empty';
  //   }
  //   if (val.length != 14) {
  //     return "National id must be 14 Numbers";
  //   }

  //   return null;
  // }

  // static String? userNameValidation(String name) {
  //   if (name.trim().isEmpty) {
  //     return 'Name can not be empty';
  //   } else if (name.trim().length < 3) {
  //     return 'Name must be at least 3 characters long.';
  //   } else if ((name.trim().split(RegExp(r'\s+'))).length < 2) {
  //     return 'Please enter your full name (first and last name).';
  //   } else if (!userNameReg.hasMatch(name.trim())) {
  //     return "Name must only include letters , - , ' \n Numbers and other special characters are not allowed.";
  //   } else {
  //     return null;
  //   }
  // }

  static String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'email_error_empty'.tr();
    }
    if (!emailRegex.hasMatch(email)) {
      return 'email_not_valid'.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'password_error_empty'.tr();
    } else if (password.length < 8) {
      return 'password_8'.tr();
    } else if (!digit.hasMatch(password)) {
      return 'least_one_number'.tr();
    } else if (!upperCaseRegex.hasMatch(password)) {
      return 'password_error_uppercase'.tr();
    } else if (!lowerCaseRegex.hasMatch(password)) {
      return 'password_error_lowercase'.tr();
    } else if (!specialChar.hasMatch(password)) {
      return 'password_error_special'.tr();
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword({
    required String password,
    required String confirmPassword,
  }) {
    final emptyError = notEmpty(confirmPassword);
    if (emptyError != null) return emptyError;
    if (password != confirmPassword) {
      return AppStrings.passwordsNotMatch;
    }
    return null;
  }

  static String? notEmpty(String val) {
    if (val.isEmpty) {
      return 'can_not_be_empty'.tr();
    }

    return null;
  }

  static String? notEmptyPinCode(String val) {
    if (val.isEmpty) {
      return 'empty'.tr();
    }

    return null;
  }

  static String? validatePhoneNumber(String? number) {
    if (!phoneNumberRegex.hasMatch(number ?? '')) {
      return 'invalid_number'.tr();
    }
    if (number == null) {
      return 'number_required'.tr();
    }
    if (number.isEmpty) {
      return 'number_required'.tr();
    }
    return null;
  }

  static String? extractStartTimeFromSlotLabel(String timeSlotLabel) {
    final startTimeMatch = RegExp(
      r'from\s+([0-9]{1,2}:[0-9]{2}\s*[ap]m)',
      caseSensitive: false,
    ).firstMatch(timeSlotLabel);

    return startTimeMatch?.group(1)?.trim().toUpperCase();
  }
}
