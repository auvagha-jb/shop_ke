import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/customer.dart';
import 'package:shop_ke/core/view_models/authentication_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/views/authentication/sign_up_view.dart';

import '../base_view.dart';

class LoginView extends StatefulWidget {
  //final Function addTx;
  static const routeName = '/sign-in';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _customer = Customer();

  final phoneNumberController = TextEditingController();
  final countryCodeController = TextEditingController();

  final textFieldSpacing = 15.0;
  final appBar = AppBar(
    title: Text('Sign in'),
  );

  @override
  void initState() {
    super.initState();
    countryCodeController.text = "+254";
    _customer.countryCode = countryCodeController.text;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthenticationViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(15),

            //The master column holding both halves of the screen
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  //The top half of the form

                  ResponsiveContainer(
                    appBar: appBar,
                    height: 0.6,
                    //margin: EdgeInsets.only(bottom: 100),
                    child: //Phone number row
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
                            keyboardType: TextInputType.phone,
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
                  ),

                  /* The bottom half of the login page */
                  //Submit button and register link section
                  ResponsiveContainer(
                    appBar: appBar,
                    height: 0.4,
                    child: Column(
                      children: <Widget>[
                        model.state == ViewState.Idle
                            ?
                            //Submit button
                            //TODO: Show when the password is incorrect or the number is not registered
                            AppButton(
                                text: 'LOG IN',
                                buttonType: ButtonType.Primary,
                                onPressed: () {
                                  model.login(
                                    context: context,
                                    formKey: _formKey,
                                    phoneNumber: '${_customer.fullPhoneNumber}',
                                  );
                                },
                              )

                            //While the login process is ongoing
                            : AppProgressButton(
                                buttonType: ButtonType.Primary,
                              ),

                        SizedBox(height: textFieldSpacing),

                        //Link to SignUpView
                        RegisterLink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RegisterLink extends StatelessWidget {
  const RegisterLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Don\'t have an account?'),
        SizedBox(width: 2),
        InkWell(
          child: Text(
            'Register',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          onTap: () {
            Navigator.of(context).pushNamed(SignUpView.routeName);
          },
        ),
      ],
    );
  }
}
