import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
import 'package:shop_ke/core/view_models/owner_view_models/inventory_view_model.dart';
import 'package:shop_ke/ui/shared/drawers/owner_drawer.dart';
import 'package:shop_ke/ui/shared/widgets/loading_view.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/views/store_owner/add_product_view.dart';

class InventoryView extends StatelessWidget {
  static const routeName = '/inventory';

  @override
  Widget build(BuildContext context) {
    return BaseView<InventoryViewModel>(
      builder: (context, model, child) => Scaffold(
        drawer: OwnerDrawer(),
        appBar: AppBar(
          title: Text('My Inventory'),
        ),
        body: FutureBuilder(
          future: model.getStoreProducts(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {

            if(snapshot.hasError) {
              print(snapshot.error);
              return LoadingView(title: 'Error retrieving products');

            } else if(snapshot.hasData) {
              List<Product> products = snapshot.data;

              if(products.length > 0) {
                return LoadingView(title: 'Products retrieved', hasProgressIndicator: false);
              } else {
                return LoadingView(title: 'Your inventory is empty. Add products below', hasProgressIndicator: false);
              }

            }else {
              return LoadingView();
            }

          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(AddProductView.routeName);
          },
        ),
      ),
    );
  }
}
