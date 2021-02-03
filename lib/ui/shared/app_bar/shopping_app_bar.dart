import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/view_models/app_view_models/shopping_app_bar_view_model.dart';
import 'package:shop_ke/ui/shared/widgets/app_circular_progress_indicator.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/cart/cart_card.dart';
import 'package:shop_ke/ui/widgets/cart/cart_card_header.dart';
import 'package:shop_ke/ui/widgets/cart/products_list_view.dart';

class ShoppingAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _ShoppingAppBarState createState() => _ShoppingAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _ShoppingAppBarState extends State<ShoppingAppBar> {
  final TextEditingController _searchBarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ShoppingAppbarViewModel>(
      builder: (context, model, child) => AppBar(
        //If the search button has been tapped,
        //Display the search TextField
        //Else display the screen title
        title: !model.isSearchBarActive
            //Search bar == idle
            ? Text('Home')

            // Search bar == active
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
                !model.isSearchBarActive ? model.showSearchBar() : model.searchProducts(_searchBarController.text);
              },
              child:
                  //If state is idle (i.e. not performing a search query)
                  //Then show the search icon
                  //Else show the progress indicator
                  model.state == ViewState.Idle
                      ? Icon(
                          Icons.search,
                          size: 26.0,
                        )
                      : AppCircularProgressIndicator(),
            ),
          ),
          !model.isCartExtended
              ? Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      final bottomSheetController = showBottomSheet(
                        context: context,
                        builder: (context) => CartCard(
                          header: CartCardHeader(title: 'My Cart'),
                          child: ProductsListView(),
                        ),
                      );
                      model.extendCart();

                      bottomSheetController.closed.then((value) => model.retractCart());
                    },
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 26.0,
                    ),
                  ),
                )
              : Text(''),
        ],
      ),
    );
  }
}
