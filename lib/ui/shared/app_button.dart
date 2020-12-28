import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/models/app_models/button_color.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final ButtonType buttonType;
  final String text;

  const AppButton({
    Key key,
    @required this.text,
    @required this.buttonType,
    @required this.onPressed,
  }) : super(key: key);

  ButtonColor chooseColor(BuildContext context) {
    ButtonColor buttonColor;
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;

    switch (buttonType) {
      case ButtonType.Light:
        buttonColor =
            ButtonColor(backgroundColor: Colors.white, textColor: Colors.black);
        break;

      case ButtonType.Primary:
        buttonColor =
            ButtonColor(backgroundColor: primaryColor, textColor: Colors.black);
        break;

      case ButtonType.Secondary:
        buttonColor =
            ButtonColor(backgroundColor: Colors.black, textColor: Colors.white);
        break;
      case ButtonType.Accent:
        buttonColor =
            ButtonColor(backgroundColor: accentColor, textColor: Colors.white);
        break;
    }

    return buttonColor;
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = chooseColor(context);

    return Container(
      width: double.infinity,
      height: 45.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        color: buttonColor.backgroundColor,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: buttonColor.textColor),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: onPressed,
      ),
    );
  }
}
