import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/database_services/products_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';

class InventoryViewModel extends BaseViewModel {
  final validate = FormValidation();
  final _productsTable = ProductsTable();
  final _sharedPreferences = locator<SharedPreferencesService>();

  //Get the products for FutureBuilder
  Future<List<Product>>getStoreProducts() async {
    List<Product> products = [];

    //Get storeId from sharedPreferences
    ServiceResponse serviceResponse = await _sharedPreferences.getStore();
    if(!serviceResponse.status) {
      throw Exception(serviceResponse.response);
    }

    //On success: Get the products list
    Store store = serviceResponse.response;
    products = await _productsTable.getProductsByStore(store.storeId);

    return products;
  }

}
