import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  final String alertTitle;
  final String alertButton;
  final String alertBody;

  AppDialog(
      {@required this.alertTitle,
      @required this.alertButton,
      @required this.alertBody});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(alertTitle),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(alertBody),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(alertButton),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
