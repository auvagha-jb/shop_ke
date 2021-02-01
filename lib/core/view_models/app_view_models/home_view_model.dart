import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/services/database_services/products_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  final _productsTable = ProductsTable();

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    products = await _productsTable.getAllProducts();
    return products;
  }

}
