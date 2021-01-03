import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;

  ProductGridTile(this.product);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: product.productName,
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