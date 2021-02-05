import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/order.dart';
import 'package:shop_ke/core/view_models/app_view_models/my_orders_view_model.dart';
import 'package:shop_ke/ui/shared/app_bar/shopping_app_bar.dart';
import 'package:shop_ke/ui/shared/drawers/app_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/my_orders/orders_list_view.dart';

class MyOrdersView extends StatefulWidget {
  static const routeName = '/my-orders';

  const MyOrdersView({Key key}) : super(key: key);

  @override
  _MyOrdersViewState createState() => _MyOrdersViewState();
}

class _MyOrdersViewState extends State<MyOrdersView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyOrdersViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ShoppingAppBar(title: Text('My Orders')),
          drawer: AppDrawer(),
          body: FutureBuilder(
            future: model.getAllOrdersByUser(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print('Snapshot error ${snapshot.error}');
                return LoadingView(
                  title: snapshot.error,
                  hasProgressIndicator: false,
                );
              } else if (snapshot.hasData) {
                List<Order> orders = snapshot.data;
                if (orders.length > 0) {
                  return OrdersListView(orders);
                } else {
                  return LoadingView(
                    title: 'No order history',
                    hasProgressIndicator: false,
                  );
                }
              } else {
                return LoadingView();
              }
            },
          ),
        ),
      ),
    );
  }
}
