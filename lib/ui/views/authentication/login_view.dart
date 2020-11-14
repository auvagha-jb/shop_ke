import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/firestore_models/customer.dart';
import 'package:shop_ke/core/view_models/authentication_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/views/authentication/sign_up_view.dart';
import 'package:shop_ke/ui/views/reset_password_view.dart';

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

  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();

  final textFieldSpacing = 15.0;
  final appBar = AppBar(
    title: Text('Sign in'),
  );

  @override
  Widget build(BuildContext context) {
    final viewPortHeight = MediaQuery.of(context).size.height;
    final verticalPadding = (viewPortHeight) / 4.5;

    return BaseView<AuthenticationViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(horizontal: 15, vertical: verticalPadding),

            //The master column holding both halves of the screen
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //The top half of the form

                  Column(
                    children: [
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(ResetPasswordView.routeName, arguments: emailAddressController.text);
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: FormHelper.formFieldSpacing * 5),

                  /* The bottom half of the login page */
                  //Submit button and register link section
                  ResponsiveContainer(
                    appBar: appBar,
                    height: 0.3,
                    child: Column(
                      children: <Widget>[
                        model.state == ViewState.Idle
                            ?
                            //Submit button
                            AppButton(
                                text: 'LOG IN',
                                buttonType: ButtonType.Secondary,
                                onPressed: () {
                                  model.login(_formKey, _customer);
                                },
                              )

                            //While the login process is ongoing
                            : AppProgressButton(
                                buttonType: ButtonType.Secondary,
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
