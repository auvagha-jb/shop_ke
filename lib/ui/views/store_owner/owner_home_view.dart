import 'package:flutter/material.dart';
import 'package:shop_ke/core/view_models/store_owner_view_model.dart';
import 'package:shop_ke/ui/shared/drawers/owner_drawer.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class OwnerHomeView extends StatelessWidget {
  static const routeName = '/owner-home';

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerViewModel>(
        builder:  (context, model, child) => Scaffold(
          drawer: OwnerDrawer(),
          appBar: AppBar(title: Text('ShopName?'),),
        ),
    );
  }
}
