import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/services/app_services/error_service.dart';
import 'package:shop_ke/locator.dart';

class EmailAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _errorService = locator<ErrorService>();

  Future<ServiceResponse> loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    bool status = false;
    dynamic response;

    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw new Exception('Null user was returned');
      }

      status = true;
      response = result.user.uid;
    } on FirebaseAuthException catch (e) {
      response = _errorService.getFirebaseLoginException(e);
    } catch (e) {
      print('[loginWithEmailException] $e');
      response = e.toString();
    }

    return ServiceResponse(status: status, response: response);
  }

  Future<ServiceResponse> signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    bool status = false;
    dynamic response;

    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw new Exception('Null user was returned');
      }

      status = true;
      response = result.user;
    } on FirebaseAuthException catch (e) {
      response = _errorService.getFirebaseSignUpException(e);
    } catch (e) {
      response = e.toString();
      print("[signUpWithEmail] : $e");
    }

    return ServiceResponse(status: status, response: response);
  }

  Future<ServiceResponse> resetPassword(String email) async {
    bool status = false;
    dynamic response;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      response =
          'Password reset link sent to $email. It may take up to two minutes to arrive in your inbox';
      status = true;
    } catch (e) {
      response = e.toString();
      print('resetPasswordException $e');
    }

    return ServiceResponse(status: status, response: response);
  }
}
