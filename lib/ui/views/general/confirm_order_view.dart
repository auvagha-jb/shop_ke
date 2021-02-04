import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/models/app_models/cart.dart';
import 'package:shop_ke/core/view_models/app_view_models/confirm_order_view_model.dart';
import 'package:shop_ke/ui/shared/app_button.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';
import 'package:shop_ke/ui/widgets/cart/products_list_view.dart';

class ConfirmOrderView extends StatelessWidget {
  static const routeName = '/confirm-order';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return BaseView<ConfirmOrderViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('New Order'),
        ),
        body: ProductsListView(),
        floatingActionButton:
            //If the cart has products present,
            //then display the confirm order button
            //else hide the floating action button
            cart.productsList.length > 0
                ? AppButton(
                    buttonType: ButtonType.Secondary,
                    text: 'CONFIRM ORDER OF KES ${cart.productsTotalRoundedOff}',
                    onPressed: () {
                      model.confirmOrder(cart);
                    },
                  )
                : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
