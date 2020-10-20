import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/user_action.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/firebase_services/phone_authentication_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:shop_ke/ui/views/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class AuthenticationViewModel extends BaseViewModel {
  final PhoneAuthenticationService _phoneAuthService =
      locator<PhoneAuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ErrorService _errorService = locator<ErrorService>();

  bool submitButtonClicked = false;
  bool termsAndConditions = false;
  final validate = FormValidation();
  final codeController = TextEditingController();

  Customer _customer;

  void setTermsAndConditions(bool value) {
    termsAndConditions = value;
    notifyListeners();
  }

  void isSubmitButtonClicked() {
    //Logic that assists in showing validation message for terms and conditions
    //When the form shows in the beginning, the warning for terms and conditions is always hidden
    //Once the user attempts to submit the form, the state changes and it can be validated whether the
    //terms and conditions were clicked or not
    if (submitButtonClicked == false) {
      submitButtonClicked = true;
      notifyListeners();
    }
  }

  void login({
    @required BuildContext context,
    @required GlobalKey<FormState> formKey,
    @required String phoneNumber,
  }) {
    //If verification passes, proceed to phone verification phase
    if (!validate.formValidation(formKey)) {
      return;
    }

    //Initiate phone verification process
    phoneAuthentication(
      phoneNumber: phoneNumber,
      context: context,
      action: UserAction.Login,
    );
  }

  void phoneAuthentication({
    @required BuildContext context,
    @required String phoneNumber,
    @required UserAction action,
  }) async {
    changeState(ViewState.Busy);

    //Invoke the phone authentication from the auth service
    _phoneAuthService.initPhoneAuth(
      phoneNumber: phoneNumber,
      context: context,
      action: action,
      customer: _customer,
    );

    //After x seconds change the view state to idle
//    delayedChangeState(ViewState.Idle);
  }

  Future<void> manualPhoneAuthentication({
    @required GlobalKey<FormState> formKey,
    @required String verificationId,
    @required BuildContext context,
    @required UserAction action,
    Customer customer,
  }) async {
    //If no code is entered
    if (!validate.formValidation(formKey)) {
      return;
    }

    changeState(ViewState.Busy);

    //Check whether the code matches
    final ServiceResponse serviceResponse =
        await _phoneAuthService.manualPhoneVerification(
      context: context,
      code: codeController.text.trim(),
      verificationId: verificationId,
      action: action,
    );

    //Check for errors in response
    if (!serviceResponse.status) {
      delayedChangeState(ViewState.Idle);
      _errorService.showServiceResponseError(serviceResponse);
      return;
    }

    inspect(serviceResponse);
    _navigationService.replaceWith(HomeView.routeName);
  }

  void signUp(
      BuildContext context, GlobalKey<FormState> formKey, Customer customer) {
    _customer = customer;

    //If all the fields have been filled and terms and conditions have
    // been accepted
    if (validate.signUpValidation(formKey, termsAndConditions)) {
      //Initiate phone verification process
      phoneAuthentication(
        context: context,
        phoneNumber: '${customer.fullPhoneNumber}',
        action: UserAction.SignUp,
      );
      print('Customer $customer');
    }
  }
}
