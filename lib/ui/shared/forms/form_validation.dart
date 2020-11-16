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

  dynamic phoneValidation(String value) {
    //check that at least 9 or 10 max have been entered
    if (value.length < 9 || value.length > 10) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  dynamic passwordValidation(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

    //Ensure it is at least 6 characters long
    if (value.length < 6) {
      return 'Must be at least 6 characters';
    }

    RegExp regExp = new RegExp(pattern);
    if (!regExp.hasMatch(value)) {
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
    final validated =
        formKey.currentState.validate() && termsAndConditions == true;
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
