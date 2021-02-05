import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/order.dart';
import 'package:shop_ke/ui/widgets/my_orders/order_tile.dart';

class OrdersListView extends StatelessWidget {
  final List<Order> orders;

  const OrdersListView(this.orders, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Check if there is a product present in the cart
    print('No of orders: ${orders.length}');

    return orders.length > 0
        ? ListView.builder(
            itemCount: orders.length,
            itemBuilder: (ctx, index) {
              final Order order = orders[index];
              //ListView Items
              return OrderTile(order, index: index);
            },
          )
        : Center(child: Text('No orders found'));
  }
}
