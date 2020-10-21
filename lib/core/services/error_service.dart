import 'package:flutter/cupertino.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/models/ui_response.dart';
import 'package:shop_ke/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class ErrorService {
  final DialogService _dialogService = locator<DialogService>();

  void showSnapshotError(AsyncSnapshot snapshot, UIResponse uiResponse) {
    print('Camera error : ${snapshot.error}');

    _dialogService.showDialog(
      title: uiResponse.title,
      description: uiResponse.message,
    );
  }

  void showErrorDialog(String title, String message) {
    final response = UIResponse(title: title, message: message);

    //Show error dialog
    _dialogService.showDialog(
      title: response.title,
      description: response.message,
    );
  }

  void showServiceResponseError(ServiceResponse serviceResponse) {
    final UIResponse response = serviceResponse.response as UIResponse;

    //Show error dialog
    _dialogService.showDialog(
      title: response.title,
      description: response.message,
    );
  }

  void showUIResponseError(UIResponse response) {
    //Show error dialog
    _dialogService.showDialog(
      title: response.title,
      description: response.message,
    );
  }
}
