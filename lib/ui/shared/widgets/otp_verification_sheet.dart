import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/user_action.dart';
import 'package:shop_ke/core/enums/view_state.dart';
import 'package:shop_ke/core/view_models/authentication_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/buttons/app_progress_button.dart';
import 'package:shop_ke/ui/shared/forms/form_helper.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';
import 'package:shop_ke/ui/views/base_view.dart';

import '../containers/curved_sheet_container.dart';

class OTPVerificationSheet extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final UserAction action;

  OTPVerificationSheet(
      {@required this.phoneNumber,
      @required this.verificationId,
      @required this.action});

  @override
  _OTPVerificationSheetState createState() => _OTPVerificationSheetState();
}

class _OTPVerificationSheetState extends State<OTPVerificationSheet> {
  final _formKey = GlobalKey<FormState>();
  final color = Colors.black.withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthenticationViewModel>(
      builder: (context, model, child) => SingleChildScrollView(
        child: CurvedSheetContainer(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                //Header
                Text('Verify your number', style: darkHeader2),
                Divider(color: Colors.grey),

                //Sub header
                Text('Enter the code sent to ${widget.phoneNumber}'),

                SizedBox(height: FormHelper.formFieldSpacing),

                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: model.codeController,
                  autofocus: true,
                  decoration: InputDecoration(labelText: 'Code'),
                  validator: (value) => model.validate.codeValidation(value),
                ),

                SizedBox(height: FormHelper.formFieldSpacing),

                model.state == ViewState.Idle
                    ?
                    //Button in idle state
                    AppButton(
                        onPressed: () {
                          model.manualPhoneAuthentication(
                            formKey: _formKey,
                            verificationId: widget.verificationId,
                            context: context,
                            action: widget.action,
                          );
                        },
                        buttonType: ButtonType.Primary,
                        text: 'VERIFY',
                      )
                    :
                    //Button in busy state
                    AppProgressButton(buttonType: ButtonType.Primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
