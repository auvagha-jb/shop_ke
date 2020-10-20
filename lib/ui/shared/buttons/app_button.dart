import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';

import 'base_button.dart';
import 'button_design.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final ButtonType buttonType;
  final String text;
  final dynamic icon;

  const AppButton({
    Key key,
    @required this.text,
    @required this.buttonType,
    @required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = ButtonDesign.chooseColor(context, buttonType);
    return BaseButton(
      child: FlatButton(
        color: buttonColor.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Display leading icon if present
            icon != null
                ? Padding(
                    padding: const EdgeInsets.all(ButtonDesign.iconPadding),
                    child: icon,
                  )
                : Text(''),
            //The button text
            Text(
              text,
              style: ButtonDesign.getTextStyle(buttonColor.textColor),
            ),
          ],
        ),
        shape: ButtonDesign.buttonShape,
        onPressed: onPressed,
      ),
    );
  }
}
