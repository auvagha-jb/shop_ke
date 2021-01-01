import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/ui/widgets/products_grid/product_grid_tile.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;

  const ProductsGridView(this.products, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        final product = products[index];

        //ListView Items
        return Container(
          child: Dismissible(
            key: Key(product.productId),
            background: Container(
              color: Theme.of(context).accentColor,
              child: ListTile(
                trailing: Text('Delete'),
              ),
            ),

            //Action to be taken once the tile has been dismissed
            onDismissed: (direction) {
//            cart.deleteProduct(context, index, product);
            },
            child: ProductGridTile(index: index, product: product),
          ),
        );
      },
    );
  }
}
