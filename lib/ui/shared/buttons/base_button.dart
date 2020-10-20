import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final Widget child;
  BaseButton({Key key, @required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.0,
      width: double.infinity,
//      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: child,
    );
  }
}
