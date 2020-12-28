import 'package:flutter/material.dart';

class DrawerItem {
  final Icon icon;
  final String title;
  final Function onPressed;

  DrawerItem(
      {@required this.icon, @required this.title, @required this.onPressed})
      : assert(icon != null),
        assert(title != null),
        assert(onPressed != null);
}
