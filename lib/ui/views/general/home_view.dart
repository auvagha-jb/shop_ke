import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/view_models/app_view_models/home_view_model.dart';
import 'package:shop_ke/ui/shared/drawers/app_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/cart/cart_card.dart';
import 'package:shop_ke/ui/widgets/cart/cart_card_header.dart';
import 'package:shop_ke/ui/widgets/cart/products_list_view.dart';
import 'package:shop_ke/ui/widgets/home/home_floating_action_button.dart';
import 'package:shop_ke/ui/widgets/products_grid/products_grid_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  const HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchBarController =
      new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          //AppBar
          appBar: AppBar(
            //If the search button has been tapped,
            //Display the search TextField
            //Else display the screen title
            title: !model.isSearchBarActive
                ? Text('Home')
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextField(
                      controller: _searchBarController,
                      autofocus: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Search product or category',
                        suffixIcon: IconButton(
                          onPressed: () {
                            //If text is present
                            //Clears the text field
                            //Else it hides the search bar
                            _searchBarController.text.length > 0
                                ? _searchBarController.clear()
                                : model.hideSearchBar();
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    !model.isSearchBarActive
                        ? model.showSearchBar()
                        : model.searchProducts(_searchBarController.text);
                  },
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    final bottomSheetController =
                        _scaffoldKey.currentState.showBottomSheet(
                      (context) => CartCard(
                        header: CartCardHeader(title: 'My Cart', model: model),
                        child: ProductsListView(),
                      ),
                    );
                    model.extendCart();

                    bottomSheetController.closed
                        .then((value) => model.retractCart());
                  },
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    size: 26.0,
                  ),
                ),
              ),
            ],
          ),
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
          floatingActionButton: !model.cartOccupiesFullScreen
              ? HomeFloatingActionButton(model: model)
              : null,
        ),
      ),
    );
  }
}
