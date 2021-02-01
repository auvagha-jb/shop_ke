import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/view_models/app_view_models/home_view_model.dart';
import 'package:shop_ke/ui/shared/drawers/app_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/shared/widgets/shopping_app_bar.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/products_grid/products_grid_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: ShoppingAppBar(),
          drawer: AppDrawer(),
          body: FutureBuilder(
            future: model.getAllProducts(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return LoadingView(
                  title: snapshot.error,
                  hasProgressIndicator: false,
                );
              } else if (snapshot.hasData) {
                List<Product> products = snapshot.data;

                if (products.length > 0) {
                  return ProductsGridView(products);
                } else {
                  return LoadingView(
                    title: 'No Products were found',
                    hasProgressIndicator: false,
                  );
                }
              } else {
                return LoadingView();
              }
            },
          ),
        ),
      ),
    );
  }
}
