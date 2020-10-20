import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppFlushbar {
  static void show(
    context, {
    @required String title,
    @required String message,
      @required Icon icon,
    Widget mainButton,
      }) {
    
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: Colors.black,
      boxShadows: [
        BoxShadow(
            color: Colors.blue[800], offset: Offset(0.0, 2.0), blurRadius: 3.0)
      ],
      backgroundGradient:
          LinearGradient(colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor]),
      isDismissible: true,
      duration: Duration(seconds: 5),
      icon: icon,
      mainButton: null,
      showProgressIndicator: true,
      progressIndicatorBackgroundColor: Theme.of(context).primaryColor,
    )..show(context);
  }
}


