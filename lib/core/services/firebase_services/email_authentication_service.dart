import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("[EmailAuthenticationService] : $e");
    }
  }
}
