import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/app_models/cart.dart';
import 'package:shop_ke/ui/widgets/cart/product_tile.dart';
import 'package:provider/provider.dart';

class ProductsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productsList = cart.productsList;
    final deleteText = Text(
      'Delete',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white, fontSize: 16),
    );

    //Check if there is a product present in the cart
    print('No of products: ${productsList.length}');

    return productsList.length > 0
        ? ListView.builder(
            itemCount: productsList.length,
            itemBuilder: (ctx, index) {
              final product = productsList[index];

              //ListView Items
              return ChangeNotifierProvider.value(
                value: product,
                //The Dismissible wrapper
                child: Dismissible(
                  key: Key(product.productId),
                  background: Container(
                    color: Theme.of(context).accentColor,
                    child: ListTile(
                      trailing: deleteText,
                    ),
                  ),

                  //Action to be taken once the tile has been dismissed
                  onDismissed: (direction) {
                    cart.deleteProduct(context, index, product);
                  },
                  child: ProductTile(index),
                ),
              );
            },
          )
        : Center(child: Text('No Products scanned'));
  }
}
