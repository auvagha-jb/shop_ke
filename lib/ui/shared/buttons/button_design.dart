import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';
import 'package:shop_ke/core/models/button_color.dart';

class ButtonDesign {
  static final buttonTextSize = 15.0;
  static final buttonRadius = 25.0;
  static final buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(buttonRadius),
  );
  static const iconPadding = 8.0;

  //Pick button according to the theme
  static ButtonColor chooseColor(BuildContext context, ButtonType buttonType) {
    ButtonColor buttonColor;
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;

    switch (buttonType) {
      case ButtonType.Light:
        buttonColor =
            ButtonColor(backgroundColor: Colors.white, textColor: primaryColor);
        break;

      case ButtonType.Primary:
        buttonColor =
            ButtonColor(backgroundColor: primaryColor, textColor: Colors.white);
        break;

      case ButtonType.Secondary:
        buttonColor =
            ButtonColor(backgroundColor: Colors.black, textColor: Colors.white);
        break;

      case ButtonType.Accent:
        buttonColor =
            ButtonColor(backgroundColor: accentColor, textColor: Colors.white);
        break;

      default:
        buttonColor =
            ButtonColor(backgroundColor: primaryColor, textColor: Colors.white);
        break;
    }
    return buttonColor;
  }

  static TextStyle getTextStyle(Color color) {
    return TextStyle(
        fontSize: buttonTextSize, fontWeight: FontWeight.bold, color: color);
  }
}
