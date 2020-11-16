import 'package:flutter/cupertino.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/firestore_models/store.dart';
import 'package:shop_ke/core/view_models/base_view_model.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';

class RegisterStoreViewModel extends BaseViewModel {
  final validate = FormValidation();

  void setIndustry(Store store, value) {
    store.industry = value;
    notifyListeners();
  }

  void setCounty(Store store, value) {
    store.county = value;
    notifyListeners();
  }

  void registerNewStore(GlobalKey<FormState> formKey, Store store) async {
    changeState(ViewState.Busy);

    if (!validate.formValidation(formKey)) {
      changeState(ViewState.Idle);
      return;
    }

    changeState(ViewState.Idle);
  }
}
