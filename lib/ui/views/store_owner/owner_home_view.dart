import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/owner_view_models/owner_home_view_model.dart';
import 'package:shop_ke/ui/shared/drawers/owner_drawer.dart';
import 'package:shop_ke/ui/shared/owner/shop_name_text.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/views/store_owner/register_store_view.dart';

class OwnerHomeView extends StatelessWidget {
  static const routeName = '/owner-home';

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerHomeViewModel>(
      builder: (context, model, child) => Scaffold(
        drawer: OwnerDrawer(),
        appBar: AppBar(
          title: ShopNameText(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).pushNamed(RegisterStoreView.routeName);
          },
        ),
      ),
    );
  }
}
