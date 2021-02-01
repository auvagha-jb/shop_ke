import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ke/core/models/app_models/cart.dart';
import 'package:shop_ke/core/models/data_models/product.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;

  ProductGridTile(this.product);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    String labelText = product.quantity > 0 ? '${product.quantity}' : '';

    return Card(
      child: Hero(
          tag: product.productId,//Make sure this is unique because duplicate tags will throw an error
          child: Material(
            child: InkWell(
              onTap: () {},
              child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    title: Text(
                      product.productName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "KES ${product.price}",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
//                    trailing: Text(
//                      "KES ${product.price}",
//                      style: TextStyle(
//                          color: Colors.black54,
//                          fontWeight: FontWeight.w800,
//                          decoration: TextDecoration.lineThrough),
//                    ),
                    trailing: FlatButton.icon(
                      onPressed: () {
                        cart.addProduct(context, product);
                      },
                      icon: Icon(Icons.add_circle_outline),
                      label: Text(labelText),
                    ),
                  ),
                ),
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
