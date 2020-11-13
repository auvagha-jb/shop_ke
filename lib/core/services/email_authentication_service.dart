import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/error_service.dart';
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
}
