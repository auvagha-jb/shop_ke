import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/models/ui_response.dart';
import 'package:shop_ke/core/services/error_service.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/ui/constants/error_response_messages.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';

import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/widgets/profile/profile_edit_form.dart';
import 'package:stacked_services/stacked_services.dart';
import 'base_view_model.dart';

class ProfileViewModel extends BaseViewModel {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  final validate = FormValidation();

  final SharedPreferencesService sharedPreferences =
      locator<SharedPreferencesService>();
  final ErrorService _errorService = locator<ErrorService>();
  final DialogService _dialogService = locator<DialogService>();

  void setCustomerDetails(Customer customer) {
    firstNameController.text = customer.firstName;
    lastNameController.text = customer.lastName;
    emailAddressController.text = customer.email;
    phoneNumberController.text = customer.phoneNumber;
    countryCodeController.text = customer.countryCode;
  }

  Widget profileViewFutureBuilder(AsyncSnapshot snapshot) {
    //Set default widget
    Widget defaultWidget = LoadingView();
    Widget widget = defaultWidget;

    //Once the future has been resolved, get the widget to display
    if (snapshot.connectionState == ConnectionState.done) {
      ServiceResponse serviceResponse = snapshot.data as ServiceResponse;
      widget = getWidget(snapshot, serviceResponse);
    }

    return widget;
  }

  Widget getWidget(AsyncSnapshot snapshot, ServiceResponse serviceResponse) {
    //Default widget
    Widget widget = LoadingView();

    //Error check for snapshot
    if (snapshot.hasError) {
      _errorService.showSnapshotError(snapshot, generalExceptionResponse);
      return widget;
    }

    //Error check for serviceResponse: returns UIResponse object
    if (!serviceResponse.status) {
      UIResponse uiResponse = serviceResponse.response;
      _dialogService.showDialog(
          title: uiResponse.title, description: uiResponse.message);
      return widget;
    }

    //If no errors exist
    Customer customer = serviceResponse.response as Customer;
    print("Snapshot ${inspect(customer)}");
    widget = ProfileEditForm(customer: customer);
    return widget;
  }
}
