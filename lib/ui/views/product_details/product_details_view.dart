import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';


class ProductDetailsView extends StatelessWidget {
  static const routeName = "/product-details";
  final Product product;

  const ProductDetailsView(this.product, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: 0),//TODO: Rating System
      body: Body(product: product),
    );
  }
}


