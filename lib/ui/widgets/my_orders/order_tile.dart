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

//class CardContent extends StatelessWidget {
//  const CardContent({
//    Key key,
//    @required this.order,
//    @required this.index,
//  }) : super(key: key);
//
//  final Order order;
//  final int index;
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: EdgeInsets.all(8.0),
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//        children: <Widget>[
//          Text
//          Expanded(flex: 4, child: Text('${order.createdAt}')),
//          ResponsiveContainer(
//            height: 0.12,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Text('${order.price}'),
//                Text('x ${order.quantity}'),
//                Container(
//                  padding: EdgeInsets.all(3.0),
//                  decoration: BoxDecoration(
//                    border: Border.all(color: Theme.of(context).accentColor),
//                  ),
//                  child: Text(
//                    '${order.subtotal.toStringAsFixed(2)}',
//                    style: TextStyle(color: Theme.of(context).accentColor),
//                  ),
//                ),
//              ],
//            ),
//          ),
//
//        ],
//      ),
//    );
//  }
//}
