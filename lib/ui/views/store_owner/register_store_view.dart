import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/view_models/store_owner_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class RegisterStoreView extends StatefulWidget {
  static const routeName = '/register-store';

  @override
  _RegisterStoreViewState createState() => _RegisterStoreViewState();
}

class _RegisterStoreViewState extends State<RegisterStoreView> {
  final _formKey = GlobalKey<FormState>();
  final _customer = Customer();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();
  final passwordController = TextEditingController();

  final appBar = AppBar(
    title: Text('New Account'),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<OwnerViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: appBar,
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
                          //First name
                          TextFormField(
                            controller: firstNameController,
                            decoration: FormHelper.buildInputDecoration(
                                controller: firstNameController,
                                labelText: 'First Name'),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _customer.firstName = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Last name
                          TextFormField(
                            controller: lastNameController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: lastNameController,
                              labelText: 'Last Name',
                            ),
                            validator: (value) =>
                                model.validate.defaultValidation(value),
                            onChanged: (value) => _customer.lastName = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Email Address
                          TextFormField(
                            controller: emailAddressController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: FormHelper.buildInputDecoration(
                              controller: emailAddressController,
                              labelText: 'Email Address',
                            ),
                            validator: (value) =>
                                model.validate.emailValidation(value),
                            onChanged: (value) => _customer.email = value,
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Phone number row
                          Row(
                            children: <Widget>[
                              //Country Code
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  enabled: false,
                                  controller: countryCodeController,
                                  decoration: InputDecoration(
                                    labelText: 'Code',
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),

                              //Phone number input field
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  controller: phoneNumberController,
                                  keyboardType: TextInputType.number,
                                  decoration: FormHelper.buildInputDecoration(
                                    controller: phoneNumberController,
                                    labelText: 'Phone Number',
                                  ),
                                  validator: (value) =>
                                      model.validate.phoneValidation(value),
                                  onChanged: (value) =>
                                      _customer.phoneNumber = value.trim(),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: FormHelper.formFieldSpacing),

                          //Password
                          TextFormField(
                            keyboardType: TextInputType.text,
                            controller: passwordController,
                            decoration: FormHelper.buildInputDecoration(
                              controller: passwordController,
                              labelText: 'Password',
                            ),
                            validator: (value) =>
                                model.validate.passwordValidation(value),
                            onChanged: (value) => _customer.password = value,
                            obscureText: true,
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
                                  onPressed: () async {

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
