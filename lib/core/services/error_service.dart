import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_ke/core/models/ui_response.dart';
import 'package:shop_ke/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class ErrorService {
  final DialogService _dialogService = locator<DialogService>();

  void showSnapshotError(AsyncSnapshot snapshot, UIResponse uiResponse) {
    print('Snapshot error : ${snapshot.error}');

    _dialogService.showDialog(
      title: uiResponse.title,
      description: uiResponse.message,
    );
  }

  String getFirebaseSignUpException(FirebaseAuthException e) {
    String response;
    switch (e.code) {
      case 'weak-password':
        response = 'The password provided is too weak.';
        break;

      case 'email-already-in-use':
        response = 'The account already exists for that email.';
        break;

      case 'network-request-failed':
        response = 'Network connection timed out. Please check your connection and try again';
        break;

      default:
        response = e.toString();
        break;
    }
    return response;
  }

  String getFirebaseLoginException(FirebaseAuthException e) {
    String response;
    switch (e.code) {
      case 'user-not-found':
        response = 'Account for the given email not found. Ensure you login with a registered account';
        break;

        case 'wrong-password':
        response = 'Incorrect password for the given account. Forgot password? Reset it below';
        break;

      case 'network-request-failed':
        response = 'Network connection timed out. Please check your connection and try again';
        break;

      default:
        response = e.toString();
        break;
    }
    return response;
  }

}
