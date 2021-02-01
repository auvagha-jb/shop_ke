import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/services/database_services/products_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/shared/forms/form_validation.dart';
import 'package:shop_ke/ui/views/general/search_products_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ShoppingAppbarViewModel extends BaseViewModel {
  bool isCartExtended = false;
  bool isSearchBarActive = false;
  final _formValidation = FormValidation();
  final _productsTable = ProductsTable();
  final SnackbarService _snackBarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void retractCart() {
    isCartExtended = false;
    notifyListeners();
  }

  void extendCart() {
    isCartExtended = true;
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

  void searchProducts(String searchTerm) async {
    changeState(ViewState.Busy);
    print(searchTerm);
    //Validate
    String validation = _formValidation.isAlphanumeric(searchTerm, emptyString: 'Enter product name or category');
    if (validation != null) {
      _snackBarService.showSnackbar(message: validation);
      changeState(ViewState.Idle);
      return;
    }
    //If validation passes, send this to search function
    List<Product> searchResults = await _productsTable.searchProductsByName(searchTerm);

    print('Search results : $searchResults');
    changeState(ViewState.Idle);
    _navigationService.navigateTo(SearchProductsView.routeName, arguments: searchResults);
  }


}
