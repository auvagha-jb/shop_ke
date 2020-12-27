import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/database_services/stores.dart';
import 'package:shop_ke/core/services/shared_preferences_service.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:shop_ke/ui/views/store_owner/owner_home_view.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterStoreViewModel extends BaseViewModel {
  final validate = FormValidation();
  final _sharedPreferences = locator<SharedPreferencesService>();
  final _dialogService = locator<DialogService>();
  final _navigationService = locator<NavigationService>();

  void setIndustry(Store store, value) {
    store.industry = value;
    notifyListeners();
  }

  void setCounty(Store store, String value) {
    store.county = value;
    notifyListeners();
  }

  void registerNewStore(GlobalKey<FormState> formKey, Store store) async {
    changeState(ViewState.Busy);

    if (!validate.formValidation(formKey)) {
      changeState(ViewState.Idle);
      return;
    }

    //Get the userId from sharedPreferences and set
    final String errorTitle = 'Error';

    //Get the userId from sharedPreferences
    ServiceResponse serviceResponse;
    String userId;
    serviceResponse = await _sharedPreferences.getCustomerId();

    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
        title: errorTitle,
        description: serviceResponse.response,
      );
      return;
    } else {
      userId = serviceResponse.response;
    }

    //Add the store to database
    serviceResponse = await Stores().insertStore(store, userId);
    if (!serviceResponse.status) {
      changeState(ViewState.Idle);
      _dialogService.showDialog(
        title: errorTitle,
        description: serviceResponse.response,
      );
      return;
    } else {
      store.storeId = serviceResponse.insertId;
    }


    //Add the store details to shared preferences
    serviceResponse = await _sharedPreferences.set(store.toMap());
    if (!serviceResponse.status) {
      _dialogService.showDialog(
        title: errorTitle,
        description: serviceResponse.response,
      );
    } else {
      _navigationService.replaceWith(OwnerHomeView.routeName);
    }

    changeState(ViewState.Idle);
  }
}
