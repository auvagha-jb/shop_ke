import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/order.dart';
import 'package:shop_ke/ui/shared/cards/card_tile.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final int index;

  const OrderTile(this.order, {Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardTile(
      child: ListTile(
        title: Text('${order.createdAt}'),
        trailing: Text('KES ${order.orderTotal}'),
      ),
    );
  }
}
