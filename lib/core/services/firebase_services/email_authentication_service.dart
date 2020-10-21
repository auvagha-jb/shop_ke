import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/service_response.dart';

class EmailAuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user != null;
    } catch (e) {
      return e.message;
    }
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

      if(result.user == null) {
        throw new Exception('Null user was returned');
      }

      status = true;
      response = result.user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        response = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        response = 'The account already exists for that email.';
      }
    } catch (e) {
      response = e.toString();
      print("[signUpWithEmail] : $e");
    }

    return ServiceResponse(
      status: status,
      response: response
    );
  }
}
