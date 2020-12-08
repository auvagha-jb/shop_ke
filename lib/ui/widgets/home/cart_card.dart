import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/models/cart.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  final Widget child;
  final Widget header;
  final bool isRoundedAtCorners;

  const CartCard({
    Key key,
    @required this.child,
    @required this.header,
    this.isRoundedAtCorners = true,
  })  : assert(child != null),
        assert(header != null),
        super(key: key);

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  double borderRadius = 40.0;
  List<Product> _inventory;

  void setInventory(BuildContext context) async {
    String productsJson = await DefaultAssetBundle.of(context)
        .loadString('assets/dummy_data/inventory.json');
    final parsed = json.decode(productsJson).cast<Map<String, dynamic>>();
    _inventory = parsed.map<Product>((json) => Product.fromMap(json)).toList();
    print('inventory length: ${_inventory.length}');
  }

  @override
  void initState() {
    setInventory(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: widget.isRoundedAtCorners
            ? BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          widget.header,
          Expanded(child: widget.child),
          //Cart Empty container with checkout button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            child: AppButton(
              text: cart.noItems > 0
                  ? 'CHECKOUT ${cart.noItems} ITEM(S) FOR KES ${cart.productsTotal.toStringAsFixed(2)}'
                  : 'CART EMPTY',
              buttonType: ButtonType.Primary,
              onPressed: () => cart.addProduct(_inventory[cart.noItems]),
            ),
          ),
        ],
      ),
    );
  }
}
