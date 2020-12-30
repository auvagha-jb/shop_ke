import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/app_models/cart.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/ui/shared/cards/card_tile.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/widgets/circle_network_image.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  final int index;
  //final String shoppingListId;

  ProductTile(this.index);

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    return InkWell(
      //To enable tap interactions
      onTap: () {}, //product.changeEnabledStatus(product.isEnabled);
      child: CardTile(
        child: CardContent(
          product: product,
          index: widget.index,
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    Key key,
    @required this.product,
    @required this.index,
  }) : super(key: key);

  final Product product;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              //Safety check to avoid zero and negative quantities
              if (product.quantity > 1) {
                //Product Actions
                product.decrementQuantityAndSubtotal();

                //Cart Actions
                cart.decrementNoItems();
                cart.decreaseProductsTotal(product.price);

                //Action to take when the quantity is zero
              } else {
                cart.deleteProduct(context, index, product);
              }
            },
          ),
          CircleNetworkImage(product.imageUrl),
          SizedBox(width: 10),
          Expanded(flex: 4, child: Text('${product.productName}')),
          ResponsiveContainer(
            height: 0.12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('${product.price}'),
                Text('x ${product.quantity}'),
                Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).accentColor),
                  ),
                  child: Text(
                    '${product.subtotal.toStringAsFixed(2)}',
                    style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              //Product actions
              product.incrementQuantityAndSubtotal();

              //Cart Actions
              cart.incrementNoItems();
              cart.increaseProductsTotal(product.price);
            },
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
