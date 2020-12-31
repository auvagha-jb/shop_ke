import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/database_services/products_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:stacked_services/stacked_services.dart';

class InventoryViewModel extends BaseViewModel {
  final validate = FormValidation();
  final _productsTable = ProductsTable();
  final _sharedPreferences = locator<SharedPreferencesService>();
  final _snackbarService =  locator<SnackbarService>();

  Future<List<Product>>getStoreProducts() async {
    List<Product> products = [];

    //Get storeId from sharedPreferences
    ServiceResponse serviceResponse = await _sharedPreferences.getStore();
    if(!serviceResponse.status) {
      _snackbarService.showSnackbar(message: serviceResponse.response);
      return [];
    }
    Store store = serviceResponse.response;

    //Get the products list
    products = await _productsTable.getProductsByStore(store.storeId);

    return products;
  }

}
