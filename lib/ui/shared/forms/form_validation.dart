import 'package:flutter/material.dart';

class FormValidation {
  ///Checks for missing value in a field
  dynamic defaultValidation(String value) {
    if (value.length == 0) {
      return 'This field is required';
    }
    return null;
  }

  dynamic emailValidation(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if (email.isEmpty || !emailValid) {
      return 'Enter a valid email address';
    }

    return null;
  }

  dynamic integerInputValidation(
    String value, {
    int minLength = 1,
    int maxLength,
  }) {
    final numberRegex = RegExp(r"^[0-9]*$");
    bool isNumeric = numberRegex.hasMatch(value);

    if (!isNumeric) {
      return 'Should only contain numbers';
    }

    if (value.length < minLength) {
      String language = minLength == 1 ? 'character' : 'characters';
      return 'Must be at least $minLength $language';
    }

    if (maxLength != null) {
      if (value.length > maxLength) {
        String language = maxLength == 1 ? 'character' : 'characters';
        return 'Cannot exceed $maxLength $language';
      }
    }

    return null;
  }

  dynamic isAlphanumeric(String value, {emptyString = 'This field is required'}) {
    final RegExp regex = RegExp(r"^[a-zA-Z0-9]*$");

    if(value.isEmpty) {
      return emptyString;
    }

    if(!regex.hasMatch(value)) {
      return 'No special characters allowed';
    }

    return null;

  }

  dynamic phoneValidation(String value) {
    return integerInputValidation(value, minLength: 9, maxLength: 10);
  }

  dynamic passwordValidation(String value) {
    //Ensure it is at least 6 characters long
    if (value.length < 6) {
      return 'Must be at least 6 characters';
    }

    RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    bool isComplexPassword = passwordRegex.hasMatch(value);

    if (!isComplexPassword) {
      return 'Must contain one capital letter, number and special character';
    }

    return null;
  }

  bool formValidation(GlobalKey<FormState> formKey) {
    final validated = formKey.currentState.validate();
    print('Validation status: $validated');
    return validated;
  }

  bool signUpValidation(GlobalKey<FormState> formKey, bool termsAndConditions) {
    final validated = formKey.currentState.validate() && termsAndConditions == true;
    print('Validation status: $validated');
    return validated;
  }

  //OTP field verification
  dynamic codeValidation(String value) {
    if (value.length < 6) {
      return 'Enter at least six numbers';
    }
    return null;
  }

  String dropdownValidation({
    @required String value,
    @required String defaultValue,
    @required String errorFeedback,
  }) {
    if (value == defaultValue) {
      return errorFeedback;
    }
    return null;
  }
}
