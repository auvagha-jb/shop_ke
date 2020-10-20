import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/user_action.dart';
import 'package:shop_ke/core/models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/ui/shared/widgets/otp_verification_sheet.dart';
import 'package:shop_ke/ui/views/home_view.dart';
import 'package:shop_ke/core/services/firebase_services/firestore_service.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import '../../../locator.dart';

class PhoneAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestoreService = locator<FirestoreService>();
  final _sharedPreferences = locator<SharedPreferencesService>();
  Customer _customer;
  BuildContext _context;

  void initPhoneAuth({
    @required String phoneNumber,
    @required BuildContext context,
    @required UserAction action,
    @required Customer customer,
  }) async {
    print('In initPhoneAuth');

    if (action == UserAction.SignUp) {
      //For login the customer is set after fetching from firestore
      _customer = customer;
    }
    _context = context;

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      timeout: Duration(seconds: 60),
      //Called for auto code retrieval

      verificationCompleted: (AuthCredential authCredential) async {
        print('In verificationCompleted');
        onVerificationComplete(
          authCredential: authCredential,
          action: action,
        );
      },

      //Called when verification fails
      verificationFailed: (FirebaseAuthException e) {
        //TODO: Show warning error
        print(e.message);
      },

      //For manually handling phone authentication
      ///Verification id is autogenerated by Firebase. Will be used later for creating auth token
      ///ForceResendToken for resending token to device
      codeSent: (String verificationId, [int forceResendingToken]) {
        print('In code sent');

        //show bottomSheetModal to take input from the user
        showVerificationModal(
          context: context,
          phoneNumber: phoneNumber,
          verificationId: verificationId,
          action: action,
        );
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        print('In codeAutoRetrievalTimeout');
      },
    );
  }

  ///Used when the otp is automatically verified once it is sent
  void onVerificationComplete({
    @required AuthCredential authCredential,
    @required UserAction action,
  }) async {
    try {
      UserCredential result = await _auth.signInWithCredential(authCredential);
      User user = result.user;

      if (user == null) {
        print('Auto verification failed. Please try again.');
        return;
      }

      //Carry out action depending on whether the user is signing up or logging in
      chooseAuthAction(action: action, uid: user.uid);

      //Redirect to the HomeView
      Navigator.of(_context).pushReplacementNamed(HomeView.routeName);
    } catch (e) {
      print('onVerificationComplete $e');
      print(e.toString());
    }
  }

  ///Used when the user manually enters the code
  Future<ServiceResponse> manualPhoneVerification({
    @required BuildContext context,
    @required String code,
    @required String verificationId,
    @required UserAction action,
  }) async {
    dynamic response;

    try {
      AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: code,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user;

      if (user == null) {
        print('Manual phone authentication failed. The code was incorrect');
        return ServiceResponse(
          status: false,
          response: nullUserExceptionResponse,
        );
      }

      chooseAuthAction(
        action: action,
        uid: user.uid,
      );

      response = user;
    } catch (e) {
      //TODO: Alert dialog
      print('Error type: ${e.runtimeType}');
      print('manualPhoneVerification:  $e');

      switch (e.runtimeType) {
        case FirebaseAuthException:
          response = codeExceptionResponse;
          break;

        default:
          response = generalAuthExceptionResponse;
          break;
      }
//      response = e.toString();
    }

    return ServiceResponse(
      status: response is User,
      response: response,
    );
  }

  void chooseAuthAction({
    @required UserAction action,
    @required String uid,
//    @required Customer customer,
  }) async {
    switch (action) {
      case UserAction.SignUp:
        onSignUp(uid);
        break;
      case UserAction.Login:
        onLogin(uid);
        break;
    }
  }

  void onSignUp(String uid) {
    _firestoreService.add(_firestoreService.customerCollection, uid, _customer);

    //Set user id
    _customer.id = uid;
    _sharedPreferences.setCustomer(_customer.toMap());
  }

  void onLogin(String uid) async {
    Customer customer = await _firestoreService.getById(
      _firestoreService.customerCollection,
      uid,
    );
    //Set user id
    _sharedPreferences.setCustomer(customer.toMap());

    //TODO: Check if the user exists
  }

  void onAuthComplete(String uid) async {}

  void showVerificationModal({
    @required context,
    @required String phoneNumber,
    @required String verificationId,
    @required UserAction action,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => OTPVerificationSheet(
        phoneNumber: phoneNumber,
        verificationId: verificationId,
        action: action,
      ),
    );
  }
}
