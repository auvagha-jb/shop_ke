import 'package:flutter/material.dart';
import 'package:shop_ke/core/enums/button_type.dart';

import 'base_button.dart';
import 'button_design.dart';

class AppProgressButton extends StatelessWidget {
  final ButtonType buttonType;

  const AppProgressButton({
    Key key,
    @required this.buttonType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonColor = ButtonDesign.chooseColor(context, buttonType);
    return BaseButton(
      child: RaisedButton(
        color: buttonColor.backgroundColor,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        shape: ButtonDesign.buttonShape,
        onPressed: () {},
      ),
    );
  }
}
