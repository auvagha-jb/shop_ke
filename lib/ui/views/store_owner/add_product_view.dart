
import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/data_models/product.dart';
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
  final Product _product = Product();

  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _priceController = TextEditingController();
  final _numInStockController = TextEditingController();

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
                      height: 0.8,
                      appBar: _appBar,
                      child: Column(
                        children: <Widget>[

                          //Product name
                          TextFormField(
                            controller: _productNameController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _productNameController,
                              labelText: 'Product Name',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _product.productName = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Description
                          TextFormField(
                            controller: _descriptionController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _descriptionController,
                              labelText: 'Description',
                            ),
                            maxLines: 3,
                            validator: (value) => null,
                            onChanged: (value) => _product.description = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Image Url
                          TextFormField(
                            controller: _imageUrlController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _imageUrlController,
                              labelText: 'Image',
                            ),
                            validator: (value) => null,
                            onChanged: (value) => _product.imageUrl = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Description
                          TextFormField(
                            controller: _priceController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _priceController,
                              labelText: 'Price',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _product.price = double.parse(value),
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Description
                          TextFormField(
                            controller: _numInStockController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: _numInStockController,
                              labelText: 'Number in stock',
                            ),
                            validator: (value) =>
                                model.validate.integerInputValidation(value, maxLength: 3),
                            onChanged: (value) => _product.numInStock = int.parse(value),
                          ),

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
                                  text: 'ADD PRODUCT',
                                  onPressed: () {//
                                    model.addProduct(_formKey, _product);
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
