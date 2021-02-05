import 'package:shop_ke/core/models/app_models/cart.dart';
import 'package:shop_ke/core/models/app_models/service_response.dart';
import 'package:shop_ke/core/models/data_models/order.dart';
import 'package:shop_ke/core/services/app_services/shared_preferences_service.dart';
import 'package:shop_ke/core/services/database_services/orders_table.dart';
import 'package:shop_ke/core/view_models/app_view_models/base_view_model.dart';
import 'package:shop_ke/locator.dart';
import 'package:shop_ke/ui/views/general/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmOrderViewModel extends BaseViewModel {
  final _ordersTable = OrdersTable();
  final SharedPreferencesService _sharedPreferencesService = locator<SharedPreferencesService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void confirmOrder(Cart cart) async {
    try {
      ServiceResponse serviceResponse = await _sharedPreferencesService.getCustomerId();

      Order order = Order(userId: serviceResponse.response);
      order.orderTotal = cart.productsTotal;

      await _ordersTable.insertOrder(order, cart.products);

      DialogResponse dialogResponse = await _dialogService.showDialog(
        title: 'Order Placed',
        description: 'The vendor has received your order',
      );

      if(dialogResponse.confirmed) {
        //Remove all items
        cart.removeAllItems();

        //Change this to orders view
        _navigationService.replaceWith(HomeView.routeName);
      }

    } catch (e) {
      _dialogService.showDialog(title: 'Order incomplete', description: e.toString());
    }
  }
}
