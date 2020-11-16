import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/connectivity_service.dart';
import 'package:shop_ke/core/services/email_authentication_service.dart';
import 'package:shop_ke/core/services/firestore_services/customers_collection.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:shop_ke/ui/views/authentication/login_view.dart';
import 'package:shop_ke/ui/views/general/home_view.dart';
import 'package:shop_ke/ui/views/store_owner/owner_home_view.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthenticationViewModel extends BaseViewModel {
  Customer customer = Customer();
  bool isShopOwner = false;

  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _emailAuthService = locator<EmailAuthenticationService>();
  final _customerCollection = locator<CustomersCollection>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  final connectionService = locator<ConnectivityService>();

  bool submitButtonClicked = false;
  bool termsAndConditions = false;
  final validate = FormValidation();
  final codeController = TextEditingController();

  final signUpErrorTitle = 'Registration error';
  String loginErrorTitle = 'Login error';

  void setTermsAndConditions(bool value) {
    termsAndConditions = value;
    notifyListeners();
  }

  void setCustomerIsShopOwner(bool value) {
    isShopOwner = value;
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
      _dialogService.showDialog(
          title: signUpErrorTitle, description: serviceResponse.response);
      changeState(ViewState.Idle);
      return;
    }

    //On successful registration add customer to firestore
    addCustomerToFirestore(serviceResponse, customer);
  }

  void addCustomerToFirestore(ServiceResponse serviceResponse,
      Customer customer) async {
    User user = serviceResponse.response;
    bool added = await _customerCollection.addCustomer(customer, user);

    if (!added) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
        title: signUpErrorTitle,
        description:
        'User registration incomplete. Please check your connection and try again',
      );
      return;
    }

    setSharedPreferencesForCustomer(customer);
  }

  void login(GlobalKey<FormState> formKey, Customer customer) async {
    changeState(ViewState.Busy);

    //If verification passes, proceed to phone verification phase
    if (!validate.formValidation(formKey)) {
      changeState(ViewState.Idle);
      return;
    }

    final ServiceResponse serviceResponse = await _emailAuthService
        .loginWithEmail(email: customer.email, password: customer.password);

    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
          title: loginErrorTitle, description: serviceResponse.response);
      return;
    }

    //Get the user from firestore
    String uid = serviceResponse.response;
    getCustomerFromFirestore(uid);
  }

  void getCustomerFromFirestore(String uid) async {
    final ServiceResponse serviceResponse =
    await _customerCollection.getCustomerById(uid);

    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
          title: loginErrorTitle, description: serviceResponse.response);
      return;
    }

    Customer customer = serviceResponse.response;
    setSharedPreferencesForCustomer(customer);
  }

  void setSharedPreferencesForCustomer(Customer customer) async {
    //Save user data locally
    //TODO: setStore sharedPreferences
    final ServiceResponse serviceResponse =
    await _sharedPreferences.setCustomer(customer.toMap());

    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
          title: signUpErrorTitle, description: serviceResponse.response);
      return;
    }

    changeState(ViewState.Idle);

    //Navigate to HomeView
    if (customer.isShopOwner) {
      //TODO: add store as argument
      _navigationService.replaceWith(OwnerHomeView.routeName);
    } else {
      _navigationService.replaceWith(HomeView.routeName);
    }
  }

  Future<void> resetPassword(GlobalKey<FormState> formKey, String email) async {
    changeState(ViewState.Busy);

    //Validate the form
    if (!validate.formValidation(formKey)) {
      changeState(ViewState.Idle);
      return;
    }

    //Check is the user's email address exists
    bool emailExists = await _customerCollection.emailAddressExists(email);
    if (!emailExists) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(title: 'Unregistered email address',
        description: 'Please review your email address. Check it does not have a typo and '
            'that it is the one you registered with');
      return;
    }

    final ServiceResponse serviceResponse =
    await _emailAuthService.resetPassword(email);

    //Check if exception was thrown
    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
          title: 'Reset link not sent', description: serviceResponse.response);
      return;
    }

    DialogResponse dialogResponse = await _dialogService.showDialog(title: 'Reset Link Sent', description: serviceResponse.response);

    if(dialogResponse.confirmed) {
      _navigationService.navigateTo(LoginView.routeName);
    }

    changeState(ViewState.Idle);
  }
}
