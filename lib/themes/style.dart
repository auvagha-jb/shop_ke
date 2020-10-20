import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    // This is the theme of your application.
    primarySwatch: Colors.red,
    // This makes the visual density adapt to the platform that you run
    // the app on. For desktop platforms, the controls will be smaller and
    // closer together (more dense) than on mobile platforms.
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: Color(0xffd9534f),
    accentColor: Colors.black,
    backgroundColor: Colors.white,
    canvasColor: Colors.white,//Colors.grey[100]
  );
}
