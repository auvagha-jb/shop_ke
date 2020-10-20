import 'package:flutter/material.dart';

const headerStyle = TextStyle(fontSize: 35, fontWeight: FontWeight.w900);
const subHeaderStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

class TextStyles {
  final BuildContext context;
  TextStyles(this.context);

  static const darkHeader1 = TextStyle(fontSize: 35, fontWeight: FontWeight.w900);
  static const darkHeader2 = TextStyle(fontSize: 23.0, fontWeight: FontWeight.w500);
  static const darkSubHeader = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);

  static const lightHeader1 = TextStyle(fontSize: 35, fontWeight: FontWeight.w900, color: Colors.white);
  static const lightHeader2 = TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.white);
  static const lightSubHeader = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.white);
}