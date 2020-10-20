import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/enums/icon_type.dart';
import 'package:shop_ke/core/view_models/home_view_model.dart';
import 'package:shop_ke/ui/shared/buttons/app_button.dart';
import 'package:shop_ke/ui/shared/utils/text_styles.dart';
import 'package:shop_ke/ui/shared/widgets/app_icon.dart';

import 'authentication/login_view.dart';
import 'authentication/sign_up_view.dart';
import 'base_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            //The top half containing the logo
            Expanded(
              flex: 4,
              child: AppIcon(
                iconType: IconType.Primary,
              ),
            ),

            //The bottom half
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Text('Welcome to Project Pay', style: lightHeader1),
                          SizedBox(height: 8.0),
                          Text(
                            'Quick checkouts so you have time for what really matters',
                            style: lightSubHeader,
                          ),
                        ],
                      ),
                    ),

                    AppButton(
                      buttonType: ButtonType.Light,
                      //icon: Image.asset('assets/images/google_logo.png'),
                      text: 'SIGN IN WITH EXISTING ACCOUNT',
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginView.routeName);
                      },
                    ),

                    //Continue with email address
                    AppButton(
                      text: 'CREATE NEW ACCOUNT',
                      buttonType: ButtonType.Light,
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUpView.routeName);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
