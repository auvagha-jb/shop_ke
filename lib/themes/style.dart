import 'package:flutter/material.dart';
import 'package:shop_ke/themes/custom_colors.dart';

ThemeData lightTheme() {
  return ThemeData(
    // This is the theme of your application.
    primarySwatch: Colors.red,
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: CustomColors.red,//0xff specifies full opacity
    accentColor: CustomColors.green,
    backgroundColor: Colors.black,
    canvasColor: Colors.white,//Colors.grey[100]
  );
}
