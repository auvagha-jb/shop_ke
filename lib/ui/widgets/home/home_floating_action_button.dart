import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/app_view_models/home_view_model.dart';
import 'package:shop_ke/ui/widgets/cart/products_list_view.dart';
import 'package:shop_ke/ui/widgets/cart/cart_card.dart';
import 'package:shop_ke/ui/widgets/cart/cart_card_header.dart';

class HomeFloatingActionButton extends StatelessWidget {
  final HomeViewModel model;

  const HomeFloatingActionButton({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart),
      onPressed: () {
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
    );
  }
}
