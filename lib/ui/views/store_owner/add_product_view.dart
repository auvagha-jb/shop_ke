import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/data_models/store.dart';
import 'package:shop_ke/core/view_models/owner_view_models/add_product_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class AddProductView extends StatefulWidget {
  static const routeName = '/add-product';

  @override
  _AddProductViewState createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  final _formKey = GlobalKey<FormState>();
  final Store _store = Store();

  final _storeNameController = TextEditingController();
  final _physicalAddressController = TextEditingController();
  final _logoController = TextEditingController();

  final _appBar = AppBar(
    title: Text('Add Product'),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AddProductViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: _appBar,
          body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: FormHelper.verticalPadding,
                horizontal: FormHelper.sidePadding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Top half of the screen
                    ResponsiveContainer(
                      height: 0.7,
                      appBar: _appBar,
                      child: Column(
                        children: <Widget>[
                          //Store name
                          TextFormField(
                            controller: _storeNameController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _storeNameController,
                              labelText: 'Store Name',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _store.storeName = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Logo
                          TextFormField(
                            controller: _logoController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _logoController,
                              labelText: 'Logo',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _store.logo = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Physical address
                          TextFormField(
                            controller: _physicalAddressController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _physicalAddressController,
                              labelText: 'Physical Address (Optional)',
                            ),
                            onChanged: (value) =>
                                _store.physicalAddress = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          SizedBox(height: FormHelper.formFieldSpacing),
                        ],
                      ),
                    ),

                    //Bottom half of the screen
                    Container(
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Form submit button
                          model.state == ViewState.Idle
                              ? AppButton(
                                  text: 'CONTINUE',
                                  onPressed: () async {
//                                    model.registerNewStore(_formKey, _store);
//                                    var storeMap = {
//                                      "storeId":
//                                          "43c250ff-f0c4-4a9a-946e-8695fcd21773",
//                                      "productName": "Pooh action figure",
//                                      "description": null,
//                                      "image": null,
//                                      "price": "9.99",
//                                      "numInStock": "5"
//                                    };
                                  },
                                  buttonType: ButtonType.Secondary,
                                )

                              //When busy, show the progress indicator button
                              : AppProgressButton(
                                  buttonType: ButtonType.Secondary,
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
