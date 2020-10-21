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
                iconType: IconType.Accent,
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
                          Row(
                            children: [
                              Text('Welcome to ', style: lightHeader1),
                              Text('Shop ', style: darkHeader1),
                              Text('KE', style: accentHeader1),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Your once stop shop for the best local products at prices you\'ll love',
                            style: lightSubHeader,
                          ),
                        ],
                      ),
                    ),

                    AppButton(
                      buttonType: ButtonType.Secondary,
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
