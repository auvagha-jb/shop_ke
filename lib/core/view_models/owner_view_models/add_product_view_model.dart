import 'package:flutter/cupertino.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/database_services/products_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:stacked_services/stacked_services.dart';

class AddProductViewModel extends BaseViewModel {
  final validate = FormValidation();
  final ProductsTable _productsTable = ProductsTable();
  final _sharedPreferencesService = locator<SharedPreferencesService>();
  final  _snackbarService = locator<SnackbarService>();

  //Controllers
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageUrlController = TextEditingController();
  final priceController = TextEditingController();
  final numInStockController = TextEditingController();

  void addProduct(GlobalKey<FormState> formKey, Product product) async{
    //Form validation
    if(!validate.formValidation(formKey)) {
      return;
    }

    //Get the storeId from sharedPreferences
    ServiceResponse serviceResponse = await _sharedPreferencesService.getStore();

    if(!serviceResponse.status) {
      _snackbarService.showSnackbar(message: "Couldn't fetch store details. Logout and try again");
      return;
    }

    Store storeFromSharedPref = serviceResponse.response;
    product.storeId = storeFromSharedPref.storeId;

    //Insert the product into the database
    serviceResponse = await _productsTable.insertProduct(product);

    //On failure
    if(!serviceResponse.status) {
      _snackbarService.showSnackbar(message: 'Something went wrong. Check your connection ad try again');
      return;
    }

    //On success
    _snackbarService.showSnackbar(message: '${product.productName} added!');
    formKey.currentState.reset();
  }
}
