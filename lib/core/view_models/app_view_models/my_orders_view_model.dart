import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/order.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/database_services/orders_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:stacked_services/stacked_services.dart';

class MyOrdersViewModel extends BaseViewModel {
  final OrdersTable _ordersTable = new OrdersTable();
  final SharedPreferencesService _sharedPreferencesService = locator<SharedPreferencesService>();
  final SnackbarService _snackbarService = new SnackbarService();

  Future<List<Order>> getAllOrdersByUser() async {
    List<Order> orders = [];
    try {
      ServiceResponse serviceResponse = await _sharedPreferencesService.getCustomerId();
      String userId = serviceResponse.response;
      orders = await _ordersTable.getOrdersByUser(userId);
    } catch (e) {
      _snackbarService.showSnackbar(message: e.toString());
    }
    return orders;
  }
}
