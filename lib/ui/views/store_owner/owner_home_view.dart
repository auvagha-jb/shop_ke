import 'package:flutter/material.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/models/service_response.dart';
import 'package:shop_ke/core/services/database_services/users.js.dart';
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
          onPressed: () async {
            final Customer customer = await new Users().getUserById(1);
            print(customer.toMap());

            final newCustomer = Customer.fromMap({
              'firebaseId': 'asdbjhv1',
              'firstName': 'Test',
              'lastName': 'User',
              'email': 'jerry.auvagha@gmail.com',
              'countryCode': '+254',
              'phoneNumber': '722309497',
              'isShopOwner': 1
            });

            final ServiceResponse serviceResponse =
                await new Users().insert(newCustomer);

            print(serviceResponse);
            Navigator.of(context).pushNamed(RegisterStoreView.routeName);
          },
        ),
      ),
    );
  }
}
