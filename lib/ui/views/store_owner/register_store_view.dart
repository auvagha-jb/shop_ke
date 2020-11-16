import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/firestore_models/store.dart';
import 'package:shop_ke/core/view_models/owner_view_models/register_store_view_model.dart';
import 'package:shop_ke/ui/constants/county_list.dart';
import 'package:shop_ke/ui/constants/industry_list.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/shared/widgets/app_dropdown.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class RegisterStoreView extends StatefulWidget {
  static const routeName = '/register-store';

  @override
  _RegisterStoreViewState createState() => _RegisterStoreViewState();
}

class _RegisterStoreViewState extends State<RegisterStoreView> {
  final _formKey = GlobalKey<FormState>();
  final Store _store = Store();

  final storeNameController = TextEditingController();
  final physicalAddressController = TextEditingController();
  final logoController = TextEditingController();

  final appBar = AppBar(
    title: Text('New Store'),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterStoreViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('New Store'),
          ),
          body: Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                vertical: FormHelper.verticalPadding,
                horizontal: FormHelper.sidePadding,
              ),
              //Sign up form
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //Top half of the screen
                    ResponsiveContainer(
                      height: 0.7,
                      appBar: appBar,
                      child: Column(
                        children: <Widget>[
                          //Store name
                          TextFormField(
                            controller: storeNameController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: storeNameController,
                              labelText: 'Store Name',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _store.name = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Logo
                          TextFormField(
                            controller: logoController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: logoController,
                              labelText: 'Logo',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _store.logo = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Physical address
                          TextFormField(
                            controller: physicalAddressController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: physicalAddressController,
                              labelText: 'Physical Address (Optional)',
                            ),
                            onChanged: (value) =>
                                _store.physicalAddress = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Industries Dropdown
                          AppDropdown(
                            value: _store.industry,
                            validatorValue: model.validate.dropdownValidation(
                              value: _store.industry,
                              defaultValue: Store.defaultIndustry,
                              errorFeedback: 'Please select your industry',
                            ),
                            onChanged: (value) {
                              model.setIndustry(_store, value);
                              print('industry: ${_store.industry}');
                            },
                            items: industryList,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          AppDropdown(
                            value: _store.county,
                            validatorValue: model.validate.dropdownValidation(
                              value: _store.county,
                              defaultValue: Store.defaultCounty,
                              errorFeedback: 'Please select your county',
                            ),
                            onChanged: (value) {
                              model.setCounty(_store, value);
                              print('county: ${_store.county} ');
                            },
                            items: countyList,
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
                                  text: 'CONTINUE',
                            onPressed: () {
                              model.registerNewStore(_formKey, _store);
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
