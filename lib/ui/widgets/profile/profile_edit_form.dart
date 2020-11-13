import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/view_models/profile_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/views/base_view.dart';

class ProfileEditForm extends StatefulWidget {
  final Customer customer;

  const ProfileEditForm({Key key, this.customer})
      : assert(customer is Customer),
        super(key: key);

  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  final _formKey = GlobalKey<FormState>();
  Customer customer;

  final appBar = AppBar(
    title: Text('My Profile'),
  );

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(builder: (context, model, child) {
      customer = widget.customer;
      model.setCustomerDetails(widget.customer);
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
                    height: 0.6,
                    appBar: appBar,
                    child: Column(
                      children: <Widget>[
                        //First name
                        TextFormField(
                          controller: model.firstNameController,
                          decoration: FormHelper.buildInputDecoration(
                            controller: model.firstNameController,
                            labelText: 'First Name',
                          ),
                          validator: (value) =>
                              model.validate.defaultValidation(value),
                          onChanged: (value) => customer.firstName = value,
                        ),

                        SizedBox(height: FormHelper.formFieldSpacing),

                        //Last name
                        TextFormField(
                          controller: model.lastNameController,
                          decoration: FormHelper.buildInputDecoration(
                            controller: model.lastNameController,
                            labelText: 'Last Name',
                          ),
                          validator: (value) =>
                              model.validate.defaultValidation(value),
                          onChanged: (value) => customer.lastName = value,
                        ),

                        SizedBox(height: FormHelper.formFieldSpacing),

                        //Email Address
                        TextFormField(
                          controller: model.emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: FormHelper.buildInputDecoration(
                            controller: model.emailAddressController,
                            labelText: 'Email Address',
                          ),
                          validator: (value) =>
                              model.validate.emailValidation(value),
                          onChanged: (value) => customer.email = value,
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
                                controller: model.countryCodeController,
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
                                controller: model.phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: FormHelper.buildInputDecoration(
                                  controller: model.phoneNumberController,
                                  labelText: 'Phone Number',
                                ),
                                validator: (value) =>
                                    model.validate.phoneValidation(value),
                                onChanged: (value) =>
                                    customer.phoneNumber = value.trim(),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: FormHelper.formFieldSpacing),

                        //Password
//                          TextFormField(
//                            keyboardType: TextInputType.number,
//                            controller: passwordController,
//                            decoration: FormHelper.buildInputDecoration(
//                                controller: passwordController,
//                                labelText: 'Password'),
//                            validator: (value) =>
//                                model.validate.passwordValidation(value),
//                            onChanged: (value) => _customer.password = value,
//                            obscureText: true,
//                          ),
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
                                  inspect(customer);

                                  //If verification passes, proceed to phone verification phase
                                  if (model.validate.formValidation(_formKey)) {
                                    //TODO: Initiate update details
                                  }
                                },
                                buttonType: ButtonType.Primary,
                              )

                            //When busy, show the progress indicator button
                            : AppProgressButton(
                                buttonType: ButtonType.Primary,
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
    });
  }
}
