import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/app_view_models/home_view_model.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';
import 'package:shop_ke/ui/widgets/home/products_list_view.dart';

import 'cart_card.dart';

class CartCardHeader extends StatelessWidget {
  final String title;
  final HomeViewModel model;

  const CartCardHeader({
    Key key,
    @required this.title,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        final bottomSheetController = showBottomSheet(
          context: context,
          builder: (context) => CartCard(
            header: CartCardHeader(title: 'My Cart', model: model),
            child: ProductsListView(),
          ),
        );

        model.extendCart();

        bottomSheetController.closed.then((value) => model.retractCart());
      },
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(title, style: darkHeader2),
              ),
            ],
          ),
          // !model.cartOccupiesFullScreen
          //     ? Text('Swipe up to view on full screen')
          //     : Text('Swipe down to return to default view'),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
