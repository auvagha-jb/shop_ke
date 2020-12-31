import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';

class ProductsTable extends ApiService {
  Future<ServiceResponse> insertProduct(Product product) async {
    final endpoint = route("product/");
    ServiceResponse serviceResponse =
    await super.post(endpoint: endpoint, map: product.toMap());
    return serviceResponse;
  }

  Future<List<Product>> _getProducts(String endpoint) async {
    final List<dynamic> productsList = await super.getList(endpoint);
    List<Product> products = [];

    if (productsList.length > 0) {
      for (var product in productsList) {
        products.add(Product.fromMap(product));
      }
    }

    return products;
  }

  Future<List<Product>> getAllProducts() async {
    final endpoint = route('product/');
    final List<Product> products = await this._getProducts(endpoint);
    return products;
  }

  Future<List<Product>> getProductsByStore(String storeId) async {
    final endpoint = route('product/store/$storeId');
    final List<Product> products = await this._getProducts(endpoint);
    return products;
  }
}
