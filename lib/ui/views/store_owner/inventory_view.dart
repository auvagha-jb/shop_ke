import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/owner_view_models/inventory_view_model.dart';
import 'package:shop_ke/ui/shared/drawers/owner_drawer.dart';
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
