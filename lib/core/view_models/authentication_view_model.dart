import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/connection_service.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/firebase_services/email_authentication_service.dart';
import 'package:shop_ke/core/services/firebase_services/firestore_service.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:shop_ke/ui/views/choose_action_view.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../locator.dart';

class AuthenticationViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _errorService = locator<ErrorService>();
  final _emailAuthService = locator<EmailAuthenticationService>();
  final _firestoreService = locator<FirestoreService>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  final connectionService = locator<ConnectionService>();

  bool submitButtonClicked = false;
  bool termsAndConditions = false;
  final validate = FormValidation();
  final codeController = TextEditingController();

  final errorTitle = 'Registration error';

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

  void signUp(GlobalKey<FormState> formKey, Customer customer) async {

    changeState(ViewState.Busy);

    //If the form validation fails, exit function
    if (!validate.signUpValidation(formKey, termsAndConditions)) {
      changeState(ViewState.Idle);
      return;
    }

    //Initiate email registration process
    final ServiceResponse serviceResponse =
        await _emailAuthService.signUpWithEmail(
      email: customer.email,
      password: customer.password,
    );

    //If the sign up fails show an alert with the error message
    if (!serviceResponse.status) {
      _errorService.showErrorDialog(errorTitle, serviceResponse.response);
      changeState(ViewState.Idle);
      return;
    }

    //On successful registration add customer to firestore
    addCustomerToFirestore(serviceResponse, customer);
  }

  void addCustomerToFirestore(
      ServiceResponse serviceResponse, Customer customer) async {

    User user = serviceResponse.response;
    bool added = await _firestoreService.addCustomer(customer, user);

    if (!added) {
      changeState(ViewState.Idle);
      _errorService.showErrorDialog(
        errorTitle,
        'User registration incomplete. Please check your connection and try again',
      );
      return;
    }

    setSharedPreferencesForCustomer(customer);
  }

  void login(GlobalKey<FormState> formKey, Customer customer,) {
    //If verification passes, proceed to phone verification phase
    if (!validate.formValidation(formKey)) {
      return;
    }
  }

  void setSharedPreferencesForCustomer(Customer customer) async {
    //Save user data locally
    final ServiceResponse serviceResponse = await _sharedPreferences.setCustomer(customer.toMap());

    if(!serviceResponse.status) {
      changeState(ViewState.Idle);
      _errorService.showErrorDialog(errorTitle, serviceResponse.response);
      return;
    }

    changeState(ViewState.Idle);
    _navigationService.replaceWith(ChooseActionView.routeName);
  }
}
