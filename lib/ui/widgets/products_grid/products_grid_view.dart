import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/ui/widgets/products_grid/product_grid_tile.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;

  ProductsGridView(this.products, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        Product product = products[index];
        return ProductGridTile(product);
      },
    );
  }
}
