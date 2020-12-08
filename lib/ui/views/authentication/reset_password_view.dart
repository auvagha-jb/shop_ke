import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/models/data_models/customer.dart';
import 'package:shop_ke/core/view_models/authentication_view_model.dart';
import 'package:shop_ke/ui/shared/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/containers/responsive_container.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/views/general/base_view.dart';

class ResetPasswordView extends StatefulWidget {
  static const routeName = '/reset-password';
  final String email;

  const ResetPasswordView({Key key, this.email}) : super(key: key);

  @override
  _ResetPasswordViewState createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _customer = Customer();

  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();

  final textFieldSpacing = 15.0;

  @override
  void initState() {
    super.initState();
    emailAddressController.text = widget.email.isNotEmpty ? widget.email : '';
  }

  @override
  Widget build(BuildContext context) {
    final viewPortHeight = MediaQuery.of(context).size.height;
    final verticalPadding = (viewPortHeight) / 3.5;

    return BaseView<AuthenticationViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Reset Password'),
          ),
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
                    ],
                  ),

                  SizedBox(height: FormHelper.formFieldSpacing * 5),

                  /* The bottom half of the login page */
                  //Submit button and register link section
                  ResponsiveContainer(
                    appBar: AppBar(
                      title: Text('Reset Password'),
                    ),
                    height: 0.3,
                    child: Column(
                      children: <Widget>[
                        model.state == ViewState.Idle
                            ?
                        //Submit button
                        AppButton(
                          text: 'REQUEST PASSWORD RESET',
                          buttonType: ButtonType.Secondary,
                          onPressed: () {
                            model.resetPassword(
                                _formKey, emailAddressController.text);
                          },
                        )

                        //While the login process is ongoing
                            : AppProgressButton(
                          buttonType: ButtonType.Secondary,
                        ),
                        SizedBox(height: textFieldSpacing),
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
