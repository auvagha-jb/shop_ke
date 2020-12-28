import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/connectivity_service.dart';
import 'package:shop_ke/core/services/database_services/stores_table.dart';
import 'package:shop_ke/core/services/database_services/users_table.js.dart';
import 'package:shop_ke/core/services/firebase_services/email_authentication_service.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
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
  final _sharedPreferences = locator<SharedPreferencesService>();
  final connectionService = locator<ConnectivityService>();

  final UsersTable _usersTable = UsersTable();
  final StoresTable _storesTable = StoresTable();

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
    ServiceResponse serviceResponse;

    serviceResponse = await _emailAuthService.signUpWithEmail(
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

    //On successful registration add customer to database
    User user = serviceResponse.response;
    addCustomerToDatabase(user, customer);
  }

  void addCustomerToDatabase(User user, Customer customer) async {
    ServiceResponse serviceResponse =
        await _usersTable.insertUser(customer, user);

    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
        title: signUpErrorTitle,
        description:
            'User registration incomplete. Please check your connection and try again',
      );
      return;
    }

    customer.userId = serviceResponse.insertId;

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
    } else {
      //Get the user from firestore
      String uid = serviceResponse.response;
      getCustomerFromDatabase(uid);
    }
  }

  void getCustomerFromDatabase(String uid) async {
    final Customer customer = await _usersTable.getUserByFirebaseId(uid);

    if (customer == null) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
          title: loginErrorTitle,
          description:
              'Your user details were not retrieved. Check your connection and try again.');
      return;
    }

    setSharedPreferencesForCustomer(customer);
  }

  void setSharedPreferencesForCustomer(Customer customer) async {
    //Save user data locally
    final ServiceResponse serviceResponse =
        await _sharedPreferences.set(customer.toMap());

    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
          title: signUpErrorTitle, description: serviceResponse.response);
      return;
    }

    changeState(ViewState.Idle);

    //Navigate to HomeView
    if (customer.isShopOwner) {
      setStoreSharedPreferences(customer.userId);
      _navigationService.replaceWith(OwnerHomeView.routeName);
    } else {
      _navigationService.replaceWith(HomeView.routeName);
    }
  }

  Future setStoreSharedPreferences(String storeId) async {
    Store store = await _storesTable.getStoreByUserId(storeId);
    if (store != null) {
      _sharedPreferences.set(store.toMap());
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
    bool emailExists = await _usersTable.emailExists(email);
    if (!emailExists) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
        title: 'Unregistered email address',
        description:
        'Please review your email address. Check it does not have a typo and '
            'that it is the one you registered with',
      );
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

    DialogResponse dialogResponse = await _dialogService.showDialog(
        title: 'Reset Link Sent', description: serviceResponse.response);

    if (dialogResponse.confirmed) {
      _navigationService.navigateTo(LoginView.routeName);
    }

    changeState(ViewState.Idle);
  }

}
