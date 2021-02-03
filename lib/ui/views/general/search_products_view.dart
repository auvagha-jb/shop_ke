import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/view_models/app_view_models/search_products_view_model.dart';
import 'package:shop_ke/ui/shared/app_bar/shopping_app_bar.dart';
import 'package:shop_ke/ui/shared/drawers/app_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/products_grid/products_grid_view.dart';

class SearchProductsView extends StatefulWidget {
  static const routeName = '/search-products';
  final List<Product> products;

  const SearchProductsView(this.products, {Key key}) : super(key: key);

  @override
  _SearchProductsViewState createState() => _SearchProductsViewState();
}

class _SearchProductsViewState extends State<SearchProductsView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SearchProductViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ShoppingAppBar(),
          drawer: AppDrawer(),
          body: widget.products.length > 0
              ? ProductsGridView(widget.products)
              : LoadingView(
                  title: 'No Products were found',
                  description: 'Try using a different keyword in the search box above',
                  hasProgressIndicator: false,
                ),
        ),
      ),
    );
  }
}
