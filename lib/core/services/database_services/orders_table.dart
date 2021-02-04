import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/order.dart';
import 'package:shop_ke/core/models/data_models/order_item.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/services/database_services/api_service.dart';

class OrdersTable extends ApiService {

  Future<ServiceResponse> insertOrder(Order order, List<Product> products) async {
    final endpoint = route("order/");
    OrderItem orderItem = OrderItem();
    Map<String, dynamic> orderMap = {
      "order": order.toMap(),
      "orderItems": orderItem.orderItemsList(products) //List of products converted to map
    };

    ServiceResponse serviceResponse = await super.post(endpoint: endpoint, map: orderMap);
    if(!serviceResponse.status){
      throw Exception('Error in placing the order. Please try again later');
    }

    return serviceResponse;
  }

  Future<List<Order>> _getOrders(String endpoint) async {
    final List<dynamic> ordersList = await super.getList(endpoint);
    List<Order> orders = [];

    if (ordersList.length > 0) {
      for (var order in ordersList) {
        orders.add(Order.fromMap(order));
      }
    }

    return orders;
  }

  Future<List<Order>> getOrdersByUser(String userId) async {
    final endpoint = route('order/user/$userId');
    final List<Order> orders = await this._getOrders(endpoint);
    return orders;
  }
}
