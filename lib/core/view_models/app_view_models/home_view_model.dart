import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/services/database_services/products_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  bool cartOccupiesFullScreen = false;
  bool isSearchBarActive = false;
  final _productsTable = ProductsTable();

  void retractCart() {
    cartOccupiesFullScreen = false;
    notifyListeners();
  }

  void extendCart() {
    cartOccupiesFullScreen = true;
    notifyListeners();
  }

  void showSearchBar() {
    isSearchBarActive = true;
    notifyListeners();
  }

  void hideSearchBar() {
    isSearchBarActive = false;
    notifyListeners();
  }

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    products = await _productsTable.getAllProducts();
    return products;
  }

  void searchProducts(String searchWord) {
    print(searchWord);
    //Start by writing search function
    //Validate

    //If validation passes, send this to search function

  }
}
